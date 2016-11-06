#include <string>
#include <vector>
#include <memory>
#include <cppunit/TestCase.h>

#include "./testutils.h"
#include <tree.h>
#include <node.h>


using std::string;

class TreeTest : public CppUnit::TestCase {

/*
Node root(25);
Tree test_tree(&root);
Node node2(43);
Node node3(8);
Node node4(10);
Node node5(15);
Node node6(33);
Node node7(97);
Node node8(4);
test_tree.insert(&node2);
test_tree.insert(&node3);
test_tree.insert(&node4);
test_tree.insert(&node5);
test_tree.insert(&node6);
test_tree.insert(&node7);
test_tree.insert(&node8);
*/

public:
  TreeTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_instantiation() {
    describe_test(INDENT0, "From test_instantiation in TreeTest.");
    Spec spec;
    spec.it("instantiaton without Node", DO_SPEC {
      Tree tree = Tree();
      return (tree.root == nullptr);
    });

    spec.it("instantiaton with Node", DO_SPEC {
      Node root(1);
      Tree tree(&root);
      return (tree.root->key == root.key);
    });
  }

  void test_find_right_node() {
    Spec spec;
    spec.it("Testing Tree.find for right node", DO_SPEC {
      Node node(25);
      Tree tree(&node);
      Node node2(43);
      Node node3(8);
      tree.insert(&node2);
      tree.insert(&node3);

      Node * n = tree.find(43);
      return (n->key == node2.key);
    });
  }

  void test_find_left_node() {
    Spec spec;
    spec.it("Testing Tree.find for left node", DO_SPEC {
      Node node(25);
      Tree tree(&node);
      Node node2(43);
      Node node3(8);
      tree.insert(&node2);
      tree.insert(&node3);

      Node * n = tree.find(8);
      return (n->key == node3.key);
    });
  }

  void test_find_root_node() {
    Spec spec;
    spec.it("Testing Tree.find for root node", DO_SPEC {
      Node node(25);
      Tree tree(&node);
      Node node2(43);
      Node node3(8);
      tree.insert(&node2);
      tree.insert(&node3);

      Node * n = tree.find(25);
      return (n->key == node.key);
    });
  }

  //TODO: add test for nullptr node indicating key not found.

  void test_find() {
    Spec spec;
    spec.it("Testing Tree.find with 8 nodes", DO_SPEC {
      Node node(25);
      Tree tree(&node);
      Node node2(43);
      Node node3(8);
      Node node4(10);
      Node node5(15);
      Node node6(33);
      Node node7(97);
      Node node8(4);
      tree.insert(&node2);
      tree.insert(&node3);
      tree.insert(&node4);
      tree.insert(&node5);
      tree.insert(&node6);
      tree.insert(&node7);
      tree.insert(&node8);

      Node * n = tree.find(43);
      return (n->key == node2.key);
    });
  }

  void test_is_present() {
    Spec spec;
    spec.it("Testing Tree.is_present with 8 nodes", DO_SPEC {
      Node node(25);
      Tree tree(&node);
      Node node2(43);
      Node node3(8);
      Node node4(10);
      Node node5(15);
      Node node6(33);
      Node node7(97);
      Node node8(4);
      tree.insert(&node2);
      tree.insert(&node3);
      tree.insert(&node4);
      tree.insert(&node5);
      tree.insert(&node6);
      tree.insert(&node7);
      tree.insert(&node8);

      bool result = tree.is_present(43);
      return (result == true);
    });
  }

  void test_collect() {
    Spec spec;
    spec.it("Testing Tree.collect", DO_SPEC {
      Node node(25);
      Tree tree(&node);
      std::vector<int> a1{4, 8, 10, 15, 25, 33, 43, 97};
      Node node2(43);
      Node node3(8);
      Node node4(10);
      Node node5(15);
      Node node6(33);
      Node node7(97);
      Node node8(4);
      tree.insert(&node2);
      tree.insert(&node3);
      tree.insert(&node4);
      tree.insert(&node5);
      tree.insert(&node6);
      tree.insert(&node7);
      tree.insert(&node8);
      std::vector<int> a2 = tree.collect();
      return (a1 == a2);
    });
  }

  void test_insert() {
    Spec spec;
    spec.it("insert root node to empty tree", DO_SPEC {
        Tree tree = Tree();
        Node root(13);
        tree.insert(&root);
        return (tree.root == &root);
    });

    spec.it("Testing Tree.insert", DO_SPEC {
      Node node(20);
      Tree tree(&node);
      Node node2(43);
      Node node3(8);
      Node node4(10);
      Node node5(15);
      Node node6(33);
      Node node7(97);
      tree.insert(&node2);
      tree.insert(&node3);
      tree.insert(&node4);
      tree.insert(&node5);
      tree.insert(&node6);
      tree.insert(&node7);
      return (tree.root->right->left == &node6);
    });
  }

  void test_successor(void) {
    describe_test(INDENT0, "From test_successor in TreeTest.");
    Spec spec;
    spec.it("Testing Tree.successor", DO_SPEC {
      Node root(17);
      Tree tree(&root);
      return tree.successor(&root) == &root;
    });
  }

  void test_predecessor(void) {
    describe_test(INDENT0, "From test_predecessor in TreeTest.");
    Spec spec;
    spec.it("Testing Tree.predecessor", DO_SPEC {
        Node root(17);
        Tree tree(&root);
        return tree.predecessor(&root) == &root;
    });
  }

