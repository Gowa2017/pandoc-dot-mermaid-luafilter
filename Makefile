
LUAINC ?= /usr/local/include/lua
LUALIB ?= /usr/local/lib/lua/5.4

CFLAGS = -I${LUAINC}
LDFLAGS = -shared -fPIC -L${LUALIB} -undefined dynamic_lookup

all: crypt.so zlib.so

crypt.so: lua-crypt.c lsha1.c
	${CC} -o $@  $^ ${CFLAGS} ${LDFLAGS}

zlib.so: 3rd/lua-zlib/lua_zlib.c
	${CC} -o $@ ${CFLAGS} ${LDFLAGS} $^ -lz

clean:
	rm -f crypt.so zlib.so
