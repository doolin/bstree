CC=gcc
CXX=g++

CPPFLAGS = -Wall -Wextra

# Immediate execution of shell command to determine BREW_PREFIX
BREW_PREFIX := $(shell if [ $$(uname -m) = "arm64" ]; then echo /opt/homebrew; else echo /usr/local; fi)

AM_CPPFLAGS = -I$(BREW_PREFIX)/include -I../include

noinst_LIBRARIES = libbst.a
libbst_a_SOURCES = node.c tree.c collector.c yaml.c

libbst_a_CFLAGS = -O0 -pg  -Wall -Wextra -fno-inline $(AM_CPPFLAGS) -DIL_STD -L$(BREW_PREFIX)/lib -DNDEBUG -w

bin_PROGRAMS = yaml
yaml_SOURCES = yaml.c
yaml_CPPFLAGS = -O0 -pg  -Wall -Wextra -fno-inline $(AM_CPPFLAGS) -DIL_STD -L$(BREW_PREFIX)/lib -DSTANDALONE
yaml_LDFLAGS = -L$(BREW_PREFIX)/lib -lyaml -O0
yaml_LDADD = ./libbst.a -lyaml
