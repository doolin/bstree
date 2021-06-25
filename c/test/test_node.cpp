#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <node.h>
#include <collector.h>
#include "../src/node_private.h"

using std::string;

Node * root;
Node * n200;

// These are segfaulting.
void
setup(void) {
  n200 = node_new(200);
  node_insert(root, n200);
}

void
teardown(void) {
  node_destroy(root);
}

int
node_stripped(Node * n) {
  return (n->parent == NULL && n->left == NULL && n->right == NULL) ? 1 : 0;
}

class NodeTest : public CppUnit::TestCase {

public:
  NodeTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_node_left(void) {
    describe_test(INDENT0, "From test_node_left in NodeTest.");
    Spec spec;
    Node * root = node_new(13);
    Node * n11 = node_new(11);

    spec.it("insert a single node to the left", DO_SPEC_HANDLE {
      node_insert(root, n11);
      return (node_left(root) == n11);
    });

    node_destroy(root);
  }

  void test_node_right(void) {
    describe_test(INDENT0, "From test_node_right in NodeTest.");
    Spec spec;
    Node * root = node_new(13);
    Node * n17 = node_new(17);

    spec.it("insert a single node to the right", DO_SPEC_HANDLE {
      node_insert(root, n17);
      return (node_right(root) == n17);
    });

    node_destroy(root);
  }

  void test_node_key(void) {
    describe_test(INDENT0, "From test_node_key in NodeTest.");
    Spec spec;
    int key = 17;

    Node * root = node_new(key);

    spec.it("insert a single node to the right", DO_SPEC_HANDLE {
      return (node_key(root) == key);
    });

    node_destroy(root);
  }

  void test_node_collect(void) {
    describe_test(INDENT0, "From test_node_collect in NodeTest.");
    Spec spec;
    Node * root = node_new(13);
    Collector * expected = collector_new(100);
    Collector * actual = collector_new(100);

    spec.it("array with single element for single node", DO_SPEC_HANDLE {
      collector_add(expected, 13);
      node_collect(root, (void *) actual);
      return collector_equals(expected, actual) == 1;
    });
    collector_reset(actual);

    Node * n17 = node_new(17);
    node_insert(root, n17);
    collector_add(expected, 17);
    spec.it("array with root and right leaf", DO_SPEC_HANDLE {
      node_collect(root, (void *) actual);
      return collector_equals(expected, actual) == 1;
    });
    collector_reset(actual);

    Node * n3 = node_new(3);
    node_insert(root, n3);
    collector_reset(expected);
    collector_add(expected, 3);
    collector_add(expected, 13);
    collector_add(expected, 17);
    spec.it("array with left and right leaves", DO_SPEC_HANDLE {
      node_collect(root, actual);
      return collector_equals(expected, actual) == 1;
    });
    collector_reset(actual);

    Node * n2 = node_new(2);
    Node * n5 = node_new(5);
    Node * n7 = node_new(7);
    Node * n11 = node_new(11);
    Node * n19 = node_new(19);
    Node * n23 = node_new(23);

    collector_reset(expected);
    collector_add(expected, 2);
    collector_add(expected, 3);
    collector_add(expected, 5);
    collector_add(expected, 7);
    collector_add(expected, 11);
    collector_add(expected, 13);
    collector_add(expected, 17);
    collector_add(expected, 19);
    collector_add(expected, 23);

    spec.it("array with single element for single node", DO_SPEC_HANDLE {
      node_insert(root, n23);
      node_insert(root, n19);
      node_insert(root, n5);
      node_insert(root, n7);
      node_insert(root, n11);
      node_insert(root, n2);
      node_collect(root, (void *) actual);
      return collector_equals(expected, actual) == 1;
    });

    node_destroy(root);
    collector_destroy(expected);
    collector_destroy(actual);
  }

