#ifndef IS_BST_TREE_H
#define IS_BST_TREE_H

#ifdef __cplusplus
extern "C" {
#endif

#include <node.h>

typedef struct _tree Tree;

Tree * tree_new          (void);

Tree * tree_from_yaml    (const char * filename);

void   tree_delete       (Tree * t);

Node * tree_delete_node  (Tree * t,
                          int key);

void   tree_insert       (Tree * t,
                          Node * n);

int    tree_is_empty     (Tree * t);

void   tree_collect      (Tree * t,
                          void * c);

void   tree_inorder_iter (Tree * t,
                          void * c);

Node * tree_search       (Tree * t,
                          int key);

void   tree_unlink       (Tree * t);

void   tree_transplant   (Tree * t,
                          Node * u,
                          Node * v);

int    tree_is_present   (Tree * t,
                          int key);

int    tree_height       (Tree * t);

void   tree_destroy      (void);

Node * tree_successor    (Tree * t,
                          Node * n);

Node * tree_predecessor  (Tree * t,
                          Node * n);

Node * tree_maximum      (Tree * t);

Node * tree_minimum      (Tree * t);

void   tree_is_full      (void);

int    tree_is_bst       (Tree * t);

int    tree_size         (Tree * t);

#ifdef __cplusplus
}
#endif

#endif /* IS_BST_TREE_H */
