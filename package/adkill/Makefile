#
# Copyright (C) 2006-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=adkill

PKG_VERSION:=git-20150808
PKG_RELEASE:=1
#PKG_SOURCE_URL:=https://github.com/981213/adkill.git

PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk


define KernelPackage/adkill
  SUBMENU:=Netfilter Extensions
  TITLE:=Kill video site adv
  FILES:=$(PKG_BUILD_DIR)/adv-kill.ko
  AUTOLOAD:=$(call AutoLoad,45,adv-kill)
endef

define KernelPackage/adkill/description
Kill video site adv
endef

SOURCE_DIR:=$(PKG_BUILD_DIR)
export SOURCE_DIR

MAKEOPTS:= -C $(LINUX_DIR) \
                ARCH="$(LINUX_KARCH)" \
                CROSS_COMPILE="$(TARGET_CROSS)" \
                M="$(PKG_BUILD_DIR)" \
		modules

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
	$(call Build/Prepare/Default)
endef


define Build/Compile
	$(MAKE) $(MAKEOPTS)
endef

define KernelPackage/adkill/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/conffile $(1)/etc/config/adkill
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init $(1)/etc/init.d/adkill
endef

$(eval $(call KernelPackage,adkill))
