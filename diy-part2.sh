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

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
#echo  'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
#echo  'src-git small https://github.com/kenzok8/small' >>feeds.conf.default
#echo  'src-git small8 https://github.com/kenzok8/small-package' >>feeds.conf.default
sed -i '$a src-git smpackage https://github.com/kenzok8/small-package' feeds.conf.default

# themes
git clone https://github.com/rosywrt/luci-theme-rosy/tree/openwrt-18.06/luci-theme-rosy.git package/luci-theme-rosy
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git package/luci-theme-infinityfreedom
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd

# modify extra package
rm -rf feeds/packages/lang/rust
git_sparse_clone master https://github.com/openwrt/packages/lang/rust package/rust
rm -rf package/lean/libcryptopp
git_sparse_clone main https://github.com/very20101/Openwrt_N1_try/libcryptopp package/libcryptopp
rm -rf package/feeds/packages/ruby
git_sparse_clone master https://github.com/openwrt/packages/lang/ruby  package/ruby
rm -rf feeds/packages/net/unbound
git_sparse_clone master https://github.com/openwrt/packages/net/unbound package/unbound
rm -rf feeds/small8/shadowsocks-rust
git_sparse_clone main https://github.com/xiaorouji/openwrt-passwall-packages/shadowsocks-rust package/shadowsocks-rust
rm -rf package/feeds/packages/xfsprogs
git_sparse_clone master https://github.com/openwrt/packages/utils/xfsprogs package/xfsprogs

./scripts/feeds update -a
./scripts/feeds install -a
