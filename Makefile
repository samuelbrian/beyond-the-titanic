###############################################################################
#                                   FUNCORP                                   #
# 'Beyond the Titanic' makefile                                               #
# Requires Free Pascal (v3.0.0 from freepascal.org)                           #
###############################################################################

PC := fpc
FLAGS := -Mtp -O3 -dASCII_TERMINAL
DEBUG_FLAGS := -Mtp -g -O1 -XD -dASCII_TERMINAL

UNAME := $(shell uname -s)
ifeq ($(UNAME), Linux)
	PLATFORM = Linux
	FLAGS += -Xt
endif
ifeq ($(UNAME), Darwin)
	PLATFORM = Mac
endif
ARCH := $(shell uname -m)

BEYOND_EXE = BEYOND
SPECIAL_EXE = SPECIAL
ROOMRITE_EXE = ROOMRITE
LINERITE_EXE = LINERITE

DIST_FILES = $(BEYOND_EXE) HELP.TXT HELP.SH INSTRUCT.TXT INSTRUCT.SH LINE ROOMS1 ROOMS2 SPECIAL1 SPECIAL2 LICENSE FILE_ID.DIZ FUNCORP.TXT
DIST_ARCHIVE = BeyondTheTitanic-$(PLATFORM)-$(ARCH).tar.gz

.PHONY: all clean release
all: $(BEYOND_EXE) # $(SPECIAL_EXE) $(ROOMRITE_EXE) $(LINERITE_EXE)

release: $(DIST_ARCHIVE)

clean:
	rm -f *.o $(BEYOND_EXE) $(SPECIAL_EXE) $(ROOMRITE_EXE) $(LINERITE_EXE) $(DIST_ARCHIVE)

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

$(DIST_ARCHIVE): $(DIST_FILES)
	tar -acf $@ $(DIST_FILES)
