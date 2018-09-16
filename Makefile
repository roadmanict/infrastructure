.PHONY: lint

lint:
	yamllint .
	ansible-lint berry.yml