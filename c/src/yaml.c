#include <stdio.h>
#include <yaml.h>

#include "node.h"

typedef enum _yaml_state_t {
  SEEN_NOTHING,
  SEEN_KEY,
  SEEN_VALUE,
  SEEN_MAPPING
} yaml_state_t;

typedef enum _node_state_t {
  LEFT_CHILD,
  RIGHT_CHILD
} node_state_t;

#define empty(value) ((value[0] == '\0'))

// TODO: Refactor all this to a function.
// https://stackoverflow.com/questions/20628099/parsing-yaml-to-values-with-libyaml-in-c
Node *
parse_value(unsigned char * value, unsigned char * attr, Node * node) {

  if (&value == NULL) {
    printf("Got scalar (value %s)\n", "NULL");
  } else if (empty(value)) {
    puts("got \\0");
  } else {
    printf("Got scalar (value %lu)\n", strlen(value));
  }

  if (!strcmp((const char *)attr, "key")) {
    node = node_new(atoi(value));
    printf("Node.key: %d\n", node_key(node));
  } else if (!strcmp((const char *)attr, "uuid")) {
    ; //return SEEN_VALUE;
  } else if (!strcmp((const char *)attr, "left")) {
    puts("left key");
    // if (!empty(value)) {
    //   make a new left node, and return it.
    // }
  } else if (!strcmp((const char *)attr, "right")) {
    puts("right key");
  }
  return node;
}

void parse(FILE * yaml_file) {
  Node * node;

  yaml_parser_t parser;
  yaml_event_t event;
  unsigned char * tk;
  char key[100];

  // char ** datap;
  int state = SEEN_NOTHING;

  if (!yaml_parser_initialize(&parser))
    fputs("Failed to initialize parser!\n", stderr);
  if (yaml_file == NULL)
    fputs("Failed to open file!\n", stderr);

  yaml_parser_set_input_file(&parser, yaml_file);

  do {
    if (!yaml_parser_parse(&parser, &event)) {
      printf("Parser error %d\n", parser.error);
      exit(EXIT_FAILURE);
    }

    tk = event.data.scalar.value;

    switch (event.type) {
    case YAML_NO_EVENT:
      puts("No event!");
      break;
    case YAML_STREAM_START_EVENT:
      puts("STREAM START");
      break;
    case YAML_STREAM_END_EVENT:
      puts("STREAM END");
      break;
    /* Block delimeters */
    case YAML_DOCUMENT_START_EVENT:
      puts("<b>Start Document</b>");
      break;
    case YAML_DOCUMENT_END_EVENT:
      puts("<b>End Document</b>");
      break;
    case YAML_SEQUENCE_START_EVENT:
      puts("<b>Start Sequence</b>");
      break;
    case YAML_SEQUENCE_END_EVENT:
      puts("<b>End Sequence</b>");
      break;
    case YAML_MAPPING_START_EVENT:
      state = SEEN_MAPPING;
      puts("<b>Start Mapping</b>");
      break;
    case YAML_MAPPING_END_EVENT:
      puts("<b>End Mapping</b>");
      break;
    /* Data */
    case YAML_ALIAS_EVENT:
      printf("Got alias (anchor %s)\n", event.data.alias.anchor);
      break;
    case YAML_SCALAR_EVENT:
      // We'll see a key first,
      if (state == SEEN_MAPPING || state == SEEN_VALUE) {
        strcpy(key, (const char *)tk);
        state = SEEN_KEY;
        printf("yaml key: %s\n", key);
        break;
      } else if (state == SEEN_KEY) {
        // The return needs to set the node pointer or something.
        node = parse_value(tk, (unsigned char *)key, node);
        state = SEEN_VALUE;
        break;
      } else {
        break;
      }
    }
    if (event.type != YAML_STREAM_END_EVENT)
      yaml_event_delete(&event);
  } while (event.type != YAML_STREAM_END_EVENT);

  yaml_event_delete(&event);
  yaml_parser_delete(&parser);
}

void display_yaml(void) {
  FILE *yaml_file = fopen("../../fixtures/tree1.yml", "r");
  parse(yaml_file);
  fclose(yaml_file);
}

int main(void) {
  display_yaml();
  return 0;
}
