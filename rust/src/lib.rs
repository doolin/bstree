// from https://github.com/fade2black/BSearchTree

use std::rc::Rc;
use std::cell::RefCell;

/* From the outside in:
 * Option: From the docs, https://doc.rust-lang.org/std/option/
 * Type Option represents an optional value: every Option is either Some
 * and contains a value, or None, and does not. Option types are very
 * common in Rust code, as they have a number of uses:
 * 
 * - Initial values
 * - Return values for functions that are not defined over their entire input range (partial functions)
 * - Return value for otherwise reporting simple errors, where None is returned on error
 * - Optional struct fields
 * - Struct fields that can be loaned or "taken"
 * - Optional function arguments
 * - Nullable pointers
 * - Swapping things out of difficult situations
 * 
 * Rc: From the docs, https://doc.rust-lang.org/std/rc/struct.Rc.html
 * Single-threaded reference-counting pointers. 'Rc' stands for 'Reference Counted'.
 * The type Rc<T> provides shared ownership of a value of type T, allocated in the heap.
 *
 * Invoking clone on Rc produces a new pointer to the same allocation in the heap.
 * When the last Rc pointer to a given allocation is destroyed, the value stored in
 * that allocation (often referred to as "inner value") is also dropped.
 *
 * Shared references in Rust disallow mutation by default, and Rc is no exception:
 * you cannot generally obtain a mutable reference to something inside an Rc. If
 * you need mutability, put a Cell or RefCell inside the Rc.
 *
 * A cycle between Rc pointers will never be deallocated. For this reason, Weak is
 * used to break cycles. For example, a tree could have strong Rc pointers from parent
 * nodes to children, and Weak pointers from children back to their parents.
 *
 * RefCell: From the docs, https://doc.rust-lang.org/std/cell/struct.RefCell.html,
 * https://doc.rust-lang.org/std/cell/struct.Ref.html,
 * https://doc.rust-lang.org/std/cell/index.html
 *
 * A RefCell is a mutable memory location with dynamically checked borrow rules.
 * Rust memory safety is based on this rule: Given an object T, it is only possible to have one of the following:
 *
 * # Having several immutable references (&T) to the object (also known as aliasing).
 * # Having one mutable reference (&mut T) to the object (also known as mutability).
 *
 * This is enforced by the Rust compiler. However, there are situations where this
 * rule is not flexible enough. Sometimes it is required to have multiple references
 * to an object and yet mutate it.
 *
 * Shareable mutable containers exist to permit mutability in a controlled manner,
 * even in the presence of aliasing. Both Cell<T> and RefCell<T> allow doing this
 * in a single-threaded way.
 */
pub type NodeOption = Option<Rc<RefCell<Node>>>;

#[derive(PartialEq, Debug)]
pub struct Node {
  pub key: u32,
  pub left: NodeOption,
  pub right: NodeOption
}

impl Node {
  pub fn new(key: u32) -> Self {
    Node {
      key,
      left: None,
      right: None
    }
  }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_new_node() {
      let node = Node::new(5);
      assert_eq!(node, Node{key: 5, left: None, right: None });
    }

    #[test]
    fn attach_node() {
      let mut rootnode = Node::new(5);
      assert!(rootnode.key == 5);
      assert_eq!(rootnode.right, None);

      assert_eq!(rootnode, Node{key: 5, left: None, right: None});

      let leftnode = Node::new(13);
      // cargo test -- --nocapture
      //println!("leftnode: {:?}", leftnode);

      rootnode.left = Some(Rc::new(RefCell::new(leftnode)));
      //let rlptr = rootnode.left.unwrap();
      assert_eq!(rootnode.left.unwrap().borrow().key, 13);
      //println!("left: {:?}", rlptr.borrow().key)
    }
}
