#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo  'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
echo  'src-git small https://github.com/kenzok8/small' >>feeds.conf.default
echo  'src-git packages https://github.com/coolsnowwolf/packages' >>feeds.conf.default
echo  'src-git luci https://github.com/coolsnowwolf/luci' >>feeds.conf.default
#src-git routing https://git.openwrt.org/feed/routing.git
echo  'src-git routing https://github.com/coolsnowwolf/routing' >>feeds.conf.default
echo  'src-git telephony https://git.openwrt.org/feed/telephony.git' >>feeds.conf.default
#src-git video https://github.com/openwrt/video.git
#src-git targets https://github.com/openwrt/targets.git
#src-git oldpackages http://git.openwrt.org/packages.git
#src-link custom /usr/src/openwrt/custom-feed


# themes
git clone https://github.com/rosywrt/luci-theme-rosy/tree/openwrt-18.06/luci-theme-rosy.git package/luci-theme-rosy
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git package/luci-theme-infinityfreedom
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
