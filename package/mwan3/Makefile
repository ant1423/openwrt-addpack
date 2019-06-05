#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mwan3
PKG_VERSION:=1.6
PKG_RELEASE:=2
PKG_MAINTAINER:=Jeroen Louwes <jeroen.louwes@gmail.com>
PKG_LICENSE:=GPLv2

include $(INCLUDE_DIR)/package.mk

define Package/mwan3
   SECTION:=net
   CATEGORY:=Network
   SUBMENU:=Routing and Redirection
   DEPENDS:=+!PACKAGE_ip-full:ip +ipset +iptables +iptables-mod-ipmark +iptables-mod-conntrack-extra +iptables-mod-ipopt +kmod-macvlan
   TITLE:=Multiwan hotplug script with connection tracking support
   MAINTAINER:=Jeroen Louwes <jeroen.louwes@gmail.com>
   PKGARCH:=all
endef

define Package/mwan3/description
Hotplug script which makes configuration of multiple WAN interfaces simple
and manageable. With loadbalancing/failover support for up to 250 wan
interfaces, connection tracking and an easy to manage traffic ruleset.
endef

define Package/mwan3/conffiles
/etc/config/mwan3
endef

define Build/Compile
endef

define Package/mwan3/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/mwan3.config $(1)/etc/config/mwan3
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN) ./files/15-mwan3.hotplug $(1)/etc/hotplug.d/iface/15-mwan3
endef

$(eval $(call BuildPackage,mwan3))
