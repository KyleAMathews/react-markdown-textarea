BIN = ./node_modules/.bin

test:
	npm test

release-patch: test
	@$(call release,patch)

release-minor: test
	@$(call release,minor)

release-major: test
	@$(call release,major)

publish-gh-pages:
	rm -rf lib
	git checkout gh-pages
	git checkout master -- public
	cp public/* .
	git add --all .
	git commit -m "New release"
	git push origin gh-pages
	git checkout master

publish:
	git push --tags origin HEAD:master
	npm publish

define release
	@$(BIN)/cjsx -cb -o lib src/index.cjsx
	cp src/styles/_react_markdown_textarea.scss lib
	npm version $(1)
endef