  void test_node_search_and_is_present(void) {
    describe_test(INDENT0, "From test_node_search in NodeTest.");
    Spec spec;
    Node * root = node_new(13);
    spec.it("root element finds itself", DO_SPEC_HANDLE {
      Node * actual = node_search(root, 13);
      return actual == root;
    });
    spec.it("root element is present by key", DO_SPEC_HANDLE {
      return node_is_present(root, 13) == 1;
    });


    Node * n17 = node_new(17);
    node_insert(root, n17);
    spec.it("finds a right leaf", DO_SPEC_HANDLE {
      Node * actual = node_search(root, 17);
      return actual == n17;
    });
    spec.it("right leaf is present", DO_SPEC_HANDLE {
      return node_is_present(root, 17) == 1;
    });


    Node * n3 = node_new(3);
    node_insert(root, n3);
    spec.it("finds a left leaf", DO_SPEC_HANDLE {
      Node * actual = node_search(root, 3);
      return actual == n3;
    });
    spec.it("left leaf is present", DO_SPEC_HANDLE {
      return node_is_present(root, 3) == 1;
    });


    Node * n2 = node_new(2);
    Node * n5 = node_new(5);
    Node * n7 = node_new(7);
    Node * n11 = node_new(11);
    Node * n19 = node_new(19);
    Node * n23 = node_new(23);
    node_insert(root, n23);
    node_insert(root, n19);
    node_insert(root, n5);
    node_insert(root, n7);
    node_insert(root, n11);
    node_insert(root, n2);

    spec.it("finds node at end", DO_SPEC_HANDLE {
      Node * actual = node_search(root, 23);
      return actual == n23;
    });
    spec.it("deeply nested node is present", DO_SPEC_HANDLE {
      return node_is_present(root, 23) == 1;
    });

    spec.it("doesn't find value which isn't in tree", DO_SPEC_HANDLE {
      Node * actual = node_search(root, -100);
      return actual == NULL;
    });
    spec.it("key which isn't present in tree is not found", DO_SPEC_HANDLE {
      return node_is_present(root, -100) == 0;
    });

    node_destroy(root);
  }

  void test_node_destroy(void) {
  }

  void test_node_successor(void) {
    describe_test(INDENT0, "From test_node_successor in NodeTest.");
    Spec spec;
    Node * root = node_new(17);

    spec.it("successor for root node only", DO_SPEC_HANDLE {
      return (node_successor(root, root) == root);
    });

    spec.it("predecessor for root node only", DO_SPEC_HANDLE {
      return node_predecessor(root, root) == root;
    });

    Node * n2 = node_new(2);
    Node * n3 = node_new(3);
    Node * n5 = node_new(5);
    Node * n7 = node_new(7);
    Node * n11 = node_new(11);
    Node * n13 = node_new(13);
    Node * n19 = node_new(19);
    Node * n23 = node_new(23);
    Node * n29 = node_new(29);

    node_insert(root, n5);
    node_insert(root, n7);
    node_insert(root, n3);
    node_insert(root, n2);

    spec.it("successors up from the minimum", DO_SPEC_HANDLE {
      return node_successor(root, n2) == n3
      && node_successor(root, n3) == n5
      && node_successor(root, n5) == n7;
    });

    spec .it("predecessors down left side", DO_SPEC_HANDLE {
      return node_predecessor(root, n3) == n2
      && node_predecessor(root, n5) == n3
      && node_predecessor(root, n7) == n5;
    });

    node_insert(root, n11);
    node_insert(root, n13);

    spec.it("successors left into pathological right subtree", DO_SPEC_HANDLE {
      return node_successor(root, n7) == n11
      && node_successor(root, n11) == n13
      && node_successor(root, n13) == root;
    });

    spec.it("predecessors left into pathological right subtree", DO_SPEC_HANDLE {
      return node_predecessor(root, n11) == n7
      && node_predecessor(root, n13) == n11
      && node_predecessor(root, root) == n13;
    });

    node_insert(root, n23);
    node_insert(root, n19);
    node_insert(root, n29);

    spec.it("right side successors", DO_SPEC_HANDLE {
      return node_successor(root, n23) == n29
      && node_successor(root, n19) == n23
      && node_successor(root, n29) == n29
      && node_successor(n23, n19)  == n23;
    });

    spec.it("right side predecessors", DO_SPEC_HANDLE {
      return node_predecessor(root, n29) == n23
      && node_predecessor(root, n23) == n19
      && node_predecessor(root, n29) == n23
      && node_predecessor(n23, n23)  == n19;
    });

    node_destroy(root);
  }

