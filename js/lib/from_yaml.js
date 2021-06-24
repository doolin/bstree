const fs = require("fs");
const yaml = require("js-yaml");

// TODO: read up on shadowing for why this cannot be
// name `node` in the context of using it below.
const Node = require("./node.js").Node;

const fromYaml = (filename) => {
  const fileContents = fs.readFileSync(`../fixtures/${filename}`, "utf8");
  const data = yaml.load(fileContents);

  const createTree = function (data) {
    if (data === null) {
      return null;
    }

    const node = new Node(data.key);
    node.left = createTree(data.left);
    node.right = createTree(data.right);
    return node;
  };

  return createTree(data);
};

module.exports = fromYaml;
