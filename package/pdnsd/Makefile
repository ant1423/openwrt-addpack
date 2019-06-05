include $(TOPDIR)/rules.mk

PKG_NAME:=pdnsd
PKG_VERSION:=1.2.9a-par
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/pdnsd
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  DEPENDS:=+libpthread
  TITLE:=Proxy DNS Server
endef

define Package/pdnsd/description
  pdnsd, is an IPv6 capable proxy DNS server with permanent caching (the cache
  contents are written to hard disk on exit) that is designed to cope with
  unreachable or down DNS servers (for example in dial-in networking).

  pdnsd can be used with applications that do dns lookups, eg on startup, and
  can't be configured to change that behaviour, to prevent the often
  minute-long hangs (or even crashes) that result from stalled dns queries.
endef

TARGET_CFLAGS += -I$(STAGING_DIR)/usr/include
#TARGET_CFLAGS += -ggdb3

CMAKE_OPTIONS += -DDEBUG=1

CONFIGURE_ARGS += \
		--with-cachedir=/var/pdnsd

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
	$(call Build/Prepare/Default)
endef

define Package/pdnsd/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pdnsd $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pdnsd-ctl/pdnsd-ctl $(1)/usr/bin/

	
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/doc/pdnsd.conf $(1)/etc/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/pdnsd.init $(1)/etc/init.d/pdnsd

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/pdnsd.config $(1)/etc/config/pdnsd
endef

$(eval $(call BuildPackage,pdnsd))
