#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <node.h>
#include <collector.h>
#include <yaml.h>
#include "../src/node_private.h"

using std::string;

class YamlTest : public CppUnit::TestCase {

  public:
  YamlTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_load_tree() {
    describe_test(INDENT0, "Dummy yaml test");
    
    Spec spec;

    spec.it("loads a single node BST", DO_SPEC_HANDLE {
      FILE *yaml_file = fopen("../../fixtures/tree1.yml", "r");
      Node * node = load_tree(yaml_file);
      fclose(yaml_file);
      return (
        node_key(node) == 11 &&
        node_size(node) == 1 &&
        node_height(node) == 0 &&
        node_is_bst(node) == true
        );
    });

    spec.it("loads a two node BST", DO_SPEC_HANDLE {
      FILE *yaml_file = fopen("../../fixtures/tree2.yml", "r");
      Node * node = load_tree(yaml_file);
      fclose(yaml_file);
      return (
        node_key(node) == 11 &&
        node_key(node->left) == 7 &&
        node_size(node) == 2 &&
        node_height(node) == 1 &&
        node_is_bst(node) == true
      );
    });

    spec.it("loads a three node BST", DO_SPEC_HANDLE {
      FILE *yaml_file = fopen("../../fixtures/tree3.yml", "r");
      Node * node = load_tree(yaml_file);
      fclose(yaml_file);
      return (
        node_key(node) == 11 &&
        node_key(node->left) == 7 &&
        node_size(node) == 3 &&
        node_height(node) == 1 &&
        node_is_bst(node) == true
      );
    });

    spec.it("loads a four node BST", DO_SPEC_HANDLE {
      FILE *yaml_file = fopen("../../fixtures/tree4.yml", "r");
      Node * node = load_tree(yaml_file);
      fclose(yaml_file);
      return (
        node_key(node) == 11 &&
        node_key(node->left) == 7 && 
        node_size(node) == 4 && 
        node_height(node) == 2 &&
        node_is_bst(node) == true
      );
    });

    spec.it("loads a five node BST", DO_SPEC_HANDLE {
      FILE *yaml_file = fopen("../../fixtures/tree5.yml", "r");
      Node * node = load_tree(yaml_file);
      fclose(yaml_file);
      return (
        node_key(node) == 11 &&
        node_key(node->left) == 7 &&
        node_size(node) == 5 &&
        node_height(node) == 2 &&
        node_is_bst(node) == true
      );
    });

    spec.it("loads a six node BST", DO_SPEC_HANDLE {
      FILE *yaml_file = fopen("../../fixtures/tree6.yml", "r");
      Node * node = load_tree(yaml_file);
      fclose(yaml_file);
      return (
        node_key(node) == 11 &&
        node_key(node->left) == 7 &&
        node_size(node) == 6 &&
        node_height(node) == 3 &&
        node_is_bst(node) == true
      );
    });

    spec.it("loads a seven node BST", DO_SPEC_HANDLE {
      FILE *yaml_file = fopen("../../fixtures/tree7.yml", "r");
      Node * node = load_tree(yaml_file);
      fclose(yaml_file);
      return (
        node_key(node) == 11 &&
        node_key(node->left) == 7 &&
        node_size(node) == 7 &&
        node_height(node) == 3 &&
        node_is_bst(node) == true
      );
    });

    spec.it("loads an eight node BST", DO_SPEC_HANDLE {
      FILE *yaml_file = fopen("../../fixtures/tree8.yml", "r");
      Node * node = load_tree(yaml_file);
      fclose(yaml_file);
      return (
        node_key(node) == 11 &&
        node_key(node->left) == 7 &&
        node_size(node) == 8 &&
        node_height(node) == 3 &&
        node_is_bst(node) == true
      );
    });

    spec.it("loads a nine node BST", DO_SPEC_HANDLE {
      FILE *yaml_file = fopen("../../fixtures/tree9.yml", "r");
      Node * node = load_tree(yaml_file);
      fclose(yaml_file);
      return (
        node_key(node) == 11 &&
        node_key(node->left) == 7 &&
        node_size(node) == 9 &&
        node_height(node) == 3 &&
        node_is_bst(node) == true
      );
    });

    spec.it("loads a ten node BST", DO_SPEC_HANDLE {
      FILE *yaml_file = fopen("../../fixtures/tree10.yml", "r");
      Node * node = load_tree(yaml_file);
      fclose(yaml_file);
      return (
        node_key(node) == 11 &&
        node_key(node->left) == 7 &&
        node_size(node) == 10 &&
        node_height(node) == 4 &&
        node_is_bst(node) == true
      );
    });
  }

  void run_tests(void) {
    test_load_tree();
  }
};

void
test_yaml() {

  YamlTest * yt = new YamlTest(std::string("initial test"));
  yt->run_tests();
  delete yt;
}

int
main(int argc, char ** argv) {

  test_yaml();
  return 0;
}
