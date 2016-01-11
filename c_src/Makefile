ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)

hello:
	gcc -fPIC -I$(ERLANG_PATH) -dynamiclib -undefined dynamic_lookup -Wall -std=c99 -framework Cocoa -lobjc -o binding.so hello_world.m

clean:
	rm -f binding.so Elixir.Test.beam

.PHONY: all clean
