#include <string>
#include <cppunit/TestCase.h>

#include "./testutils.h"
#include <node.h>


using std::string;

class NodeTest : public CppUnit::TestCase {

public:
  NodeTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_instantiation() {
    describe_test(INDENT0, "From test_instantiation in NodeTest.");
    Spec spec;
    // spec.it("Testing Node instantiation", DO_SPEC_HANDLE {
    spec.it("Testing Node instantiation", [&]()->bool {
      int key = 1;
      Node node(key);
      return (node.key == key);
    });
  }

  void test_left_initialize() {
    describe_test(INDENT0, "From test_instantiation in NodeTest.");
    Spec spec;
    spec.it("Testing left node initialize to nullptr", DO_SPEC {
      Node node(1);
      return (node.left == nullptr);
    });
  }

  void test_right_initialize() {
    describe_test(INDENT0, "From test_instantiation in NodeTest.");
    Spec spec;
    spec.it("Testing right node initialize to nullptr", DO_SPEC {
      Node node(1);
      return (node.right == nullptr);
    });
  }

  void test_insert() {
    describe_test(INDENT0, "From test_insert in NodeTest.");
    Spec spec;
    spec.it("Testing Node.insert", DO_SPEC {
      Node node(3);
      Node node2(1);
      Node node3(2);
      node.insert(&node2);
      node.insert(&node3);
      return (node.left->right->key == 2);
    });
  }

  void test_is_bst(void) {
    describe_test(INDENT0, "From test_is_bst in NodeTest.");
    Spec spec;
    Node root(17);

    //spec.it("Single root node is a binary search tree", DO_SPEC_HANDLE {
    spec.it("Single root node is a binary search tree", [&]()->bool {
        return root.is_bst() == true;
    });

    Node n5(5);
    Node n23(23);
    root.insert(&n5);
    root.insert(&n23);
    spec.it("three node tree is bst", [&]()->bool {
        return root.is_bst() == true;
    });

    Node n14(14);
    n23.insert(&n14);
    spec.it("inserting a wrong node internally renders bst false", [&]()->bool {
        return n23.is_bst() == true
            && root.is_bst() == false;
    });
  }

  void test_is_present() {
    describe_test(INDENT0, "From test_is_present in NodeTest.");
    Spec spec;
    spec.it("Testing Node.is_present with 8 nodes", DO_SPEC {
      Node root(25);
      Node node43(43);
      Node node8(8);
      Node node10(10);
      Node node15(15);
      Node node33(33);
      Node node97(97);
      Node node4(4);
      root.insert(&node43);
      root.insert(&node8);
      root.insert(&node10);
      root.insert(&node15);
      root.insert(&node33);
      root.insert(&node97);
      root.insert(&node4);

      bool result = root.is_present(43);
      // TODO: refactor tree building so that other keys
      // can be tested for presence.
      return (result == true);
    });
  }

  void test_successor_and_predecessor() {
    describe_test(INDENT0, "From test_successor_and_predecessor in NodeTest");
    Spec spec;
    Node root(17);
    Node n13(13);
    Node n3(3);
    Node n2(2);
    Node n5(5);
    Node n7(7);
    Node n11(11);
    Node n19(19);
    Node n23(23);
    Node n29(29);

    root.insert(&n5);
    root.insert(&n3);
    root.insert(&n2);

    root.insert(&n7);
    root.insert(&n11);
    root.insert(&n13);

    root.insert(&n23);
    root.insert(&n19);
    root.insert(&n29);

    spec.it("root node successor", [&]() {
        return root.successor(&root) == &n19;
    });

    spec.it("root node predecessor", [&]() {
        return root.predecessor(&root) == &n13;
    });

    spec.it("right side minimum", [&]() {
        return root.successor(&n19) == &n23;
    });

    spec.it("left side maximum", [&]() {
        return root.predecessor(&n13) == &n11;
    });

    spec.it("maximum is own successor", [&]() {
        return root.successor(&n29) == &n29;
    });

    spec.it("minimum is own predecessor", [&]() {
        return root.predecessor(&n2) == &n2;
    });

    spec.it("successors down the left side", [&]() {
        return root.successor(&n2) == &n3
            && root.successor(&n3) == &n5
            && root.successor(&n5) == &n7;
    });

    spec.it("predecessors down the left side", [&]() {
        return root.predecessor(&n3) == &n2
            && root.predecessor(&n5) == &n3
            && root.predecessor(&n7) == &n5;
    });

    spec.it("successors down the first left's right branch", [&]() {
        return root.successor(&n7) == &n11
            && root.successor(&n11) == &n13
            && root.successor(&n13) == &root;
    });

    spec.it("predecessors down the first right's left branch", [&]() {
        return root.predecessor(&n19) == &root
            && root.predecessor(&n23) == &n19
            && root.predecessor(&n29) == &n23;
    });
  }


