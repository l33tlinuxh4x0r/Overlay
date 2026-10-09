# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Gaming-first, high-performance background removal plugin for OBS Studio"
HOMEPAGE="https://github.com/kaito-tokyo/live-backgroundremoval-lite"
SRC_URI="https://github.com/kaito-tokyo/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/live-backgroundremoval-lite-${PV}"

RDEPEND="
	>=media-video/obs-studio-31.1.1
	dev-libs/ncnn
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	cmake_src_prepare

	# Fix missing cpuid.h include for x86/x86_64 intrinsics
	if use amd64 || use x86; then
		sed -i '1s/^/#include <cpuid.h>\n/' \
			src/SelfieSegmenter/KaitoTokyo/SelfieSegmenter/BoundingBox.cpp || die
	fi
}
