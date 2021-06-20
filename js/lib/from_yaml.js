const fs = require('fs');
const yaml = require('js-yaml');

// TODO: read up on shadowing for why this cannot be
// name `node` in the context of using it below.
const node1 = require('./node.js').Node;

const from_yaml = (filename) => {
  const fileContents = fs.readFileSync(`../fixtures/${filename}`, 'utf8');
  const data = yaml.load(fileContents);

  const create_tree = function(data) {
    if (data === null) {
      return null;
    }

    const node = new node1(data.key);
    node.left = create_tree(data.left);
    node.right = create_tree(data.right);
    return node;
  };

  return create_tree(data);
};

module.exports = from_yaml;
