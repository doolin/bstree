#include <stdio.h>
#include <yaml.h>

#include "node.h"
#include "collector.h"
#include "node_private.h"

// This link provides a demonstration for what I want to do:
// https://github.com/meffie/libyaml-examples/blob/master/parse.c
// I forked it to Inventium just in case:
// https://github.com/Inventium/libyaml-examples
//
// libcyaml source: https://github.com/tlsa/libcyaml/
// Documentation for libcyaml: https://libyaml.docsforge.com/
// Tutorial: https://www.wpsoftware.net/andrew/pages/libyaml.html

typedef enum _yaml_state_t {
  SEEN_NOTHING,
  SEEN_YAML_KEY,
  SEEN_VALUE,
  SEEN_MAPPING,
  SEEN_NODE_KEY,
  SEEN_NODE_UUID,
  SEEN_NODE_LEFT,
  SEEN_NODE_RIGHT
} yaml_state_t;

typedef struct _node_state_t {
  yaml_state_t yaml_state;
  Node * root_node;
  Node * current_node;
  enum context {
    NONE,
    LEFT,
    RIGHT
  } context;
} node_state_t;

// TODO: move all context and state into node state struct
// TODO: Alias "puts" to a macro or something which switches on DEBUG
// TODO: Refactor all this to a function.
// https://stackoverflow.com/questions/20628099/parsing-yaml-to-values-with-libyaml-in-c

void
consume_event(yaml_event_t * event, node_state_t * node_state) {
  Node * node = NULL;  
  unsigned char * tk;
  char yaml_key[100];

  tk = event->data.scalar.value;

  switch (event->type) {
  case YAML_NO_EVENT:
    // puts("YAML_NO_EVENT");
    break;
  case YAML_STREAM_START_EVENT:
    // puts("STREAM START");
    break;
  case YAML_STREAM_END_EVENT:
    // puts("STREAM END");
    break;
  /* Block delimeters */
  case YAML_DOCUMENT_START_EVENT:
    // puts("YAML_DOCUMENT_START_EVENT");
    break;
  case YAML_DOCUMENT_END_EVENT:
    // puts("YAML_DOCUMENT_END_EVENT");
    break;
  case YAML_SEQUENCE_START_EVENT:
    // puts("YAML_SEQUENCE_START_EVENT");
    break;
  case YAML_SEQUENCE_END_EVENT:
    // puts("YAML_SEQUENCE_END_EVENT");
    break;
  case YAML_MAPPING_START_EVENT:
    // puts("YAML_MAPPING_START_EVENT");
    node_state->yaml_state = SEEN_MAPPING;
    break;
  case YAML_MAPPING_END_EVENT:
    // puts("YAML_MAPPING_END_EVENT");
    // Need to "pop the stack" here, set the current node *
    // to its parent.
    // At the end of all processing, the current node should
    // once again point to the same node as the root node.
    node_state->current_node = node_state->current_node->parent;
    break;

  /* Data */
  case YAML_ALIAS_EVENT:
    // puts("YAML_ALIAS_EVENT");
    break;
  case YAML_SCALAR_EVENT:
    // puts("YAML_SCALAR_EVENT");

    if (node_state->yaml_state == SEEN_MAPPING || node_state->yaml_state == SEEN_VALUE) {
      strcpy(yaml_key, (const char *)tk);

      if (!strcmp((const char *)yaml_key, "key")) {
        node_state->yaml_state = SEEN_NODE_KEY;

      } else if (!strcmp((const char *)yaml_key, "uuid")) {
        node_state->yaml_state = SEEN_NODE_UUID;

      } else if (!strcmp((const char *)yaml_key, "left")) {
        node_state->yaml_state = SEEN_NODE_LEFT;
        node_state->context = LEFT;

      } else if (!strcmp((const char *)yaml_key, "right")) {
        node_state->yaml_state = SEEN_NODE_RIGHT;
        node_state->context = RIGHT;
      }

      break;
    } else if (node_state->yaml_state == SEEN_NODE_KEY) {
      node = node_new(atoi((const char *)tk));
      if (node_state->root_node == NULL) {
        node_state->root_node = node;
        node_state->current_node = node;
      } else {
        if (node_state->context == LEFT) {
          node->parent = node_state->current_node;
          node_state->current_node->left = node;
          node_state->current_node = node;
        } else if (node_state->context == RIGHT) {
          node->parent = node_state->current_node;
          node_state->current_node->right = node;
          node_state->current_node = node;
        }
      }
      node_state->context = NONE;
      node_state->yaml_state = SEEN_VALUE;

    } else if (node_state->yaml_state == SEEN_NODE_UUID) {
      strcpy(node_state->current_node->uuid, (const char *)tk);
      node_state->yaml_state = SEEN_VALUE;

    } else if (node_state->yaml_state == SEEN_NODE_LEFT) {
      node_state->yaml_state = SEEN_VALUE;

    } else if (node_state->yaml_state == SEEN_NODE_RIGHT) {
      node_state->yaml_state = SEEN_VALUE;

    } else {
      break;
    }
  }
}

Node *
parsing_loop(yaml_parser_t * parser, yaml_event_t * event, node_state_t * node_state) {

  do {
    if (!yaml_parser_parse(parser, event)) {
      printf("Parser error %d\n", parser->error);
      exit(EXIT_FAILURE);
    }

    consume_event(event, node_state);

    if (event->type != YAML_STREAM_END_EVENT) {
      yaml_event_delete(event);
    }
  } while (event->type != YAML_STREAM_END_EVENT);

  return node_state->root_node;
}

Node * load_tree(FILE * yaml_file) {
  Node * root_node = NULL;

  yaml_parser_t parser;
  yaml_event_t event;
  node_state_t node_state;
  memset(&node_state, 0, sizeof(node_state));
  node_state.yaml_state = SEEN_NOTHING;

  if (!yaml_parser_initialize(&parser)) {
    fputs("Failed to initialize parser!\n", stderr);
  }

  if (yaml_file == NULL) {
    fputs("Failed to open file!\n", stderr);
  }

  yaml_parser_set_input_file(&parser, yaml_file);
  root_node = parsing_loop(&parser, &event, &node_state);

  yaml_event_delete(&event);
  yaml_parser_delete(&parser);
  return root_node;
}

#ifdef STANDALONE
Node * display_yaml(void) {
  FILE *yaml_file = fopen("../../fixtures/tree10.yml", "r");
  Node * node = load_tree(yaml_file);
  fclose(yaml_file);
  return node;
}

int main(void) {
  Node * node = display_yaml();
  Collector * collector = collector_new(100);
  node_collect(node, collector);
  collector_printf(collector);
  collector_destroy(collector);
  return 0;
}
#endif // STANDALONE
