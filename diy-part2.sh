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
  sed -i 's/192.168.1.1/192.168.1.200/g' package/base-files/files/bin/config_generate
# kernel
  #sed -i "s/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=5.10/g" target/linux/armvirt/Makefile
  #sed -i "s/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.15/g" target/linux/armvirt/Makefile

#sagernet-core
  #sed -i 's|$(LN) v2ray $(1)/usr/bin/xray|#$(LN) v2ray $(1)/usr/bin/xray|g' feeds/small8/sagernet-core/Makefile
  #sed -i 's|CONFLICTS:=v2ray-core xray-core|#CONFLICTS:=v2ray-core xray-core|g' feeds/small8/sagernet-core/Makefile

echo "开始 DIY 配置……"
echo "========================="

function merge_package(){
    repo=`echo $1 | rev | cut -d'/' -f 1 | rev`
    pkg=`echo $2 | rev | cut -d'/' -f 1 | rev`
    find package/ -follow -name $pkg -not -path "package/custom/*" | xargs -rt rm -rf
    git clone --depth=1 --single-branch $1
    mv $2 package/custom/
    rm -rf $repo
}
function drop_package(){
    find package/ -follow -name $1 -not -path "package/custom/*" | xargs -rt rm -rf
}
function merge_feed(){
    if [ ! -d "feed/$1" ]; then
        echo >> feeds.conf.default
        echo "src-git $1 $2" >> feeds.conf.default
    fi
    ./scripts/feeds update $1
    ./scripts/feeds install -a -p $1
}
rm -rf package/custom; mkdir package/custom

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
sed -i 's/TARGET_CFLAGS += -DHAVE_MAP_SYNC/TARGET_CFLAGS += -DHAVE_MAP_SYNC -D_LARGEFILE64_SOURCE/' feeds/packages/utils/xfsprogs/Makefile

# golang 
  #rm -rf feeds/packages/lang/golang
  #git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
 # rm -rf feeds/packages/lang/golang
 # git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

##luci-app-turboacc  
#git clone -b main https://github.com/very20101/Openwrt_N1_try package/op-N1_try
#mv package/op-N1_try/package_extra/shortcut-fe package/shortcut-fe

##luci-app-diskman
git clone -b main https://github.com/very20101/Openwrt_N1_try package/op-N1_try
mv package/op-N1_try/package_extra/luci-app-diskman package/luci-app-diskman

##luci-app-adblock
rm -rf feeds/packages/net/adblock feeds/luci/applications/luci-app-adblock
cp -rf package/op-N1_try/package_extra/adblock feeds/packages/net/adblock
cp -rf package/op-N1_try/package_extra/luci-app-adblock feeds/luci/applications/luci-app-adblock

rm -rf package/op-N1_try

./scripts/feeds update -a
./scripts/feeds install -f

echo "============================"
echo " DIY 配置完成……"