  void test_height() {
    describe_test(INDENT0, "From test_height in NodeTest");
    Spec spec;
    Node root(13);
    Node n17(17);
    Node n3(3);
    Node n2(2);
    Node n5(5);
    Node n7(7);
    Node n11(11);
    Node n19(19);
    Node n23(23);
    Node n29(29);

    root.insert(&n5);
    root.insert(&n11);
    root.insert(&n7);
    root.insert(&n3);
    root.insert(&n2);
    root.insert(&n19);
    root.insert(&n17);
    root.insert(&n23);
    root.insert(&n29);

    spec.it("whole tree has height 3", [&]() {
        return (root.height() == 3);
    });

    spec.it("leaf node maximum has height 0", [&]() {
        return (n29.height() == 0);
    });

    spec.it("leaf node minimum has height 0", [&]() {
        return (n2.height() == 0);
    });

    spec.it("root's left child has height 2", [&]() {
        return (n5.height() == 2);
    });

    spec.it("root's right child has height 2", [&]() {
        return (n19.height() == 2);
    });

    spec.it("n11 has height 1", [&]() {
        return (n11.height() == 1);
    });

    spec.it("n3 has height 1", [&]() {
        return (n3.height() == 1);
    });

    spec.it("n23 has height 1", [&]() {
        return (n23.height() == 1);
    });
  }

  void test_size() {
    describe_test(INDENT0, "From test_size in NodeTest.");
    Spec spec;
    Node root(11);

    spec.it("node size of root node only", [&]() {
      return (root.size() == 1);
    });

    Node n17(17);
    Node n3(3);
    root.insert(&n3);
    root.insert(&n17);
    spec.it("node with left and right child", [&]() {
        return (root.size() == 3);
    });

    Node n2(2);
    Node n5(5);
    Node n7(7);
    Node n13(13);
    Node n19(19);
    Node n23(23);
    Node n29(29);
    root.insert(&n2);
    root.insert(&n5);
    root.insert(&n7);
    root.insert(&n13);
    root.insert(&n19);
    root.insert(&n23);
    root.insert(&n29);

    spec.it("size of tree with first 10 primes is 10", [&]() {
        return (root.size() == 10);
    });

    spec.it("size of subtree at max node is 1", [&]() {
        return (n29.size() == 1);
    });

    spec.it("size of subtree at minimum node is 1", [&]() {
        return (n2.size() == 1);
    });

    spec.it("size of subtree at node with key 5 node is 2", [&]() {
        return (n5.size() == 2);
    });
  }

  void test_maximum() {
    describe_test(INDENT0, "From test_maximum in NodeTest.");
    Spec spec;
    spec.it("Testing Node.maximum", DO_SPEC {
      Node root(3);
      Node node2(1);
      Node node3(2);
      Node node17(17);
      root.insert(&node2);
      root.insert(&node3);
      root.insert(&node17);
      return (root.maximum() == &node17);
    });
  }

  void test_minimum() {
    describe_test(INDENT0, "From test_minimum in NodeTest.");
    Spec spec;
    spec.it("Testing Node.minimum", DO_SPEC {
      Node root(3);
      Node node2(1);
      Node node3(2);
      root.insert(&node2);
      root.insert(&node3);
      return (root.minimum() == &node2);
    });
  }

  void test_collect(void) {
    describe_test(INDENT0, "From test_collect in NodeTest");
    Spec spec;

    spec.it("collects 1 value from a single node", DO_SPEC {
      Node root(17);
      std::vector<int> a1{17};
      std::vector<int> a2;
      root.collect(a2);
      return a1 == a2;
    });

    spec.it("Testing Node.collect", DO_SPEC {
      Node root(25);
      std::vector<int> a1{4, 8, 10, 15, 25, 33, 43, 97};
      Node node2(43);
      Node node3(8);
      Node node4(10);
      Node node5(15);
      Node node6(33);
      Node node7(97);
      Node node8(4);
      root.insert(&node2);
      root.insert(&node3);
      root.insert(&node4);
      root.insert(&node5);
      root.insert(&node6);
      root.insert(&node7);
      root.insert(&node8);
      std::vector<int> a2;
      root.collect(a2);
      return (a1 == a2);
    });
  }

  void test_search(void) {
  }

  void test_list_keys(void) {
    describe_test(INDENT0, "From test_list_keys in NodeTest.");
    Spec spec;

    spec.it("lists key for single node", DO_SPEC {
      Node root(17);
      std::vector<int> a1{17};
      std::vector<int> a2 = root.list_keys();
      return a1 == a2;
    });
  }

  void test_print_to_console() {
    describe_test(INDENT0, "From test_print_to_console in NodeTest");

    Node root(17);
    root.print_to_console();
  }

  void runTest() {
    test_instantiation();
    test_left_initialize();
    test_right_initialize();
    test_insert();
    test_is_present();
    test_size();
    test_height();
    test_successor_and_predecessor();
    test_maximum();
    test_minimum();
    test_is_bst();
    test_collect();
    test_list_keys();
    test_search();
    // test_print_to_console();
  }
};

void
test_node() {

  NodeTest * nt = new NodeTest(std::string("initial test"));
  nt->runTest();
  delete nt;
}


int
main(int argc, char ** argv) {

  test_node();
  return 0;
}
