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
#echo  'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
#echo  'src-git small https://github.com/kenzok8/small' >>feeds.conf.default
 echo  'src-git small8 https://github.com/kenzok8/small-package' >>feeds.conf.default



# themes
git clone https://github.com/rosywrt/luci-theme-rosy/tree/openwrt-18.06/luci-theme-rosy.git package/luci-theme-rosy
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git package/luci-theme-infinityfreedom
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd

# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
  sed -i 's/192.168.1.1/192.168.1.100/g' package/base-files/files/bin/config_generate
# kernel
  #sed -i "s/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=5.10/g" target/linux/armvirt/Makefile
  #sed -i "s/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.15/g" target/linux/armvirt/Makefile

#sagernet-core
  #sed -i 's|$(LN) v2ray $(1)/usr/bin/xray|#$(LN) v2ray $(1)/usr/bin/xray|g' feeds/small8/sagernet-core/Makefile
  #sed -i 's|CONFLICTS:=v2ray-core xray-core|#CONFLICTS:=v2ray-core xray-core|g' feeds/small8/sagernet-core/Makefile