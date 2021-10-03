AM_CXXFLAGS = -std=c++11 -Wall -Wextra  -Wno-unused-parameter
AM_CPPFLAGS = -I../include # -I. $(shell cppunit-config --cflags)

# AM_LDFLAGS = $(shell cppunit-config --libs)
# Not used with clang at the moment, save it in case
# AM_LDFLAGS = -L/usr/local/Cellar/boost/1.62.0/lib/ # $(shell cppunit-config --libs)
LDADD = ../src/libbst.a

%.o: %.cpp
	g++ $(AM_CXXFLAGS) $(AM_CPPFLAGS) -D$*_STANDALONE -c $< $(AM_LDFLAGS)

bin_PROGRAMS = node tree collector yaml

node_SOURCES = test_node.cpp testutils.cpp
tree_SOURCES = test_tree.cpp testutils.cpp
collector_SOURCES = test_collector.cpp testutils.cpp
yaml_SOURCES = test_yaml.cpp testutils.cpp
