# OpenWRT-CI

基于 [VIKINGYFY/OpenWRT-CI](https://github.com/VIKINGYFY/OpenWRT-CI) 二次开发，集成 kenzok8 大鹅代理(daede)。

## 分支说明

| 分支 | 说明 |
|------|------|
| **main** | 同步上游 VIKINGYFY，不做额外修改 |
| **test** | 🧪 daede 集成 + kwrum1 优化 + 其他调整 |

## test 分支新增功能

- 🔥 集成 [kenzok8/openwrt-daede](https://github.com/kenzok8/openwrt-daede) — dae + daed + luci-app-daede
- ⚡ SKB 回收优化（dae/daed 受益）
- 🧠 内核 eBPF/BTF 支持
- 📦 Release 命名带 `daede` 标签
- 🔧 Qualcommax: 内核扩容至 12288k + NSS 启动顺序修复
- 🚫 MTK-ALL 禁用自动触发

## 源码

- 官方版：https://github.com/immortalwrt/immortalwrt.git
- 自用版(VIKINGYFY)：https://github.com/VIKINGYFY/immortalwrt.git

## U-BOOT

高通版-沉心：
- https://github.com/chenxin527/uboot-ipq60xx-emmc-build.git
- https://github.com/chenxin527/uboot-ipq60xx-nand-build.git
- https://github.com/chenxin527/uboot-ipq60xx-nor-build.git

高通版-小猪：
- https://github.com/1980490718/u-boot-2016.git

联发科-全新版：https://github.com/VIKINGYFY/UBOOT-CI/releases

联发科-官方版：https://drive.wrt.moe/uboot/mediatek

## 目录说明

| 目录 | 说明 |
|------|------|
| `.github/workflows/` | CI 工作流配置 |
| `Config/` | OpenWrt .config 片段 |
| `Scripts/` | 自定义脚本（包管理、固件定制） |

## 固件说明

- 固件每天早上 5 点自动编译（UTC+8）
- 固件信息里的时间为编译开始的时间
- 支持平台：MEDIATEK / QUALCOMMAX / ROCKCHIP / X86
