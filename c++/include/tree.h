#ifndef IS_TREE_H
#define IS_TREE_H

#include <string>
#include <vector>
#include <memory>
#include <yaml-cpp/yaml.h>
#include "./node.h"

class Tree {
public:
  Tree() : root(nullptr) {}
  Tree(Node * _root) : root(_root) {}
  // Tree(std::unique_ptr<Node> _root) : root(_root) {}

  void transplant(Node * u, Node * v);
  void insert(Node * node);
  void collect(std::vector<int> & keys);
  std::vector<int> list_keys(void);
  std::vector<int> iterative_inorder_traverse(void);

  Tree * from_yaml(std::string filename);
  // TODO: try to find a way to cast such that the yaml.h need
  // not be included in this header file.
  void yaml_preorder_traverse(YAML::Node config, std::function<void (YAML::Node)> callback);

  Node * delete_node(int key);
  Node * search(int);
  Node * successor(Node * n);
  Node * predecessor(Node * n);
  Node * maximum(void);
  Node * minimum(void);

  bool is_bst(void);
  bool is_empty(void);
  int size(void);
  int height(void);

  bool is_present(int key);

  Node * root;
  //std::vector<int> keys;

private:
  Node * search_node(int key, Node * node);

  /*
  void collect_keys(Node * node);
  void get_left(Node * node);
  void get_right(Node * node);
  */

  bool found;
};

#endif /* IS_TREE_H */
