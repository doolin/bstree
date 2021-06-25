#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <tree.h>
#include <collector.h>
#include "../src/tree_private.h"
#include "../src/node_private.h"


using std::string;

class TreeTest : public CppUnit::TestCase {

  int
  node_stripped(Node * n) {
    return n->parent == NULL && n->left == NULL && n->right == NULL ? 1 : 0;
  }

public:
  TreeTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_tree_collect(void) {
    describe_test(INDENT0, "From test_tree_collect in TreeTest.");
    Spec spec;
    Tree * t = tree_new();
    Node * root = node_new(13);
    tree_insert(t, root);
    Collector * expected = collector_new(100);
    Collector * actual = collector_new(100);

    spec.it("array with single element for single node", DO_SPEC_HANDLE {
      collector_add(expected, 13);
      tree_collect(t, (void *) actual);
      return (collector_equals(expected, actual));
    });

    tree_delete(t);
    collector_destroy(expected);
    collector_destroy(actual);
  }

  void test_tree_inorder_iter(void) {
    describe_test(INDENT0, "From test_tree_inorder_iter in TreeTest.");
    Spec spec;
    Tree * t = tree_new();
    Collector * expected = collector_new(100);
    Collector * actual = collector_new(100);
    Node * root = node_new(17);

    spec.it("empty tree returns empty array", DO_SPEC_HANDLE {
      tree_inorder_iter(t, (void *)actual);
      return collector_empty(actual);
    });

    tree_insert(t, root);
    spec.it("array with single element for single node", DO_SPEC_HANDLE {
      collector_add(expected, 17);
      tree_inorder_iter(t, (void *) actual);
      return (collector_equals(expected, actual));
    });

    Node * node7 = node_new(7);
    tree_insert(t, node7);
    spec.it("finds a single left child", DO_SPEC_HANDLE {
      collector_reset(actual);
      collector_reset(expected);
      collector_add(expected, 7);
      collector_add(expected, 17);
      tree_inorder_iter(t, (void *)actual);
      return collector_equals(expected, actual);
    });

    tree_delete_node(t, 7); // node memory is not collected here...
    Node * node23 = node_new(23);
    tree_insert(t, node23);
    spec.it("finds a single right node", DO_SPEC_HANDLE {
      collector_reset(actual);
      collector_reset(expected);
      collector_add(expected, 17);
      collector_add(expected, 23);
      tree_inorder_iter(t, actual);
      return collector_equals(expected, actual);
    });

    Node * node19 = node_new(19);
    Node * node29 = node_new(29);
    tree_insert(t, node7);
    tree_insert(t, node29);
    tree_insert(t, node19);
    spec.it("finds full right subtree", DO_SPEC_HANDLE {
      collector_reset(actual);
      collector_reset(expected);
      collector_add(expected, 7);
      collector_add(expected, 17);
      collector_add(expected, 19);
      collector_add(expected, 23);
      collector_add(expected, 29);
      tree_inorder_iter(t, actual);
      return collector_equals(expected, actual);
    });

    Node * node3 = node_new(3);
    Node * node5 = node_new(5);
    spec.it("finds full left subtree", DO_SPEC_HANDLE {
      collector_reset(actual);
      collector_reset(expected);
      collector_add(expected, 3);
      collector_add(expected, 5);
      collector_add(expected, 7);
      collector_add(expected, 17);
      collector_add(expected, 19);
      collector_add(expected, 23);
      collector_add(expected, 29);
      tree_insert(t, node3);
      tree_insert(t, node5);
      tree_inorder_iter(t, actual);
      return collector_equals(expected, actual);
    });

    tree_delete_node(t, 3);
    tree_delete_node(t, 5);
    tree_delete_node(t, 7);
    tree_delete_node(t, 17);
    tree_delete_node(t, 19);
    tree_delete_node(t, 23);
    tree_delete_node(t, 29);

    spec.it("finds degenerate left tree", DO_SPEC_HANDLE {
      collector_reset(actual);
      collector_reset(expected);
      tree_insert(t, node19);
      tree_insert(t, node3);
      tree_insert(t, node5);
      tree_insert(t, node7);
      tree_insert(t, root);
      collector_add(expected, 3);
      collector_add(expected, 5);
      collector_add(expected, 7);
      collector_add(expected, 17);
      collector_add(expected, 19);
      tree_inorder_iter(t, actual);
      return collector_equals(expected, actual);
    });

    tree_delete_node(t, 3);
    tree_delete_node(t, 5);
    tree_delete_node(t, 7);
    tree_delete_node(t, 17);
    tree_delete_node(t, 19);

    spec.it("finds degenerate right tree", DO_SPEC_HANDLE {
      collector_reset(actual);
      collector_reset(expected);
      tree_insert(t, node7);
      tree_insert(t, node29);
      tree_insert(t, node23);
      tree_insert(t, node19);
      tree_insert(t, root);
      collector_add(expected, 7);
      collector_add(expected, 17);
      collector_add(expected, 19);
      collector_add(expected, 23);
      collector_add(expected, 29);
      tree_inorder_iter(t, actual);
      return collector_equals(expected, actual);
    });


    // TODO: compile and run this in linux to leverage valgrind
    // and ensure all the nodes are being freed.
    tree_delete(t);
    collector_destroy(expected);
    collector_destroy(actual);
  }

