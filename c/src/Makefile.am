CC=gcc
CXX=g++

CPPFLAGS = -Wall -Wextra

AM_CPPFLAGS = -I/usr/local/include -I../include

UNAME := $(shell uname)

# ifeq ($(UNAME), Linux)
# ifeq "$(UNAME)" "Linux"
# CFLAGS+= `pkg-config --cflags libyaml`
# LDFLAGS+= `pkg-config --libs libyaml`
# endif

noinst_LIBRARIES = libbst.a
libbst_a_SOURCES = node.c tree.c collector.c yaml.c
# libbst_a_CPPFLAGS = -O0 -pg  -Wall -Wextra -fno-inline $(AM_CPPFLAGS) -DIL_STD -L/usr/local/lib -DNDEBUG -w
# -pg enables gprof, see https://stackoverflow.com/questions/4981121/how-exactly-does-gprof-work/5046039#5046039
# TODO: figure out what NDEBUG is for, I have forgotten.
libbst_a_CFLAGS = -O0 -pg  -Wall -Wextra -fno-inline $(AM_CPPFLAGS) -DIL_STD -L/usr/local/lib -DNDEBUG -w


bin_PROGRAMS = yaml
yaml_SOURCES = yaml.c
yaml_CPPFLAGS = -O0 -pg  -Wall -Wextra -fno-inline $(AM_CPPFLAGS) -DIL_STD -L/usr/local/lib -DSTANDALONE #-DNDEBUG -w -finstrument-functions-exclude-file-list=iostream.h,string.h,vector.h
yaml_LDFLAGS = -pg  -O0
yaml_LDFLAGS = -O0
yaml_LDADD = ./libbst.a

