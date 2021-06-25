#ifndef IS_BST_NODE_PRIVATE_H
#define IS_BST_NODE_PRIVATE_H

#include "../include/node.h"

struct _node {
  int key;
  char uuid[100];
  Node * left;
  Node * right;
  Node * parent;
};



#endif /* IS_BST_NODE_PRIVATE_H */
