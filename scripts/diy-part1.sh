#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

#添加adguardhome
#git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome

#添加ssrplus
#git clone https://github.com/fw876/helloworld.git package/helloworld

#添加lienol包
#git clone https://github.com/Gabrielxzx/lienol-openwrt-package.git package/lienol
#git clone https://github.com/xiaorouji/openwrt-package.git  package/lienol/

#添加整合包
git clone https://github.com/kenzok8/small.git package/small
git clone https://github.com/kenzok8/openwrt-packages.git package/kenzok8

#添加luci-app-dockerman
git clone https://github.com/lisaac/luci-app-dockerman.git package/dockerman

#添加luci-app-godproxy
git clone https://github.com/project-lede/luci-app-godproxy.git package/luci-app-godproxy
#git clone https://github.com/Gabrielxzx/luci-app-godproxy.git package/luci-app-godproxy

#添加luci-app-vssr   #kenzok8整合包中已有
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
#git clone https://github.com/jerrykuku/luci-app-vssr.git package/vssr
# DownLoad OpenClash
mkdir package/luci-app-openclash
cd package/luci-app-openclash
git init
git remote add -f origin https://github.com/vernesong/OpenClash.git
git config core.sparsecheckout true
echo "luci-app-openclash" >> .git/info/sparse-checkout
git pull origin master
git branch --set-upstream-to=origin/master master
cd -
# integration clash core 实现编译更新后直接可用，不用手动下载clash内核
curl -sL -m 30 --retry 2 https://github.com/vernesong/OpenClash/releases/download/Clash/clash-linux-amd64.tar.gz -o /tmp/clash.tar.gz
tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p package/luci-app-openclash/luci-app-openclash/files/etc/openclash/core
mv /tmp/clash package/luci-app-openclash/luci-app-openclash/files/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1

#更新feeds
./scripts/feeds update -a
#安装feeds
./scripts/feeds install -a
