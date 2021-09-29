#include <stdio.h>
#include <yaml.h>

#include "node.h"

Node * load_tree(FILE * yaml_file) {
  Node * root_node = NULL;

  return root_node;
}

#ifdef STANDALONE
Node * display_yaml(void) {
  FILE *yaml_file = fopen("../../fixtures/tree10.yml", "r");
  Node * node = load_tree(yaml_file);
  fclose(yaml_file);
  return node;
}

int main(void) {
  Node * node = display_yaml();
  // printf("node root location: %p\n", node);
  // printf("node key: %d\n", node->key);
  // printf("node left location: %p\n", node->left);
  // printf("node right location: %p\n", node->right);
  // printf("node left key: %d\n", node->left->key);
  // printf("node right key: %d\n", node->right->key);
  // Collector * collector = collector_new(100);
  // node_collect(node, collector);
  // collector_printf(collector);
  // collector_destroy(collector);
  return 0;
}
#endif // STANDALONE
