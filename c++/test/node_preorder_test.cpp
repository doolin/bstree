#include <string>
#include <cppunit/TestCase.h>

#include "./testutils.h"
#include <node.h>

using std::string;

class NodePreOrderTest : public CppUnit::TestCase {

public:
  NodePreOrderTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_pre_order_print_keys() {
    Spec spec;
    describe_test(INDENT0, "From test_pre_order_print_keys in NodePreOrderTest");

    spec.it("Testing Node.pre_order_traverse", DO_SPEC {
      std::vector<int> expected{17, 8, 43};

      Node root(17);
      Node node43(43);
      Node node8(8);
      root.insert(&node43);
      root.insert(&node8);

      std::vector<int> actual;
      root.preorder_collect(actual);

      return (expected == actual);
    });
  }

  void runTest() {
    test_pre_order_print_keys();
  }
};

void
test_node() {

  NodePreOrderTest * nt = new NodePreOrderTest(std::string("initial test"));
  nt->runTest();
  delete nt;
}


int
main(int argc, char ** argv) {

  test_node();
  return 0;
}
