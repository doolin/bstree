CC=gcc
CXX=g++

CPPFLAGS = -Wall -Wextra -std=c++14

AM_CPPFLAGS = -I/usr/local/include -I../include

noinst_LIBRARIES = libtree.a
libtree_a_SOURCES = tree.cpp node.cpp
# libtree_a_CPPFLAGS = -O0 -pg  -Wall -Wextra -fno-inline $(AM_CPPFLAGS) -DIL_STD -L/usr/local/lib -DNDEBUG -w
libtree_a_CPPFLAGS = -O0 -Wall -Wextra -fno-inline $(AM_CPPFLAGS) -DIL_STD -L/usr/local/lib -DNDEBUG -w

# TODO: clean this up, or delete
# bin_PROGRAMS = getsome
# getsome_SOURCES = main.cpp
# getsome_CPPFLAGS = -O0 -Wall -Wextra -fno-inline $(AM_CPPFLAGS) -DIL_STD -L/usr/local/lib
# getsome_LDFLAGS = -O0
# getsome_LDADD = -L. -l./tree

