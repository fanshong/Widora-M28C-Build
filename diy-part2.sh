#!/bin/bash
# diy-part2.sh

# 1. 移除系统自带的旧版 Go (关键步骤！)
# OpenWrt 23.05 默认 Go 版本太老，会导致 v2dat 等插件编译失败
rm -rf feeds/packages/lang/golang

# 2. 拉取 Kenzo 源的高版本 Go
# 这一步会把 Go 1.22/1.23 安装进来，解决 "requires go >= 1.22" 错误
./scripts/feeds install -p small golang

# 3. 移除其他冲突软件包 (优先使用 Kenzo 源的版本)
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/adguardhome
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-adguardhome
rm -rf feeds/luci/applications/luci-app-openclash

# 4. 再次安装 small 源的 golang (双重保险，确保链接正确)
./scripts/feeds install -p small golang

# 5. 设置默认主题为 Design
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-argon/luci-theme-design/g' feeds/luci/collections/luci/Makefile

# 6. (可选) 强制拉取风扇控制源码 (防止源里没有)
#git clone https://github.com/garypang13/luci-app-fan.git package/luci-app-fan
