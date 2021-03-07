const fs = require('fs');
const yaml = require('js-yaml');

// TODO: read up on shadowing for why this cannot be
// name `node` in the context of using it below.
var node1 = require('./node.js').Node;

let from_yaml = (filename) => {
  let fileContents = fs.readFileSync(`../fixtures/${filename}`, 'utf8');
  let data = yaml.safeLoad(fileContents);

  const create_tree = function(data) {
    if (data === null) {
      return null;
    }

    let node = new node1(data.key);
    node.left = create_tree(data.left);
    node.right = create_tree(data.right);
    return node;
  };

  return create_tree(data);
}

module.exports = from_yaml;
