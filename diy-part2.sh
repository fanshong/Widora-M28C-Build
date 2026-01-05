#!/bin/bash
# diy-part2.sh

# 1. 移除冲突软件包 (优先使用 Kenzo 源的版本)
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/adguardhome
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-adguardhome
rm -rf feeds/luci/applications/luci-app-openclash

# 2. 修正 Golang 版本 (编译 AdGuardHome 必须)
./scripts/feeds install -p small golang

# 3. 设置默认主题为 Design
# 修改 luci 默认配置
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-argon/luci-theme-design/g' feeds/luci/collections/luci/Makefile

# 4. 修改默认 LAN IP (可选，防止冲突)
sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate
