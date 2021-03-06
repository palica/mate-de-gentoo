# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MATE_LA_PUNT="yes"

inherit mate multilib

if [[ ${PV} != 9999 ]]; then
	KEYWORDS="~amd64 ~arm ~x86"
fi

DESCRIPTION="Personal file sharing for the MATE desktop"
LICENSE="GPL-2"
SLOT="0"

IUSE="X"

COMMON_DEPEND="
	>=dev-libs/dbus-glib-0.70:0
	>=dev-libs/glib-2.15.2:2
	>=mate-base/caja-1.17.1
	media-libs/libcanberra:0[gtk3]
	>=sys-apps/dbus-1.1.1:0
	>=x11-libs/gdk-pixbuf-2:2
	>=x11-libs/gtk+-3.14:3
	x11-libs/libX11:0
	x11-libs/pango:0
	>=x11-libs/libnotify-0.7:0
	virtual/libintl:0"

RDEPEND="${COMMON_DEPEND}
	>=www-apache/mod_dnssd-0.6:0
	>=www-servers/apache-2.2:2[apache2_modules_dav,apache2_modules_dav_fs,apache2_modules_authn_file,apache2_modules_auth_digest,apache2_modules_authz_groupfile]"

DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/yelp-tools:0
	>=dev-util/intltool-0.35:*
	sys-devel/gettext:*
	virtual/pkgconfig:*"

src_configure() {
	mate_src_configure \
		--with-httpd=apache2 \
		--with-modules-path=/usr/$(get_libdir)/apache2/modules/ \
		--disable-bluetooth \
		$(use_with X x)
}
