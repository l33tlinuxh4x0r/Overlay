EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=flit
inherit distutils-r1 desktop xdg

DESCRIPTION="Cross-platform Python IDE focused on interactivity and introspection"
HOMEPAGE="https://pyzo.org/ https://github.com/pyzo/pyzo"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/pyside[${PYTHON_USEDEP}]
	|| (
		dev-python/pyqt5[${PYTHON_USEDEP}]
		dev-python/pyqt6[${PYTHON_USEDEP}]
	)
"
BDEPEND="${RDEPEND}"

python_install() {
	 distutils-r1_python_install
	 python_doscript pyzolauncher.py
}

python_install_all() {
	insinto /usr/share/metainfo/
	doins pyzo.appdata.xml

	for size in 16 32 48 64 128; do
		newicon -s ${size} "${PN}/resources/appicons/pyzologo${size}.png" pyzologo.png
	done
	domenu "${PN}/resources/org.${PN}.Pyzo.desktop"

	distutils-r1_python_install_all
}