  void test_node_maximum(void) {
    describe_test(INDENT0, "From test_node_max_and_min in NodeTest.");
    Spec spec;
    Node * root = node_new(13);

    spec.it("maximum for root node only", DO_SPEC_HANDLE {
      return (node_maximum(root) == root);
    });

    spec.it("minimum for root node only", DO_SPEC_HANDLE {
      return (node_minimum(root) == root);
    });

    Node * n2 = node_new(2);
    Node * n3 = node_new(3);
    Node * n5 = node_new(5);
    Node * n7 = node_new(7);
    Node * n11 = node_new(11);
    Node * n17 = node_new(17);
    Node * n19 = node_new(19);
    Node * n23 = node_new(23);
    Node * n29 = node_new(29);

    node_insert(root, n5);
    node_insert(root, n7);
    node_insert(root, n11);
    node_insert(root, n3);
    node_insert(root, n2);

    node_insert(root, n19);
    node_insert(root, n17);
    node_insert(root, n29);
    node_insert(root, n23);

    spec.it("maximum for tree with first 10 primes", DO_SPEC_HANDLE {
      return (node_maximum(root) == n29);
    });

    spec.it("minimum for tree with first 10 primes", DO_SPEC_HANDLE {
      return (node_minimum(root) == n2);
    });

    spec.it("maximum of minimum element", DO_SPEC_HANDLE {
      return (node_maximum(n2) == n2);
    });

    spec.it("minimum of minimum element", DO_SPEC_HANDLE {
      return (node_minimum(n2) == n2);
    });

    spec.it("maximum for left subtree with key 5", DO_SPEC_HANDLE {
      return (node_maximum(n5) == n11);
    });

    spec.it("minimum for left subtree with key 5", DO_SPEC_HANDLE {
      return (node_minimum(n5) == n2);
    });

    spec.it("maximum of right subtree with key 19", DO_SPEC_HANDLE {
      return (node_maximum(n19) == n29);
    });

    spec.it("minimum of right subtree with key 19", DO_SPEC_HANDLE {
      return (node_minimum(n19) == n17);
    });

    node_destroy(root);
  }

  void test_node_minimum(void) {
  }

  void test_node_is_full(void) {
  }

  void test_node_is_bst(void) {
    describe_test(INDENT0, "From test_node_is_bst in NodeTest");
    Spec spec;
    Node * root = node_new(17);

    spec.it("single node tree is bst", [&]() {
      return node_is_bst(root) == 1;
    });

    Node * n5 = node_new(5);
    Node * n23 = node_new(23);
    node_insert(root, n5);
    node_insert(root, n23);

    spec.it("three node tree is bst", [&]() {
      return node_is_bst(root) == 1;
    });

    Node * n14 = node_new(14);
    node_insert(n23, n14);
    spec.it("out of order subtree is not bst from root", [&]() {
      return node_is_bst(n23) == 1
             && node_is_bst(root) == 0;
    });

    node_destroy(root);
  }

  void test_node_height(void) {
    describe_test(INDENT0, "From test_node_height in NodeTest");
    Spec spec;
    Node * root = node_new(13);

    spec.it("height for single root node is 0", [&]() {
      return (node_height(root) == 0);
    });

    Node * n2 = node_new(2);
    Node * n3 = node_new(3);
    Node * n5 = node_new(5);
    Node * n7 = node_new(7);
    Node * n11 = node_new(11);
    Node * n17 = node_new(17);
    Node * n19 = node_new(19);
    Node * n23 = node_new(23);
    Node * n29 = node_new(29);

    node_insert(root, n5);
    node_insert(root, n7);
    node_insert(root, n11);
    node_insert(root, n3);
    node_insert(root, n2);

    node_insert(root, n19);
    node_insert(root, n17);
    node_insert(root, n23);
    node_insert(root, n29);

    spec.it("height of tree for first 10 primes", [&]() {
      return (node_height(root) == 3);
    });

    spec.it("height of leaf node which is also max is 0", [&]() {
      return (node_height(n29) == 0);
    });

    spec.it("height of leaf node which is also min is 0", [&]() {
      return (node_height(n2) == 0);
    });

    spec.it("left child of root has height 2", [&]() {
      return (node_height(n5) == 2);
    });

    spec.it("right child of root has height 2", [&]() {
      return (node_height(n19) == 2);
    });

    spec.it("n3 has one child hence height 1", [&]() {
      return node_height(n3) == 1;
    });

    spec.it("n23 has one child hence height 1", [&]() {
      return node_height(n23) == 1;
    });

    node_destroy(root);
  }

  void test_node_size(void) {
    describe_test(INDENT0, "From test_node_size in NodeTest.");
    Spec spec;
    Node * root = node_new(13);

    spec.it("size for root node only", DO_SPEC_HANDLE {
      return (node_size(root) == 1);
    });

    Node * n2 = node_new(2);
    Node * n3 = node_new(3);
    Node * n5 = node_new(5);
    Node * n7 = node_new(7);
    Node * n11 = node_new(11);
    Node * n17 = node_new(17);
    Node * n19 = node_new(19);
    Node * n23 = node_new(23);
    Node * n29 = node_new(29);

    node_insert(root, n5);
    node_insert(root, n7);
    node_insert(root, n11);
    node_insert(root, n3);
    node_insert(root, n2);

    node_insert(root, n19);
    node_insert(root, n17);
    node_insert(root, n29);
    node_insert(root, n23);

    spec.it("size for root node with 9 children", DO_SPEC_HANDLE {
      return (node_size(root) == 10);
    });

    spec.it("size for leaf node only", DO_SPEC_HANDLE {
      return (node_size(n2) == 1);
    });

    spec.it("size for left subtree", DO_SPEC_HANDLE {
      return (node_size(n5) == 5);
    });

    spec.it("size for right subtree", DO_SPEC_HANDLE {
      return (node_size(n19) == 4);
    });

    node_destroy(root);
  }

