class Memory {
  static const operations = const ['%', '/', '*', '-', '+', '='];
  final _buffer = [0.0, 0.0];
  final _bufferIndex = 0;
  String operation;
  String _value = '0';
  bool _wiperValue = false;

  void applyCommand(String command) {
    if (command == 'AC') {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }
  }

  _addDigit(String digit) {
    final isDot = digit == '.';
    final emptyValue = isDot ? '0': '';
    final wipeValue = (_value == '0' && !isDot)|| _wiperValue;

    if (isDot && _value.contains('.') && !wipeValue) {
      return;
    }

    final currentValue = wipeValue ? emptyValue  : _value;
    _value = currentValue + digit;
    _wiperValue = false;
  }

  _setOperation(newOperation) {
    _wiperValue = true;
  }

  _allClear() {
    _value = '0';
  }

  String get value {
    return _value;
  }
}
