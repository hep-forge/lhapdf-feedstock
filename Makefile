build:
	@conda build . --output pkgs

debug:
	@conda debug .

publish:
	@anaconda -t ~/.conda-smithy/anaconda.token upload --force pkgs/*/*.tar.bz2 --label test
