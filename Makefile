NAME=prometheus-node-exporter
VERSION=0.18.1
#VERSION=1.0.0-rc.0
NODE_EXPORTER_VERSION=$(VERSION)
MAINT=james.earl.3@gmail.com
DESCRIPTION="This is a convenience repackage of the OEM prometheus node-exporter binary."
LICENSE="Apache-2.0"
URL="https://github.com/prometheus/node_exporter"

DEB=$(NAME)_$(VERSION)
DEB_64=$(DEB)_amd64.deb
SRC_64=https://github.com/prometheus/node_exporter/releases/download/v$(NODE_EXPORTER_VERSION)/node_exporter-$(NODE_EXPORTER_VERSION).linux-amd64.tar.gz

.PHONY: dev build publish-gemfury ls uninstall install clean

dev: clean build install

build: dist/$(DEB_64)

publish-gemfury:
	fury push dist/$(DEB_64) --public

ls:
	gemfury versions "$(NAME)"

bin/:
	mkdir -p ./bin

dist/:
	mkdir -p ./dist

bin/node_exporter-$(NODE_EXPORTER_VERSION).linux-amd64: bin/
	wget -nc -nv -O - $(SRC_64) | tar -xz -C bin

dist/$(DEB_64): dist/ bin/node_exporter-$(NODE_EXPORTER_VERSION).linux-amd64
	fpm -s dir -t deb \
		--description $(DESCRIPTION) \
		--license $(LICENSE) \
		-p dist/$(DEB_64) \
		-n $(NAME) \
		--provides $(NAME) \
		-v $(VERSION) \
		-m $(MAINT) \
		--url $(URL) \
		--deb-no-default-config-files \
		"bin/node_exporter-$(NODE_EXPORTER_VERSION).linux-amd64/node_exporter"="/usr/bin/node_exporter"

clean:
	rm -rf dist/*

uninstall:
	sudo apt remove -y $(NAME) || true

install:
	sudo apt install -y --reinstall --allow-downgrades ./dist/$(DEB_64)
