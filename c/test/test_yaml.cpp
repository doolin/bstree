#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <node.h>
#include <collector.h>
#include <yaml.h>
#include "../src/node_private.h"

using std::string;

class YamlTest : public CppUnit::TestCase {

  public:
  YamlTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_dummy() {
    describe_test(INDENT0, "Dummy yaml test");
    
    Spec spec;

    spec.it("does nothing", DO_SPEC_HANDLE {
      FILE *yaml_file = fopen("../../fixtures/tree10.yml", "r");
      Node * node = load_tree(yaml_file);
      fclose(yaml_file);
      return true;
    });


  }

  void run_tests(void) {
    //setup();
    test_dummy();
    //teardown();
  }

};

void
test_yaml() {

  YamlTest * yt = new YamlTest(std::string("initial test"));
  yt->run_tests();
  delete yt;
}

int
main(int argc, char ** argv) {

  test_yaml();
  return 0;
}
