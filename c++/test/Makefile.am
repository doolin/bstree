AM_CXXFLAGS = -std=c++14 -Wall -Wextra  -Wno-unused-parameter
AM_CPPFLAGS = -I../include -I. $(shell cppunit-config --cflags)

AM_LDFLAGS = $(shell cppunit-config --libs)
LDADD = ../src/libtree.a

%.o: %.cpp
	g++ $(AM_CXXFLAGS) $(AM_CPPFLAGS) -D$*_STANDALONE -c $< $(AM_LDFLAGS)

bin_PROGRAMS = node_test tree_test

node_test_SOURCES = node_test.cpp testutils.cpp
tree_test_SOURCES = tree_test.cpp testutils.cpp
