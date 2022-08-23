import 'dart:developer';

class Test {
  int counter = 0;

  Test({required int counter, required int counter2}) {
    this.counter = counter;
  }

  Test.other(int counter) {
    this.counter = counter;
  }
}

mixin Action {
  void sayHi() {
    log("hi");
  }
}

void main() {
  Test t = Test(counter2: 2, counter: 10);

  Test t2 = Test.other(10);
}
