# 高质量<免费>交流群

[IPQ技术讨论群](https://qm.qq.com/q/v7nMhzB4oU)

# 高质量<付费>中转站

[LiBwrt-Ai](https://api.zipimg.cn/register?aff=FFPS3UMJ8HJD)

# 本地编译器

https://github.com/VIKINGYFY/OWRT-Tools.git

# 自用修改版插件

https://github.com/VIKINGYFY/packages.git

# OpenWRT-CI

## PPE 分支定制

本分支基于上游 `VIKINGYFY/OpenWRT-CI`，保留上游 CI 与多平台构建支持，并加入以下固件定制：

- 默认主机名：`HOMR`
- 默认 Wi-Fi 名称：`Superman`
- 默认 Wi-Fi 密码：`@1234567890`
- OWRT-ALL 与 QCA Wi-Fi 固件默认管理地址：`10.0.0.1`
- QCA 无 Wi-Fi 固件默认管理地址：`192.168.10.1`
- LuCI 系统页面编译标识：`Built by Superman`

### 预置服务

- AdGuard Home：DNS 去广告、查询日志与设备域名访问记录
- Aria2：HTTP/HTTPS、BT 种子、磁力链接和断点续传下载
- MosDNS：本地 DNS 分流与解析优化
- OpenAppFilter（OAF 6.1）：应用访问控制与网络管理

以上服务均已加入通用和测试固件配置；其中 OpenAppFilter 使用 `destan19/OpenAppFilter` 的 `oaf-6.1` 分支。

官方版：

https://github.com/immortalwrt/immortalwrt.git

自用版：

https://github.com/VIKINGYFY/immortalwrt.git

# U-BOOT

高通版-沉心：

https://github.com/chenxin527/uboot-qsdk12.5-build.git

高通版-小猪：

https://github.com/1980490718/u-boot-2016.git

联发科-全新版：

https://github.com/VIKINGYFY/UBOOT-CI/releases

联发科-官方版：

https://drive.wrt.moe/uboot/mediatek

# 固件简要说明

固件每天早上5点自动编译。

固件信息里的时间为编译开始的时间，方便核对上游源码提交时间。

MEDIATEK系列、QUALCOMMAX系列、ROCKCHIP系列、X86系列。

# 目录简要说明

workflows——自定义CI配置

Scripts——自定义脚本

Config——自定义配置

## Star History

<a href="https://www.star-history.com/?repos=vikingyfy%2Fopenwrt-ci&type=date&legend=top-left">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=vikingyfy/openwrt-ci&type=date&theme=dark&legend=top-left" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=vikingyfy/openwrt-ci&type=date&legend=top-left" />
   <img alt="Star History Chart" src="https://api.star-history.com/chart?repos=vikingyfy/openwrt-ci&type=date&legend=top-left" />
 </picture>
</a>
