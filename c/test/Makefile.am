# Immediate execution of shell command to determine BREW_PREFIX
BREW_PREFIX := $(shell if [ $$(uname -m) = "arm64" ]; then echo /opt/homebrew; else echo /usr/local; fi)

AM_CXXFLAGS = -std=c++11 -Wall -Wextra -Wno-unused-parameter
AM_CPPFLAGS = -I../include -I$(BREW_PREFIX)/include

LDADD = ../src/libbst.a -L$(BREW_PREFIX)/lib -lcppunit -lyaml

# Automake's implicit rules for compiling C++ source files will automatically use AM_CXXFLAGS and AM_CPPFLAGS,
# so you typically do not need to redefine a rule for compiling .o files from .cpp sources.

bin_PROGRAMS = node tree collector yaml

node_SOURCES = test_node.cpp testutils.cpp
tree_SOURCES = test_tree.cpp testutils.cpp
collector_SOURCES = test_collector.cpp testutils.cpp
yaml_SOURCES = test_yaml.cpp testutils.cpp
