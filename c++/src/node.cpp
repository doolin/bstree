#include <string>
#include <iostream>
#include <cstdlib>
#include <vector>
#include <yaml-cpp/yaml.h>
#include <node.h>


void Node::insert(Node * node) {
  if (node->key < this->key) {
    insert_left(node);
  } else {
    insert_right(node);
  }
}

void Node::unlink() {
  left = right = parent = nullptr;
}

bool Node::is_unlinked() {
  return left == nullptr && right == nullptr && parent == nullptr;
}

void Node::insert_left(Node * node) {
  if (this->left == nullptr) {
    node->parent = this;
    this->left = node;
  } else {
    left->insert(node);
  }
}

void Node::insert_right(Node * node) {
  if (this->right == nullptr) {
    node->parent = this;
    this->right = node;
  } else {
    right->insert(node);
  }
}

Node * Node::search(int key) {
  if (this->key == key) return this;

  if (key < this->key) {
    if (left != nullptr) {
      return left->search(key);
    } else {
      return right->search(key);
    }
  }
  return nullptr;
}


bool Node::get_is_bst(int minimum, bool result) {
  if (this->left != nullptr) { result = this->left->get_is_bst(minimum, result); }
  if (minimum >= this->key) { return false; }
  minimum = this->key;
  if (this->right != nullptr) { result = this->right->get_is_bst(minimum, result); }
  return result;
}

bool Node::is_bst() {
  return get_is_bst(-10000, true);
}

bool Node::is_present(int key) {
  if (this->key == key) return true;

  if (this->left != nullptr && key < this->left->key) {
    return left->is_present(key);
  } else if (this->right != nullptr) {
    return right->is_present(key);
  }
  return false;
}

Node * Node::get_successor(Node * node, Node * parent, Node * successor) {
  if (parent->left != nullptr && parent->left == this) { successor = parent; }

  if (this == node) {
    if (this->right != nullptr) {
      return this->right->minimum();
    } else {
      return successor;
    }
  }

  if (node->key < this->key) {
    if (this->left != nullptr) {
      return this->left->get_successor(node, this, successor);
    }
  } else {
    if (this->right != nullptr) {
      return this->right->get_successor(node, this, successor);
    }
  }
}

Node * Node::successor(Node * node) {
  return get_successor(node, this, node);
}

Node * Node::get_predecessor(Node * node, Node * parent, Node * predecessor) {
  if (parent->right != nullptr && parent->right == this) { predecessor = parent; }

  if (this == node) {
    if (this->left != nullptr) {
      return this->left->maximum();
    } else {
      return predecessor;
    }
  }

  if (node->key < this->key) {
    if (this->left != nullptr) {
      return this->left->get_predecessor(node, this, predecessor);
    }
  } else {
    if (this->right != nullptr) {
      return this->right->get_predecessor(node, this, predecessor);
    }
  }
}

Node * Node::predecessor(Node * node) {
  return get_predecessor(node, this, node);
}

int Node::get_height(int height, int max) {
  int current = ++height;
  if (left != nullptr) { max = left->get_height(current, max); }
  if (right != nullptr) { max = right->get_height(current, max); }
  current--;
  return current > max ? current : max;
}

int Node::height(void) {
  return get_height(0, 0);
}

void Node::pre_order_traverse(std::function<void (Node *)> callback) {
  callback(this);
  if (left != nullptr) { left->pre_order_traverse(callback); }
  if (right != nullptr) { right->pre_order_traverse(callback); }
}

void Node::in_order_traverse(std::function<void (void)> callback) {
  if (left != nullptr) { left->in_order_traverse(callback); }
  callback();
  if (right != nullptr) { right->in_order_traverse(callback); }
}

void Node::post_order_traverse(std::function<void (void)> callback) {
  if (left != nullptr) { left->post_order_traverse(callback); }
  if (right != nullptr) { right->post_order_traverse(callback); }
  callback();
}

std::vector<int> Node::list_keys() {
  std::vector<int> keys;
  collect(keys);
  return keys;
}

// TODO: get rid of get_left and get_right
void Node::get_left(std::vector<int> & keys) {
  if (left == nullptr) {
    return;
  } else {
    left->collect(keys);
  }
}

void Node::get_right(std::vector<int> & keys) {
  if (right == nullptr) {
    return;
  } else {
    right->collect(keys);
  }
}

void Node::collect(std::vector<int> & keys) {
  get_left(keys);
  keys.push_back(key);
  get_right(keys);
}

void Node::preorder_collect(std::vector<int> & keys) {
  pre_order_traverse([&] (Node * node) {
    keys.push_back(node->key);
  });
}

int Node::size(void) {
  int size = 0;
  post_order_traverse([&]{ size++; });
  return size;
}

Node * Node::minimum(void) {
  if (left == nullptr) return this;
  return this->left->minimum();
}

Node * Node::maximum(void) {
  if (right == nullptr) return this;
  return this->right->maximum();
}

std::string
get_node(void) {

  return std::string("node");
}

void
Node::print_nodes(void) {
  in_order_traverse([&] {
    std::cout << "key: " << this->key << "\n";
    std::cout << "uuid: " << this->uuid << "\n";
    std::cout << "left: " << this->left << "\n";
    std::cout << "right: " << this->right << "\n";
    std::cout << "parent: " << this->parent << "\n";
  });
}

void
Node::pre_order_print_keys(void) {
  pre_order_traverse([&] (Node * node) {
    std::cout << "key: " << node->key << "\n";
  });
}

void
Node::print_to_console(void) {
  std::cout << "key: " << this->key << "\n";
  std::cout << "uuid: " << this->uuid << "\n";
  std::cout << "left: " << this->left << "\n";
  std::cout << "right: " << this->right << "\n";
  std::cout << "parent: " << this->parent << "\n";

}
