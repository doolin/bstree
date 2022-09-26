AM_CXXFLAGS = -std=c++2a -Wall -Wextra  -Wno-unused-parameter
AM_CPPFLAGS = -I../include # -I. $(shell cppunit-config --cflags)

# AM_LDFLAGS = $(shell cppunit-config --libs)
LDADD = ../src/libtree.a -lyaml-cpp

%.o: %.cpp
	g++ $(AM_CXXFLAGS) $(AM_CPPFLAGS) -D$*_STANDALONE -c $< $(AM_LDFLAGS)

bin_PROGRAMS = node_test tree_test node_preorder_test tree_properties_test

node_test_SOURCES = node_test.cpp testutils.cpp
node_preorder_test_SOURCES = node_preorder_test.cpp testutils.cpp
tree_test_SOURCES = tree_test.cpp testutils.cpp
tree_properties_test_SOURCES = tree_properties_test.cpp testutils.cpp
