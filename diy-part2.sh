#!/bin/bash
# diy-part2.sh

# --- 核心修复：解决 v2dat 找不到 golang-package.mk 的问题 ---

# 1. 删除 OpenWrt 自带的旧版 Go (这一步必须)
rm -rf feeds/packages/lang/golang

# 2. 【关键】直接把 Kenzo 的新版 Go 克隆到“原来的位置”
# 这样 v2dat 就能在它预期的路径下找到新版 Go 了
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# 3. 清理其他冲突插件
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/adguardhome
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-adguardhome
rm -rf feeds/luci/applications/luci-app-openclash

# 4. 再次执行安装，确保新克隆的 Go 被系统识别
./scripts/feeds install -p packages golang

# --- 主题与风扇修复 ---
# 设置 Design 为默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-argon/luci-theme-design/g' feeds/luci/collections/luci/Makefile

# 强制拉取风扇控制源码 (双重保险)
#git clone https://github.com/garypang13/luci-app-fan.git package/luci-app-fan
