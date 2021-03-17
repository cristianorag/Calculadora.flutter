class Memory {
  static const operations = const ['%', '/', '*', '-', '+', '='];
  final _buffer = [0.0, 0.0];
  var _bufferIndex = 0;
  String _operation;
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

    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
  }

  _setOperation(newOperation) {
    if(_bufferIndex == 0){
      _operation = newOperation;
      _bufferIndex = 1;
    }else{
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
    }
    _wiperValue = true;
  }

  _allClear() {
    _value = '0';
  }

  _calculate(){
    switch(_operation){
      case '%' : return _buffer[0] % _buffer[1];
      case '/' : return _buffer[0] / _buffer[1];
      case 'x' : return _buffer[0] * _buffer[1];
      case '-' : return _buffer[0] - _buffer[1];
      case '+' : return _buffer[0] + _buffer[1];
      default: return _buffer[0];
    }
  }

  String get value {
    return _value;
  }
}