  void test_maximum() {
    describe_test(INDENT0, "From test_maximum in TreeTest.");
    Spec spec;
    spec.it("Testing Tree.maximum", DO_SPEC {
      Node root(3);
      Tree tree(&root);
      Node node2(1);
      Node node3(2);
      Node node17(17);
      tree.insert(&node2);
      tree.insert(&node3);
      tree.insert(&node17);
      return (tree.maximum() == &node17);
    });
  }

  void test_minimum() {
    describe_test(INDENT0, "From test_minimum in TreeTest");
    Spec spec;
    spec.it("Testing Tree.minimum", DO_SPEC {
      Node root(3);
      Tree tree(&root);
      Node node2(1);
      Node node3(2);
      tree.insert(&node2);
      tree.insert(&node3);
      return (tree.minimum() == &node2);
    });
  }

  void test_height() {
    describe_test(INDENT0, "From test_height in TreeTest");
    Spec spec;
    Tree tree = Tree();

    spec.it("size of empty tree is 0", [&]() {
        return (tree.height() == 0);
    });

    Node root(13);
    tree.insert(&root);
    spec.it("height of tree with single node is 0", [&]() {
        return (tree.height() == 0);
    });
  }

  void test_size() {
    describe_test(INDENT0, "From test_size in TreeTest");
    Spec spec;
    Node root(11);
    Tree tree = Tree();
    Node n2(2);

    spec.it("empty tree is size 0", [&]() {
      return (tree.size() == 0);
    });

    tree.insert(&root);
    spec.it("tree with root node only is size 1", [&]() {
      return (tree.size() == 1);
    });

    Node n17(17);
    Node n3(3);
    tree.insert(&n3);
    tree.insert(&n17);
    spec.it("node with left and right child", [&]() {
        return (tree.size() == 3);
    });
  }

  void test_is_bst(void) {
    describe_test(INDENT0, "From test_is_bst in TreeTest");
    Spec spec;
    Tree tree = Tree();
    Node root = Node(17);
    tree.insert(&root);

    spec.it("tree with single node is bst", [&]() {
        return tree.is_bst() == true;
    });
  }

  void test_is_empty(void) {
    describe_test(INDENT0, "From test_is_empty in TreeTest");
    Spec spec;
    Tree tree = Tree();

    spec.it("tree with no root node is empty", [&]() {
        return tree.is_empty() == true;
    });

    Node root(17);
    tree.insert(&root);

    spec.it("tree with root is not empty", [&]() {
        return tree.is_empty() == false;
    });
  }

  // my own edification b/c I reach for new and delete
  void test_unique_ptr(void) {
    Spec spec;
    spec.it("Testing Tree.insert", DO_SPEC {
      // std::unique_ptr<Node> node(new Node(20));
      Node node(20);
      Tree tree(&node);
      Node node2(43);
      Node node3(8);
      Node node4(10);
      Node node5(15);
      Node node6(33);
      Node node7(97);
      tree.insert(&node2);
      tree.insert(&node3);
      tree.insert(&node4);
      tree.insert(&node5);
      tree.insert(&node6);
      tree.insert(&node7);
      return (tree.root->right->left == &node6);
    });
  }

  void test_transplant(void) {
    describe_test(INDENT0, "From test_transplant in TreeTest");
    Spec spec;

    spec.it("replace nullptr to root node", [&]() {
      Tree tree = Tree();
      Node root(17);
      tree.insert(&root);
      tree.transplant(&root, nullptr);
      return tree.is_empty();
    });

    spec.it("transplant left child to root", [&]() {
      Tree tree = Tree();
      Node root(17);
      Node n5(5);
      tree.insert(&root);
      tree.insert(&n5);
      tree.transplant(&root, &n5);
      return tree.root == &n5;
    });

    spec.it("transplant grandchild to left child", [&]() {
      Tree tree = Tree();
      Node root(17);
      Node n5(5);
      Node n7(7);
      tree.insert(&root);
      tree.insert(&n5);
      tree.insert(&n7);
      tree.transplant(&n5, &n7);
      return n7.parent == tree.root && tree.root->left == &n7;
    });

    spec.it("transplant right child to root", [&]() {
      Tree tree = Tree();
      Node root(17);
      Node n23(23);
      tree.insert(&root);
      tree.insert(&n23);
      tree.transplant(&root, &n23);
      return tree.root == &n23;
    });

    spec.it("transplant grandchild to right child", [&]() {
      Tree tree = Tree();
      Node root(17);
      Node n23(23);
      Node n29(29);
      tree.insert(&root);
      tree.insert(&n23);
      tree.insert(&n29);
      tree.transplant(&n23, &n29);
      return n29.parent == tree.root && tree.root->right == &n29;
    });
  }

  void runTest() {
    test_instantiation();
    test_insert();
    test_size();
    test_height();
    test_successor();
    test_predecessor();
    test_maximum();
    test_minimum();
    test_find_root_node();
    test_find_right_node();
    test_find_left_node();
    test_find();
    test_is_present();
    test_collect();
    test_is_bst();
    test_is_empty();
    test_transplant();
    // test_unique_ptr();
  }
};

void
test_node() {

  TreeTest * nt = new TreeTest(std::string("initial test"));
  nt->runTest();
  delete nt;
}


int
main(int argc, char ** argv) {

  test_node();
  return 0;
}
