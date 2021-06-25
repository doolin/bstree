#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <collector.h>

using std::string;

void
setup(void) {
}

void
teardown(void) {
}


class CollectorTest : public CppUnit::TestCase {

public:
  CollectorTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_collector_equals(void) {
    describe_test(INDENT0, "From test_collector_equals in CollectorTest");

    Spec spec;
    Collector * c1 = collector_new(1);
    Collector * c2 = collector_new(1);
    Collector * c3 = collector_new(2);

    spec.it("empty collections with same size are equal", DO_SPEC_HANDLE {
      return(collector_equals(c1, c2) == 1);
    });

    spec.it("collection with single value is not equal to empty collection", DO_SPEC_HANDLE {
      collector_add(c1, 1);
      return(collector_equals(c1, c2) == 0);
    });

    spec.it("collections with same single value each are equal", DO_SPEC_HANDLE {
      collector_add(c2, 1);
      return(collector_equals(c1, c2) == 1);
    });

    spec.it("differently sized collections are not equal", DO_SPEC_HANDLE {
      collector_add(c3, 1);
      return(collector_equals(c1, c3) == 0);
    });

    collector_destroy(c1);
    collector_destroy(c2);
    collector_destroy(c3);

    Collector * c4 = collector_new(5);
    Collector * c5 = collector_new(5);

    spec.it("larger collections of same size with same values are equal", DO_SPEC_HANDLE {
      collector_add(c4, 1);
      collector_add(c4, 2);
      collector_add(c4, 3);
      collector_add(c4, 4);
      collector_add(c4, 5);

      collector_add(c5, 1);
      collector_add(c5, 2);
      collector_add(c5, 3);
      collector_add(c5, 4);
      collector_add(c5, 5);
      return(collector_equals(c4, c5) == 1);
    });

    collector_destroy(c4);
    collector_destroy(c5);
  }

  void test_collector_empty(void) {
    Collector * c = collector_new(5);
    Spec spec;

    spec.it("ask collector if it is empty", DO_SPEC_HANDLE {
      return collector_empty(c);
    });
  }

  void test_collector_add_int_array(void) {
    Collector * c4 = collector_new(5);
    int values[5] = {1, 2, 3, 4, 5};
    collector_add_int_array(c4, values);

    // TODO: write the spec!
  }

  void run_tests(void) {
    setup();
    teardown();
    test_collector_add_int_array();
    test_collector_equals();
    test_collector_empty();
  }
};

void
test_collector() {

  CollectorTest * ct = new CollectorTest(std::string("initial test"));
  ct->run_tests();
  delete ct;
}

int
main(int argc, char ** argv) {

  test_collector();
  return 0;
}
