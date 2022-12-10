class Stack<T> {
  final List<T> _list = <T>[];

  Stack();

  void push(T value) => _list.add(value);

  T pop() => _list.removeLast();

  T get peek => _list.last;

  factory Stack.from(List<T> elements) {
    Stack<T> stack = Stack();
    for (var element in elements) {
      stack.push(element);
    }

    return stack;
  }
}
