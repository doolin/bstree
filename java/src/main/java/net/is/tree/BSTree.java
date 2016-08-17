package net.is.tree;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import static java.util.Arrays.asList;

class BSTree {
    public Node root;

    public List<Integer> collect() {
        ArrayList<Integer> actual = new ArrayList<Integer>();
        this.root.collect(actual);
        return actual;
    }

    public int size() {
        if (root == null) {
          return 0;
        } else {
          return 0;
          //return root.size();
        }
    }

    public void insert(Node n) {
        if (root == null) {
            root = n;
        } else {
            root.insert(n);
        }
    }

    public BSTree(Node r) {
        root = r;
    }

    public BSTree() {
        root = null;
    }

    public static void main(String [] args) {
        System.out.println("From BSTree main...");
    };
};
