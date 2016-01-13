ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CFLAGS = -dynamiclib -undefined dynamic_lookup -Wall -std=c99 -framework Cocoa -lobjc

hello:
	$(CC) -fPIC -I$(ERLANG_PATH) $(CFLAGS) -o priv/binding.so c_src/hello_world.m

clean:
	$(RM) -r priv/*

.PHONY: all clean
