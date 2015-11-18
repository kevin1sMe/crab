PLAT ?= none
PLATS = linux osx

.PHONY : none $(PLATS) clean all

ifeq ($(PLAT), none)
.PHONY : default
default :
	$(MAKE) $(PLAT)
endif

none:
	@echo "Please do 'make PLATFORM' where PLATFORM is one of thes:"
	@echo "    $(PLATS)"

target:  utf8.so crab.so
linux : target
osx : target

SHARD := 

#linux : PLAT = linux
#macosx : PLAT = macosx

linux: SHARD := --shared
osx: SHARD := -dynamiclib -Wl,-undefined,dynamic_lookup 

utf8.so: lua-utf8.c
	gcc -fPIC $(SHARD) -g -O0 -Wall -I/usr/local/include -o $@ $^ -L/usr/local/lib

crab.so: lua-crab.c
	gcc -fPIC $(SHARD) -g -O0 -Wall -I/usr/local/include -o $@ $^ -L/usr/local/lib

crab : crab.c
	gcc -g -O0 -o $@ $^ 
test: $(PLAT)
	lua test.lua

test1: 
	#./crab words.txt "热爱中国共产党, 响应中央号召"
clean:
	rm  -rf *.so *.dSYM
