#include <iostream>
#include <string>
#include <tree.h>

void Tree::add(Node * node) {
  if (root == NULL) {
    root = node;
    return;
  }
  this->root->add(node);
}

Node * Tree::find(int value) {
  if (root == NULL) return NULL;
  return find_node(value, root);
}

Node * Tree::maximum(void) {
  if (root == NULL) return NULL;
  return root->maximum();
}

Node * Tree::minimum(void) {
  if (root == NULL) return NULL;
  return root->minimum();
}

int Tree::size(void) {
  if (root == NULL) return 0;
  return root->size();
}

int Tree::height(void) {
  if (root == NULL) return 0;
  return root->height();
}

bool Tree::is_present(int value) {
  return this->root->is_present(value);
}

// TODO: move the guts of this method to Node class
Node * Tree::find_node(int value, Node * node) {
  if (node == NULL) return node;
  if (node->value == value) return node;

  if (node->left != NULL && value < node->value) {
    return find_node(value, node->left);
  } else if (node->right != NULL) {
    return find_node(value, node->right);
  }
  return NULL;
}

std::vector<int> Tree::collect() {
  collect_values(root);
  return values;
}

// TODO: move to Node class
void Tree::collect_values(Node * node) {
  get_left(node);
  values.push_back(node->value);
  get_right(node);
}

void Tree::get_left(Node * node) {
  if (node->left == NULL) {
    return;
  } else {
    collect_values(node->left);
  }
}

void Tree::get_right(Node * node) {
  if (node->right == NULL) {
    return;
  } else {
    collect_values(node->right);
  }
}
