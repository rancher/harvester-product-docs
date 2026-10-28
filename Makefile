# Set EN_ONLY_LOG=0 to keep build messages for non-'en' languages.
EN_ONLY_LOG ?= 1
ifeq ($(EN_ONLY_LOG),1)
LOG_FILTER = awk -f scripts/filter-non-en.awk
else
LOG_FILTER = cat
endif

local:
	mkdir -p tmp
	npx antora --version
	npx antora --stacktrace --log-format=pretty --log-level=info \
		playbook-local.yml \
		2>&1 | $(LOG_FILTER) | tee tmp/local-build.log 2>&1

remote:
	mkdir -p tmp
	npm ci
	npx antora --version
	npx antora --stacktrace --log-format=pretty --log-level=info \
		playbook-remote.yml \
		2>&1 | $(LOG_FILTER) | tee tmp/remote-build.log 2>&1

clean:
	rm -rf build

environment:
	npm ci

preview:
	npx http-server build/site -c-1