  void test_node_insert(void) {
    describe_test(INDENT0, "From test_node_insert in NodeTest.");
    Spec spec;
    Node * root = node_new(13);

    Node * n7 = node_new(7);
    spec.it("insert a single node to the left", DO_SPEC_HANDLE {
      node_insert(root, n7);
      return (root->left == n7);
    });

    Node * n21 = node_new(21);
    spec.it("insert a single node to the right", DO_SPEC_HANDLE {
      node_insert(root, n21);
      return (root->right == n21);
    });

    Node * n17 = node_new(17);
    spec.it("insert a left node into right subtree", DO_SPEC_HANDLE {
      node_insert(root, n17);
      return (root->right->left == n17);
    });

    Node * n11 = node_new(11);
    spec.it("insert a right node into left subtree", DO_SPEC_HANDLE {
      node_insert(root, n11);
      return (root->left->right == n11);
    });

    // node destroy walks the tree, so can only be called on the
    // root node.  If we were using a parent pointer, or passing
    // the parent down the recursion, this could be handled by setting
    // the child pointer in the parent to NULL.
    // node_destroy(n11);
    node_destroy(root);
  }

  void test_node_unlink(void) {
    describe_test(INDENT0, "From test_node_unlink");
    Spec spec;
    Node * root = node_new(17);

    spec.it("sets links to NULL for single node", DO_SPEC_HANDLE {
      node_unlink(root);
      return node_is_unlinked(root);
    });

    Node * n5 = node_new(5);
    Node * n23 = node_new(23);
    node_insert(root, n5);
    node_insert(root, n23);
    spec.it("unlinks root node with left and right children", DO_SPEC_HANDLE {
      node_unlink(root);
      return node_is_unlinked(root)
      && node_is_unlinked(n5)
      && node_is_unlinked(n23);
    });

    node_destroy(root);
    node_destroy(n5);
    node_destroy(n23);
  }

  void test_node_new_and_destroy(void) {
    describe_test(INDENT0, "From test_node_new_and_destroy in NodeTest.");
    Node * n = node_new(13);

    Spec spec;
    spec.it("Testing node_new", DO_SPEC_HANDLE {
      return (node_key(n) == 13);
    });

    node_destroy(n);
  }

  void test_node_list_keys(void) {
    describe_test(INDENT0, "From test_node_list_keys.");
    Spec spec;

    spec.it("collects a single value", DO_SPEC_HANDLE {
      Collector * expected = collector_new(15);
      Collector * actual = collector_new(15);
      collector_add(expected, 17);
      Node * root = node_new(17);
      node_list_keys(root, actual);
      int result = collector_equals(expected, actual);
      collector_destroy(expected);
      collector_destroy(actual);
      node_destroy(root);
      return result;
    });

  }


  void test_node_strip(void) {
    describe_test(INDENT0, "From test_node_strip in NodeTest.");
    Node * node = node_new(17);

    Spec spec;
    spec.it("new node should be stripped", DO_SPEC_HANDLE {
      // return node_stripped(node) == 1;
      return node_is_unlinked(node) == 1;
    });

    Node * left = node_new(5);
    node_insert(node, left);
    Node * right = node_new(23);
    node_insert(node, right);
    spec.it("should strip nodes", DO_SPEC_HANDLE {
      node_strip(node);
      return node_is_unlinked(node) == 1;
    });

    node_destroy(node);
    node_destroy(right);
    node_destroy(left);
  }

  void run_tests(void) {
    //setup();
    test_node_new_and_destroy();
    test_node_insert();
    test_node_left();
    test_node_right();
    test_node_key();
    test_node_collect();
    test_node_search_and_is_present();
    test_node_height();
    //test_node_destroy();
    test_node_minimum();
    test_node_maximum();
    //test_node_is_full();
    test_node_size();
    test_node_successor();
    test_node_is_bst();
    test_node_unlink();
    test_node_list_keys();
    test_node_strip();
    //teardown();
  }
};

void
test_node() {

  NodeTest * nt = new NodeTest(std::string("initial test"));
  nt->run_tests();
  delete nt;
}

int
main(int argc, char ** argv) {

  test_node();
  return 0;
}