  void test_tree_search(void) {
    describe_test(INDENT0, "From test_tree_search in NodeTest.");
    Spec spec;
    Tree * t = tree_new();
    Node * root = node_new(13);
    tree_insert(t, root);

    spec.it("root element finds itself", DO_SPEC_HANDLE {
      Node * actual = tree_search(t, 13);
      return actual == root;
    });
    spec.it("root element is present", DO_SPEC_HANDLE {
      return tree_is_present(t, 13) == 1;
    });

    Node * n17 = node_new(17);
    tree_insert(t, n17);
    spec.it("finds a right leaf", DO_SPEC_HANDLE {
      Node * actual = tree_search(t, 17);
      return actual == n17;
    });
    spec.it("right leaf is present", DO_SPEC_HANDLE {
      return tree_is_present(t, 17) == 1;
    });

    Node * n3 = node_new(3);
    tree_insert(t, n3);
    spec.it("finds a left leaf", DO_SPEC_HANDLE {
      Node * actual = tree_search(t, 3);
      return actual == n3;
    });
    spec.it("left leaf is present", DO_SPEC_HANDLE {
      return tree_is_present(t, 3) == 1;
    });


    Node * n2 = node_new(2);
    Node * n5 = node_new(5);
    Node * n7 = node_new(7);
    Node * n11 = node_new(11);
    Node * n19 = node_new(19);
    Node * n23 = node_new(23);
    tree_insert(t, n23);
    tree_insert(t, n19);
    tree_insert(t, n5);
    tree_insert(t, n7);
    tree_insert(t, n11);
    tree_insert(t, n2);

    spec.it("finds node at end", DO_SPEC_HANDLE {
      Node * actual = tree_search(t, 23);
      return actual == n23;
    });
    spec.it("finds node at end", DO_SPEC_HANDLE {
      return tree_is_present(t, 23) == 1;
    });


    spec.it("doesn't find value which isn't in tree", DO_SPEC_HANDLE {
      Node * actual = tree_search(t, -100);
      return actual == NULL;
    });
    spec.it("will not find node which isn't in tree", DO_SPEC_HANDLE {
      return tree_is_present(t, 123) == 0;
    });


    tree_delete(t);
  }

  void test_tree_is_present(void) {
  }

  void test_tree_height(void) {
    describe_test(INDENT0, "From test_tree_height in TreeTest");
    Spec spec;
    Tree * tree = tree_new();

    spec.it("empty tree has height 0", [&]() {
      return tree_height(tree) == 0;
    });

    Node * root = node_new(13);
    tree_insert(tree, root);
    spec.it("tree with only root node has height 0", [&]() {
      return tree_height(tree) == 0;
    });

    tree_delete(tree);
  }

  void test_tree_destroy(void) {
  }

