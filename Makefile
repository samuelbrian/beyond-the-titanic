
PC := fpc
FLAGS := -Mtp -O3 -Xt
DEBUG_FLAGS := -Mtp -g -O1 -XD

BEYOND_EXE = BEYOND
SPECIAL_EXE = SPECIAL
ROOMRITE_EXE = ROOMRITE
LINERITE_EXE = LINERITE

all: $(BEYOND_EXE) # $(SPECIAL_EXE) $(ROOMRITE_EXE) $(LINERITE_EXE)

$(BEYOND_EXE): BEYOND.PAS ADPARSER.PAS COMMANDS.PAS OBJECTS.PAS WORDLIST.PAS
ifndef DEBUG
	$(PC) $(FLAGS) -o$@ BEYOND.PAS
else
	$(PC) $(DEBUG_FLAGS) -o$@ BEYOND.PAS
endif

$(SPECIAL_EXE): SPECIAL.PAS
ifndef DEBUG
	$(PC) $(FLAGS) -o$@ SPECIAL.PAS
else
	$(PC) $(DEBUG_FLAGS) -o$@ SPECIAL.PAS
endif

$(ROOMRITE_EXE): ROOMRITE.PAS
ifndef DEBUG
	$(PC) $(FLAGS) -o$@ ROOMRITE.PAS
else
	$(PC) $(DEBUG_FLAGS) -o$@ ROOMRITE.PAS
endif

$(LINERITE_EXE): LINERITE.PAS
ifndef DEBUG
	$(PC) $(FLAGS) -o$@ LINERITE.PAS
else
	$(PC) $(DEBUG_FLAGS) -o$@ LINERITE.PAS
endif

clean:
	rm -f *.o $(BEYOND_EXE) $(SPECIAL_EXE) $(ROOMRITE_EXE) $(LINERITE_EXE)