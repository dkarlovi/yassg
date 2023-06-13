APP_ROOT=$(abspath $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST))))))
BUILD_DIR=public
BASE_URL=https://example.com/sub/dir/another

include ../../../vendor/sigwin/infra/resources/YASSG/default.mk

self/build: self/clean ${BUILD_DIR}/assets/entrypoints.json ## Self: build the app
	export YASSG_SKIP_BUNDLES=${YASSG_SKIP_BUNDLES}; \
	php ../../../bin/yassg yassg:generate --env prod $(BASE_URL) ${BUILD_OPTS}
self/init: self/clean ## Self: init the app via yassg:init
	export YASSG_SKIP_BUNDLES=${YASSG_SKIP_BUNDLES}; \
	php ../../../bin/yassg yassg:init --demo
self/clean:
	rm -rf ${BUILD_DIR}
self/test:
	sh -c "${PHPQA_DOCKER_COMMAND} diff -r fixtures/ public/"
self/check: self/build ## Self: check the build
	lychee --verbose --offline --base ./${BUILD_DIR} ./${BUILD_DIR}
self/serve: self/build ## Self: serve the build
	php -S localhost:9999 -t ${BUILD_DIR}/
