#ifndef IS_BST_YAML_H
#define IS_BST_YAML_H

#ifdef __cplusplus
extern "C" {
#endif

#include "node.h"

// TODO: return Tree
Node * load_tree(FILE * yaml_file);

#ifdef __cplusplus
}
#endif

#endif // IS_BST_YAML_H
