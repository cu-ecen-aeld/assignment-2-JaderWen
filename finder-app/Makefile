SOURCES=$(wildcard *.c)
OBJECTS=$(patsubst %.c,%.o,$(SOURCES))
PROGRAM=writer
CC=gcc
CFLAGS=-g -Wall

$(PROGRAM): $(OBJECTS)
	$(CROSS_COMPILE)$(CC) $(CFLAGS) -o $(PROGRAM) $(OBJECTS)
$(OBJECTS): $(SOURCES)
	$(CROSS_COMPILE)$(CC) $(CFLAGS) -c -o $(OBJECTS) $(SOURCES)

.PHONY: clean
clean:
	rm -rf $(OBJECTS) $(PROGRAM)