const fs = require("fs");
const yaml = require("js-yaml");

// TODO: read up on shadowing for why this cannot be
// name `node` in the context of using it below.
const Node = require("./node.js").Node;
const Tree = require("./tree.js").Tree;

const fromYaml = (filename) => {
  const fileContents = fs.readFileSync(`../fixtures/${filename}`, "utf8");
  const data = yaml.load(fileContents);

  const traverseNodes = function (data) {
    if (data === null) {
      return null;
    }

    const node = new Node(data.key);
    node.left = traverseNodes(data.left);
    node.right = traverseNodes(data.right);
    return node;
  };

  nodes = traverseNodes(data);
  tree = new Tree();
  tree.root = nodes;
  return tree;
};

module.exports = fromYaml;
