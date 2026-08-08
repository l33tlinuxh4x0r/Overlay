# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#inherit eutils versionator java-utils-2
inherit desktop java-utils-2

OWN_PV=2026-06
SR="R"

SRC_BASE="http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/${OWN_PV}/${SR}/eclipse-java-${OWN_PV}-${SR}-linux-gtk"

DESCRIPTION="Eclipse SDK"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="
	${SRC_BASE}-x86_64.tar.gz&r=1 -> eclipse-java-${RNAME}-${SR}-linux-gtk-x86_64-${PV}.tar.gz
	"

LICENSE="EPL-1.0"
SLOT="$(ver_cut 1-2)"
KEYWORDS="~amd64 ~x86"
IUSE="lombok"

CDEPEND="
	>=dev-java/commons-httpclient-3.1:3
	>=dev-java/javax-inject-1:0
	>=dev-java/xml-commons-resolver-1.2:0
	"
DEPEND="${CDEPEND}"
RDEPEND=">=virtual/jdk-1.8
	x11-libs/gtk+:3
	lombok? ( dev-java/lombok-bin )
	${CDEPEND}"

S="${WORKDIR}"/eclipse

src_prepare() {
	cp "${S}/eclipse" "${T}/eclipse-bin-${SLOT}" || die

	eapply_user
}

src_install() {
	local dest=/opt/${PN}

	insinto ${dest}
	doins -r features icon.xpm plugins artifacts.xml p2 eclipse.ini configuration dropins

	exeinto ${dest}
	doexe "${T}"/eclipse-bin-${SLOT}

	dosym -r ${dest}/eclipse-bin-${SLOT} /usr/bin/eclipse-bin-${SLOT}
	insinto /etc
	make_desktop_entry eclipse-bin-${SLOT} "Eclipse ${RNAME^}${PV} (bin)" "${dest}/icon.xpm"
}
