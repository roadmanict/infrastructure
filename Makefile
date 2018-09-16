.PHONY: lint

lint:
	yamllint -c ./.yamllint.yml .
	ansible-lint site.yml