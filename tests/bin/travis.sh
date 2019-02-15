#!/usr/bin/env bash
# usage: travis.sh before|after

if [ $1 == 'before' ]; then

	if [[ ${TRAVIS_PHP_VERSION:0:2} == "5." ]]; then
		composer global require "phpunit/phpunit=4.8.*"
	else
		composer global require "phpunit/phpunit=6.2.*"
	fi

	composer dump-autoload

fi

if [ $1 == 'after' ]; then

	if [[ ${TRAVIS_PHP_VERSION} == '7.1' ]]; then
		bash <(curl -s https://codecov.io/bash)
		wget https://scrutinizer-ci.com/ocular.phar
		chmod +x ocular.phar
		php ocular.phar code-coverage:upload --format=php-clover coverage.clover
	fi

fi