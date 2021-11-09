#ifndef IS_NODE_H
#define IS_NODE_H

#include<functional>
#include<vector>

class Node {

  private:
    int get_height(int current, int max);
    bool get_is_bst(int minimum, bool result);
    Node * get_successor(Node * node, Node * parent, Node * successor);
    Node * get_predecessor(Node * node, Node * parent, Node * successor);

    // get rid of these two methods
    void get_left(std::vector<int> & keys);
    void get_right(std::vector<int> & keys);

  public:
    Node(int _key) : key(_key), uuid("fixme"), left(nullptr), right(nullptr), parent(nullptr) {}

    // void pre_order_traverse(std::function<void (const Node&)> callback);
    void in_order_traverse(std::function<void (void)> callback);
    void post_order_traverse(std::function<void (void)> callback);

    void insert(Node * node);
    void insert_left(Node * node);
    void insert_right(Node * node);

    bool is_present(int);

    Node * search(int key);
    Node * successor(Node * n);
    Node * predecessor(Node * n);
    Node * maximum(void);
    Node * minimum(void);
    void unlink(void); // could also be unlink
    bool is_unlinked(void);
    std::vector<int> list_keys(void);
    void collect(std::vector<int> & keys);
    bool is_bst(void);
    int size(void);
    int height(void);
    void print_to_console(void);

    int key;
    std::string uuid;
    Node * left;
    Node * right;
    Node * parent;
};

#endif /* IS_NODE_H */
