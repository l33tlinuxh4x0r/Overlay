# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="OBS plugin for removing background"
HOMEPAGE="https://github.com/occ-ai/obs-backgroundremoval"
SRC_URI="https://github.com/royshil/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[widgets]
	>=media-video/obs-studio-29
	>=media-libs/opencv-4.7.0:=
	"

RDEPEND="${DEPEND}"


src_install() {
	cmake_src_install

	if [[ -d "${ED}/usr/share/doc/${PN}" ]]; then
		mkdir -p "${ED}/usr/share/doc/${PF}" || die
		mv "${ED}/usr/share/doc/${PN}"/* "${ED}/usr/share/doc/${PF}/" || die
		rm -rf "${ED}/usr/share/doc/${PN}" || die
	fi
}
