test: composer
	./vendor/bin/phpunit


composer:
	composer update


.PHONY: test composer