build: rm
	gem build declarative_mapper.gemspec

push:
	gem push declarative_mapper-*.gem

rm:
	rm declarative_mapper-*.gem

all: build push rm