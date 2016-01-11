ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)

hello:
	gcc -o output -Wall -std=c99 hello_world.m -framework Foundation -framework Cocoa -lobjc

clean:
	rm -f output

.PHONY: all clean