  void test_tree_maximum(void) {
    describe_test(INDENT0, "From test_tree_max_and_min in TreeTest");
    Spec spec;
    Tree * tree = tree_new();
    Node * root = node_new(13);
    tree_insert(tree, root);


    spec.it("maximum for root node only", DO_SPEC_HANDLE {
      return (tree_maximum(tree) == root);
    });

    spec.it("minimum for root node only", DO_SPEC_HANDLE {
      return (tree_minimum(tree) == root);
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

    tree_insert(tree, n5);
    tree_insert(tree, n7);
    tree_insert(tree, n11);
    tree_insert(tree, n3);
    tree_insert(tree, n2);

    tree_insert(tree, n19);
    tree_insert(tree, n17);
    tree_insert(tree, n29);
    tree_insert(tree, n23);

    spec.it("maximum for tree with first 10 primes", DO_SPEC_HANDLE {
      return (tree_maximum(tree) == n29);
    });

    spec.it("minimum for tree with first 10 primes", DO_SPEC_HANDLE {
      return (tree_minimum(tree) == n2);
    });

    tree_delete(tree);
  }

  void test_tree_successor(void) {
    describe_test(INDENT0, "From test_tree_successor in TreeTest.");
    Spec spec;
    Tree * t = tree_new();
    Node * root = node_new(13);
    tree_insert(t, root);

    spec.it("root of tree with single node is own successor", DO_SPEC_HANDLE {
      return tree_successor(t, root) == root;
    });
    tree_delete(t);
  }

  void test_tree_predecessor(void) {
    describe_test(INDENT0, "From test_tree_predecessor in TreeTest.");
    Spec spec;
    Tree * t = tree_new();
    Node * root = node_new(13);
    tree_insert(t, root);

    spec.it("root of tree with single node is own predecessor", DO_SPEC_HANDLE {
      return tree_predecessor(t, root) == root;
    });
    tree_delete(t);
  }

  void test_tree_is_full(void) {
  }

  void test_tree_is_bst(void) {
    describe_test(INDENT0, "From test_tree_is_bst in TreeTest.");
    Spec spec;
    Tree * t = tree_new();
    Node * root = node_new(17);
    tree_insert(t, root);

    spec.it("tree with single node is bst", DO_SPEC_HANDLE {
      return tree_is_bst(t) == 1;
    });
    tree_delete(t);
  }

  void test_tree_size(void) {
    describe_test(INDENT0, "From test_tree_size in TreeTest.");
    Spec spec;
    Tree * t = tree_new();

    spec.it("size for root node only", DO_SPEC_HANDLE {
      return (tree_size(t) == 0);
    });

    Node * root = node_new(13);
    tree_insert(t, root);

    spec.it("size for tree with root node only", DO_SPEC_HANDLE {
      return (tree_size(t) == 1);
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

    spec.it("size for tree with 9 children", DO_SPEC_HANDLE {
      return (tree_size(t) == 10);
    });

    tree_delete(t);
  }

  void test_tree_insert(void) {
    describe_test(INDENT0, "From test_tree_insert in TreeTest.");
    Tree * t = tree_new();
    Node * root = node_new(13);
    tree_insert(t, root);

    Spec spec;
    spec.it("sets the root node in an empty tree", DO_SPEC_HANDLE {
      return (t->root = root);
    });

    Node * n7 = node_new(7);
    spec.it("insert a single node to the left", DO_SPEC_HANDLE {
      tree_insert(t, n7);
      return (t->root->left == n7);
    });

    Node * n21 = node_new(21);
    spec.it("insert a single node to the right", DO_SPEC_HANDLE {
      tree_insert(t, n21);
      return (t->root->right == n21);
    });

    Node * n17 = node_new(17);
    spec.it("insert a left node into right subtree", DO_SPEC_HANDLE {
      tree_insert(t, n17);
      return (t->root->right->left == n17);
    });

    Node * n11 = node_new(11);
    spec.it("insert a right node into left subtree", DO_SPEC_HANDLE {
      tree_insert(t, n11);
      return (t->root->left->right == n11);
    });

    tree_delete(t);
  }

  void test_tree_is_empty(void) {
    describe_test(INDENT0, "From test_tree_is_empty in TreeTest.");
    Tree * t = tree_new();

    Spec spec;
    spec.it("tree is empty without root node", DO_SPEC_HANDLE {
      return (tree_is_empty(t) == TRUE);
    });

    Node * root = node_new(17);
    tree_insert(t, root);

    spec.it("tree with root is not empty", DO_SPEC_HANDLE {
      return (tree_is_empty(t) == false);
    });

    tree_delete(t);
  }

  void test_tree_new_and_delete(void) {
    describe_test(INDENT0, "From test_tree_new_and_delete in TreeTest.");
    Tree * t = tree_new();

    Spec spec;
    spec.it("instantiates a tree object", DO_SPEC_HANDLE {
      return (t != NULL);
    });

    tree_delete(t);
  }

  void test_tree_unlink(void) {
    describe_test(INDENT0, "From test_tree_unlink.");
    Node * root = node_new(17);
    Tree * tree = tree_new();
    tree_insert(tree, root);

    Spec spec;
    spec.it("unlink root in single node tree", DO_SPEC_HANDLE {
      tree_unlink(tree);
      return node_is_unlinked(root) && tree->root == NULL;
    });

    Node * n5 = node_new(5);
    Node * n23 = node_new(23);
    tree_insert(tree, root);
    tree_insert(tree, n5);
    tree_insert(tree, n23);

    spec.it("unlink tree with left and right children", DO_SPEC_HANDLE {
      tree_unlink(tree);
      return node_is_unlinked(root)
      && node_is_unlinked(n5)
      && node_is_unlinked(n23);
    });

    node_delete(root);
    node_delete(n5);
    node_delete(n23);
    tree_delete(tree);
  }

  void test_tree_transplant(void) {
    describe_test(INDENT0, "From test_node_transplant in TreeTest.");
    Node * root = node_new(17);
    Tree * tree = tree_new();
    tree_insert(tree, root);

    Spec spec;
    spec.it("transplant root with nil", DO_SPEC_HANDLE {
      tree_transplant(tree, root, NULL);
      return tree_is_empty(tree) == TRUE;
    });

    node_delete(root);
    tree_delete(tree);

    Node * n5 = node_new(5);
    root = node_new(17);
    tree = tree_new();
    tree_insert(tree, root);
    tree_insert(tree, n5);
    spec.it("transplant left child to root", DO_SPEC_HANDLE {
      tree_transplant(tree, root, n5);
      return tree->root == n5 && n5->parent == NULL;
    });

    node_delete(root);
    tree_delete(tree);

    Node * n23 = node_new(23);
    root = node_new(17);
    tree = tree_new();
    tree_insert(tree, root);
    tree_insert(tree, n23);
    spec.it("transplant right child to root", DO_SPEC_HANDLE {
      tree_transplant(tree, root, n23);
      return tree->root == n23 && n23->parent == NULL;
    });

    node_delete(root);
    tree_delete(tree);

    Node * n7 = node_new(7);
    n5 = node_new(5);
    root = node_new(17);
    tree = tree_new();
    tree_insert(tree, root);
    tree_insert(tree, n5);
    tree_insert(tree, n7);
    spec.it("transplants grandchild into left child", DO_SPEC_HANDLE {
      tree_transplant(tree, n5, n7);
      return tree->root->left == n7 && n7->parent == tree->root;
    });

    node_delete(n5);
    tree_delete(tree);

    Node * n29 = node_new(29);
    n23 = node_new(23);
    root = node_new(17);
    tree = tree_new();
    tree_insert(tree, root);
    tree_insert(tree, n23);
    tree_insert(tree, n29);
    spec.it("transplants grandchild into right child", DO_SPEC_HANDLE {
      tree_transplant(tree, n23, n29);
      return tree->root->right == n29; // && n29->parent == tree->root;
    });

    node_delete(n23);
    tree_delete(tree);
  }

  void test_tree_list_keys(void) {
    describe_test(INDENT0, "From test_tree_list_keys in TreeTest.");
    Tree * t = tree_new();
    Node * root = node_new(17);
    tree_insert(t, root);
    Collector * expected = collector_new(100);
    Collector * actual = collector_new(100);

    Spec spec;
    spec.it("array with single element for single node", DO_SPEC_HANDLE {
      collector_add(expected, 17);
      tree_collect(t, (void *) actual);
      return (collector_equals(expected, actual));
    });

    tree_delete(t);
    collector_destroy(expected);
    collector_destroy(actual);
  }

  void test_tree_delete_node() {
    describe_test(INDENT0, "From test_tree_delete_node in TreeTest");
    Spec spec;
    Tree * t = tree_new();
    Node * root = node_new(17);
    tree_insert(t, root);
    Node * n2 = node_new(2);
    Node * n3 = node_new(3);
    Node * n5 = node_new(5);
    Node * n7 = node_new(7);
    Node * n11 = node_new(11);
    Node * n13 = node_new(13);
    Node * n19 = node_new(19);
    Node * n23 = node_new(23);
    Node * n29 = node_new(29);

    tree_insert(t, n5);
    tree_insert(t, n3);
    tree_insert(t, n2);
    tree_insert(t, n7);
    tree_insert(t, n11);
    tree_insert(t, n13);
    tree_insert(t, n23);
    tree_insert(t, n19);
    tree_insert(t, n29);

    int size = 0;
    int is_present = 0;
    Node * deleted;
    // Collector * expected = collector_new(100);
    // Collector * actual = collector_new(100);
    // Node * left;
    // Node * right;
    // Node * parent;

    spec.it("case 1a: node has no left child, right child is NULL", DO_SPEC_HANDLE {
      deleted = tree_delete_node(t, 2);
      size = tree_size(t);
      is_present = tree_is_present(t, 2);
      return deleted == n2
      && size == 9
      && is_present == 0
      && node_stripped(deleted) == 1
      && n3->left == NULL;
    });

    spec.it("case 1b: node has no left child, right child is not NULL", DO_SPEC_HANDLE {
      deleted = tree_delete_node(t, 11);
      size = tree_size(t);
      is_present = tree_is_present(t, 11);
      // std::cout << "size: " << size << std::endl;
      return deleted == n11
      && size == 8
      && is_present == 0
      && node_stripped(deleted) == 1
      && n7->right == n13;
    });

    tree_insert(t, n2);

    spec.it("case 2: node has left child, right child is NULL", DO_SPEC_HANDLE {
      deleted = tree_delete_node(t, 3);
      size = tree_size(t);
      is_present = tree_is_present(t, 3);
      return deleted == n3
      && size == 8
      && is_present == 0
      && node_stripped(deleted) == 1
      && n2->parent == n5
      && n5->left == n2;
    });

    spec.it("root node with left and right children", DO_SPEC_HANDLE {
      deleted = tree_delete_node(t, 17);
      size = tree_size(t);
      is_present = tree_is_present(t, 17);
      return deleted == root
      && size == 7
      && is_present == 0
      && t->root == n19
      && node_stripped(deleted) == 1
      && t->root->left == n5
      && n5->parent == t->root
      && t->root->right == n23
      && n23->parent == t->root
      && n23->left == NULL;
    });

    spec.it("left child with both right and left children", DO_SPEC_HANDLE {
      deleted = tree_delete_node(t, 5);
      size = tree_size(t);
      is_present = tree_is_present(t, 5);
      return deleted == n5
      && size == 6
      && is_present == 0
      && node_stripped(deleted) == 1
      && t->root->left == n7
      && n7->parent == t->root
      && n7->left == n2
      && n2->parent == n7;
    });

    spec.it("left child with both right and left children (case 2)", DO_SPEC_HANDLE {
      deleted = tree_delete_node(t, 7);
      size = tree_size(t);
      is_present = tree_is_present(t, 7);
      return deleted == n7
      && size == 5
      && is_present == 0
      && node_stripped(deleted) == 1
      && t->root->left == n13
      && n13->parent == t->root
      && n13->right == NULL
      && n13->left == n2
      && n2->parent == n13;
    });

    spec.it("left child from root, in line", DO_SPEC_HANDLE {
      deleted = tree_delete_node(t, 13);
      size = tree_size(t);
      is_present = tree_is_present(t, 13);
      return deleted == n13
      && size == 4
      && is_present == 0
      && node_stripped(deleted) == 1
      && t->root->left == n2
      && n2->parent == t->root;
    });

    spec.it("delete several nodes in a row", DO_SPEC_HANDLE {
      tree_delete_node(t, 19);
      tree_delete_node(t, 2);
      deleted = tree_delete_node(t, 23);
      is_present = tree_is_present(t, 23);
      size = tree_size(t);
      return deleted == n23
      && size == 1
      && is_present == 0
      && tree_is_present(t, 19) == 0
      && tree_is_present(t, 2) == 0
      && node_stripped(deleted) == 1
      && node_stripped(n19) == 1
      && node_stripped(n2) == 1
      && node_stripped(n29) == 1
      && t->root == n29;
    });


    spec.it("delete root from single node tree", DO_SPEC_HANDLE {
      return tree_delete_node(t, 29) == n29
      && tree_is_present(t, 29) == 0
      && node_stripped(n29) == 1
      && tree_size(t) == 0
      && t->root == NULL;
    });


    node_delete(n2);
    node_delete(n3);
    node_delete(n5);
    node_delete(n7);
    node_delete(n11);
    node_delete(n13);
    node_delete(root);
    node_delete(n19);
    node_delete(n23);
    node_delete(n29);
    tree_delete(t);
  }

  void run_tests(void) {
    test_tree_new_and_delete();
    test_tree_insert();
    test_tree_collect();
    test_tree_inorder_iter();
    test_tree_search();
    test_tree_height();
    test_tree_maximum();
    test_tree_successor();
    test_tree_predecessor();
    //test_tree_is_full();
    test_tree_is_empty();
    test_tree_is_bst();
    test_tree_size();
    test_tree_unlink();
    test_tree_transplant();
    test_tree_list_keys();
    test_tree_delete_node();
  }
};


void
test_tree() {

  TreeTest * tt = new TreeTest(std::string("initial test"));
  tt->run_tests();
  delete tt;
}


int
main(int argc, char ** argv) {

  test_tree();
  return 0;
}
