#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (C) 2026 VIKINGYFY

#移除luci-app-attendedsysupgrade
find ./feeds/luci/collections/ -type f -name "Makefile" -exec sed -i "/attendedsysupgrade/d" {} +
#修改默认主题
find ./feeds/luci/collections/ -type f -name "Makefile" -exec sed -i "s/luci-theme-bootstrap/luci-theme-$WRT_THEME/g" {} +
#修改immortalwrt.lan关联IP
find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js" -exec sed -i "s/192\.168\.[0-9]*\.[0-9]*/$WRT_IP/g" {} +
#添加编译日期标识
find ./feeds/luci/modules/luci-mod-status/ -type f -name "10_system.js" -exec sed -i "s/(\(luciversion || ''\))/(\1) + (' \/ Built by Superman')/g" {} +

#修改默认WIFI账号密码
WIFI_UC="./package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc"
ROUTER_TOOL="./package/emortal/luci-app-router-tool/root/etc/config/router-tool"
ROUTER_WIRELESS="./package/emortal/luci-app-router-tool/root/usr/share/router-tool/wireless.uc"
if [ -f "$ROUTER_TOOL" ] && [ -f "$ROUTER_WIRELESS" ]; then
	#保留mac80211初始SSID和密码，供router-tool识别并应用信道、带宽及加密预设
	sed -i "s/ssid '.*'/ssid '$WRT_SSID'/g; s/key '.*'/key '$WRT_WORD'/g" "$ROUTER_TOOL"
	#仅2.4GHz使用自定义SSID原名；其他频段继续使用上游后缀规则
	if ! grep -Fq "if (custom_ssid && suffix == '2.4G') return custom_ssid;" "$ROUTER_WIRELESS"; then
		if ! grep -Fq 'function default_ssid(uci, board, suffix, custom_ssid) {' "$ROUTER_WIRELESS"; then
			echo "router-tool default_ssid changed; cannot apply 2.4GHz SSID customization" >&2
			exit 1
		fi
		sed -i "/^function default_ssid(uci, board, suffix, custom_ssid) {/a\\\tif (custom_ssid \&\& suffix == '2.4G') return custom_ssid;" "$ROUTER_WIRELESS"
	fi
elif [ -f "$WIFI_UC" ]; then
	#没有router-tool无线初始化逻辑时，直接设置mac80211默认值
	#兼容源码中等号赋值和空格分隔的两种WIFI配置格式
	sed -i "s/ssid='.*'/ssid='$WRT_SSID'/g; s/key='.*'/key='$WRT_WORD'/g; s/ssid '.*'/ssid '$WRT_SSID'/g; s/key '.*'/key '$WRT_WORD'/g" "$WIFI_UC"
	#修改WIFI地区为美国
	sed -i "s|^set \${s}\.country=.*|set \${s}.country='US'|" "$WIFI_UC"
fi

CFG_FILE="./package/base-files/files/bin/config_generate"
#修改默认IP地址
sed -i "s/192\.168\.[0-9]*\.[0-9]*/$WRT_IP/g" $CFG_FILE
#修改默认主机名
sed -i "s/hostname='.*'/hostname='$WRT_NAME'/g" $CFG_FILE

#配置文件修改
echo "CONFIG_PACKAGE_luci=y" >> ./.config
echo "CONFIG_LUCI_LANG_zh_Hans=y" >> ./.config
echo "CONFIG_PACKAGE_luci-theme-$WRT_THEME=y" >> ./.config
echo "CONFIG_PACKAGE_luci-app-$WRT_THEME=y" >> ./.config
echo "CONFIG_PACKAGE_luci-app-$WRT_THEME-config=y" >> ./.config

#引入私有扩展配置
if [ -f "$GITHUB_WORKSPACE/Config/PRIVATE.txt" ]; then
	echo "Applying private configurations from PRIVATE.txt..."
	cat $GITHUB_WORKSPACE/Config/PRIVATE.txt >> ./.config
fi

#手动调整的插件
if [ -n "$WRT_PACKAGE" ]; then
	echo -e "$WRT_PACKAGE" >> ./.config
fi

#高通平台调整
DTS_PATH="./target/linux/qualcommax/dts/"
if [[ "${WRT_TARGET^^}" == *"QUALCOMMAX"* ]]; then
	#无WIFI配置调整Q6大小
	if [[ "$WRT_WIFI" == "WIFI-NO" ]]; then
		find $DTS_PATH -type f ! -iname '*nowifi*' -exec sed -i 's/ipq\(6018\|8074\).dtsi/ipq\1-nowifi.dtsi/g' {} +
		echo "qualcommax set up nowifi successfully!"
	fi
fi
