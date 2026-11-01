include $(TOPDIR)/rules.mk

PKG_NAME:=astra-dns
# Keep the OpenWrt package version aligned with the cloned upstream Cargo project.
ASTRA_DNS_SOURCE_DIR:=$(TOPDIR)/package/astra-dns
PKG_VERSION:=$(shell awk -F '"' '/^version = / { print $$2; exit }' $(ASTRA_DNS_SOURCE_DIR)/Cargo.toml)
PKG_RELEASE:=1
PKG_LICENSE:=MIT Apache-2.0
PKG_MAINTAINER:=astra-sec

PKG_BUILD_DEPENDS:=rust/host
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/astra-dns
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=Astra DNS server
  DEPENDS:=+ca-bundle +libgcc
endef

define Package/astra-dns/description
 Rust-based forwarding and filtering DNS server.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	# Build from the upstream checkout cloned by Packages.sh; it has no OpenWrt Makefile.
	$(CP) $(ASTRA_DNS_SOURCE_DIR)/. $(PKG_BUILD_DIR)/
	find $(PKG_BUILD_DIR) -maxdepth 1 -name Makefile -delete
	rm -rf $(PKG_BUILD_DIR)/.git
endef

# rust-package.mk supplies the target-aware Cargo compile and install rules.
include $(TOPDIR)/feeds/packages/lang/rust/rust-package.mk

define Package/astra-dns/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/astra-dns $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/astra-dns
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/named.yaml $(1)/etc/astra-dns/named.yaml
endef

$(eval $(call RustBinPackage,astra-dns))
$(eval $(call BuildPackage,astra-dns))
