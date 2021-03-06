#ifndef IS_BST_NODE_H
#define IS_BST_NODE_H

#ifdef __cplusplus
extern "C" {
#endif


typedef struct _node Node;

Node * node_new         (int key);

void   node_delete      (Node * n);

void   node_destroy     (Node * n);

void   node_strip       (Node * n);

int    node_key         (Node * n);

void   node_insert      (Node * root,
                         Node * next);

Node * node_left        (Node * n);

Node * node_right       (Node * n);

void   node_collect     (Node * n,
                         void * collector);

Node * node_search      (Node * n,
                         int key);

int    node_is_present  (Node * n,
                         int key);

int    node_height      (Node * n);

Node * node_successor   (Node * root,
                         Node * node);

Node * node_predecessor (Node * root,
                         Node * node);

Node * node_maximum     (Node * n);

Node * node_minimum     (Node * n);

void   node_unlink      (Node * n);

int    node_is_unlinked (Node * n);

void   node_list_keys   (Node * root,
                         void * collector);

void   node_is_full     (void);

int    node_is_bst      (Node * n);

int    node_size        (Node * n);

#ifdef __cplusplus
}
#endif

#endif /* IS_BST_NODE_H */
