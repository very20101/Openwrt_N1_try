#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# Code from https://github.com/breakings/openwrt
# Code from https://github.com/haiibo/openwrt
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

echo "开始 DIY 配置……"
echo "========================="

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
#echo  'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
#echo  'src-git small https://github.com/kenzok8/small' >>feeds.conf.default
#echo  'src-git small8 https://github.com/kenzok8/small-package' >>feeds.conf.default
#sed -i '$a src-git smpackage https://github.com/kenzok8/small-package' feeds.conf.default

# themes
git clone https://github.com/rosywrt/luci-theme-rosy/tree/openwrt-18.06/luci-theme-rosy.git package/luci-theme-rosy
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git package/luci-theme-infinityfreedom
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd

# modify extra package
#rm -rf feeds/packages/lang/rust
#merge_package https://github.com/openwrt/packages packages/lang/rust
#rm -rf package/lean/libcryptopp
#merge_package https://github.com/very20101/Openwrt_N1_try Openwrt_N1_try/libcryptopp
#rm -rf package/feeds/packages/ruby
#merge_package https://github.com/openwrt/packages  packages/lang/ruby
#rm -rf feeds/packages/net/unbound
#merge_package https://github.com/openwrt/packages packages/net/unbound
#rm -rf feeds/smpackage/shadowsocks-rust
#merge_package https://github.com/very20101/Openwrt_N1_try/general general/shadowsocks-rust
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/shadowsocks-rust
#rm -rf package/feeds/packages/xfsprogs
#merge_package https://github.com/openwrt/packages packages/utils/xfsprogs
#sed -i 's/TARGET_CFLAGS += -DHAVE_MAP_SYNC/TARGET_CFLAGS += -DHAVE_MAP_SYNC -D_LARGEFILE64_SOURCE/' feeds/packages/utils/xfsprogs/Makefile

# golang 
  #rm -rf feeds/packages/lang/golang
  #git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
 # rm -rf feeds/packages/lang/golang
 # git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

##luci-app-turboacc  
#git clone -b main https://github.com/very20101/Openwrt_N1_try package/op-N1_try
#mv package/op-N1_try/package_extra/shortcut-fe package/shortcut-fe

##luci-app-diskman
git clone https://github.com/very20101/openwrt_N1_test package/openwrt_N1_test
#mv package/op-N1_try/package_extra/luci-app-diskman package/luci-app-diskman

##luci-app-adblock
rm -rf feeds/packages/net/adblock feeds/luci/applications/luci-app-adblock
cp -rf package/openwrt_N1_test/extra_pack/adblock feeds/packages/net/adblock
rm -rf feeds/luci/applications/luci-app-adblock
cp -rf package/openwrt_N1_test/extra_pack/luci-app-adblock feeds/luci/applications/luci-app-adblock
rm -rf feeds/packages/net/miniupnpc
cp -rf package/openwrt_N1_test/extra_pack/miniupnpc feeds/packages/net/miniupnpc
rm -rf feeds/packages/net/miniupnpd
cp -rf package/openwrt_N1_test/extra_pack/miniupnpd feeds/packages/net/miniupnpd

## package/system/openwrt-keyring
rm -rf package/system/openwrt-keyring
cp -rf package/openwrt_N1_test/extra_pack/openwrt-keyring package/system/openwrt-keyring

rm -rf package/openwrt_N1_test

rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd*,miniupnpd-iptables,wireless-regdb}

./scripts/feeds update -a
./scripts/feeds install -f

echo "============================"
echo " DIY 配置完成……"
