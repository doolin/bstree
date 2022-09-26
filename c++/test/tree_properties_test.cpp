#include <string>
#include <vector>
#include <memory>
#include <cppunit/TestCase.h>

#include "./testutils.h"
#include <tree.h>
#include <node.h>

using std::string;

class TreePropertiesTest : public CppUnit::TestCase {

public:
  TreePropertiesTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_from_yaml(void) {
    describe_test(INDENT0, "From test_from_yaml in TreeTest.");

    Spec spec;
    spec.it("Tree 1 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree1.yml");

      return tree->size() == 1 &&
             tree->height() == 0 &&
             tree->is_bst() == true &&
             tree->is_empty() == false;
    });

    spec.it("Tree 2 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree2.yml");

      return tree->size() == 2 &&
             tree->height() == 1 &&
             tree->is_bst() == true &&
            tree->is_empty() == false;
    });

    spec.it("Tree 3 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree3.yml");

      return tree->size() == 3 &&
             tree->height() == 1 &&
             tree->is_bst() == true &&
             tree->is_empty() == false;
    });

    spec.it("Tree 4 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree4.yml");

      return tree->size() == 4 &&
             tree->height() == 2 &&
             tree->is_bst() == true &&
             tree->is_empty() == false;
    });

    spec.it("Tree 5 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree5.yml");

      return tree->size() == 5 &&
             tree->height() == 2 &&
             tree->is_bst() == true &&
             tree->is_empty() == false;
    });

    spec.it("Tree 6 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree6.yml");

      return tree->size() == 6 &&
             tree->height() == 3 &&
             tree->is_bst() == true &&
             tree->is_empty() == false;
    });

    spec.it("Tree 7 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree7.yml");

      return tree->size() == 7 &&
             tree->height() == 3 &&
             tree->is_bst() == true &&
             tree->is_empty() == false;
    });

    spec.it("Tree 8 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree8.yml");

      return tree->size() == 8 &&
             tree->height() == 3 &&
             tree->is_bst() == true &&
             tree->is_empty() == false;
    });

    spec.it("Tree 9 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree9.yml");

      return tree->size() == 9 &&
             tree->height() == 3 &&
             tree->is_bst() == true &&
             tree->is_empty() == false;
    });

    spec.it("Tree 10 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree10.yml");

      // TODO: Move this to a print to console method.
      // std::vector<int> a2;
      // tree->collect(a2);
      // std::cout <<"Vector 'a2' : ";
      // for (int e: a2)
      //     std::cout<<e<<" ";
      // std::cout << std::endl;

      return tree->size() == 10 &&
             tree->height() == 4 &&
             tree->is_bst() == true &&
             tree->is_empty() == false;
    });

    spec.it("Tree 123 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree123.yml");

      return tree->size() == 3 &&
             tree->height() == 2 &&
             tree->is_bst() == true &&
             tree->is_empty() == false;
    });

    spec.it("Tree 132 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree132.yml");

      return tree->size() == 3 &&
             tree->height() == 2 &&
             tree->is_bst() == true &&
             tree->is_empty() == false;
    });

    spec.it("Tree 213 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree213.yml");

      return tree->size() == 3 &&
             tree->height() == 1 &&
             tree->is_bst() == true &&
             tree->is_empty() == false;
    });

    spec.it("Tree 312 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree312.yml");

      return tree->size() == 3 &&
             tree->height() == 2 &&
             tree->is_bst() == true &&
             tree->is_empty() == false;
    });

    spec.it("Tree 321 properties from yaml file", [&]()->bool {
      Tree t = Tree();
      Tree * tree = t.from_yaml("../../fixtures/tree321.yml");

      return tree->size() == 3 &&
             tree->height() == 2 &&
             // tree->is_bst() == true &&
             tree->is_empty() == false;
    });
  }

  void runTest() {
    test_from_yaml();
  }
};

void
test_node() {
  TreePropertiesTest * nt = new TreePropertiesTest(std::string("initial test"));

  nt->runTest();
  delete nt;
}

int
main(int argc, char ** argv) {

  test_node();
  return 0;
}
