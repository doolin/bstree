#include <iostream>
#include <string>
#include <tree.h>

void Tree::insert(Node * node) {
  if (root == nullptr) {
    root = node;
    return;
  }
  this->root->insert(node);
}

Node * Tree::search(int key) {
  if (root == nullptr) return nullptr;
  return search_node(key, root);
}

Node * Tree::maximum(void) {
  if (root == nullptr) return nullptr;
  return root->maximum();
}

Node * Tree::minimum(void) {
  if (root == nullptr) return nullptr;
  return root->minimum();
}

int Tree::size(void) {
  if (root == nullptr) return 0;
  return root->size();
}

int Tree::height(void) {
  if (root == nullptr) return 0;
  return root->height();
}

Node * Tree::successor(Node * node) {
  if (root == nullptr) return nullptr;
  return root->successor(node);
}

Node * Tree::predecessor(Node * node) {
  if (root == nullptr) return nullptr;
  return root->predecessor(node);
}

void Tree::transplant(Node * u, Node * v) {
  if (u == root) {
    root = v;
  } else if (u->parent->left == u) {
    u->parent->left = v;
  } else {
    u->parent->right = v;
  }

  if (v != nullptr) {
    v->parent = u->parent;
  }
}

Node * Tree::delete_node(int key) {
  Node * z = search(key);

  if (z->left == nullptr) {
    transplant(z, z->right);
  } else if (z->right == nullptr) {
    transplant(z, z->left);
  } else { // two children
    Node * y = z->right->minimum();
    // if y is not z successor, do extra stuff here
    if (y->parent != z) {
      transplant(y, y->right);
      z->right->parent = y;
      y->right = z->right;
    }
    transplant(z, y);
    y->left = z->left;
    y->left->parent = y;
  }

  z->unlink();
  return z;
}

bool Tree::is_bst() {
  if (this->root == nullptr) { return true; }
  return this->root->is_bst();
}

bool Tree::is_empty() {
  if (this->root == nullptr) { return true; }
  return false;
}

bool Tree::is_present(int key) {
  return this->root->is_present(key);
}

#if 1
// TODO: move the guts of this method to Node class
Node * Tree::search_node(int key, Node * node) {
  if (node == nullptr) return node;
  if (node->key == key) return node;

  if (node->left != nullptr && key < node->key) {
    return search_node(key, node->left);
  } else if (node->right != nullptr) {
    return search_node(key, node->right);
  }
  return nullptr;
}
#endif

void Tree::collect(std::vector<int> & keys) {
  if (this->root == nullptr) return;
  this->root->collect(keys);
}

std::vector<int> Tree::list_keys() {
  std::vector<int> keys;
  collect(keys);
  return keys;
}

std::vector<int> Tree::iterative_inorder_traverse() {
  std::vector<int> keys;

  Node * stack[100];

  Node * current = root;

  if (is_empty()) {
    return keys;
  }

  while (current->left != nullptr) {
    current = current->left;
  }

  int iterations = 0;

  while (current != nullptr) {

    iterations++;
    keys.push_back(current->key);
    if (iterations > 8) break;

    if (current->right != nullptr) {
      current = current->right;

      while (current->left != nullptr) {
        current = current->left;
      }
    } else if (current->parent != nullptr) {

      current = current->parent;
    }

  }

  return keys;
}
