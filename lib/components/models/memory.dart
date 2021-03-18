class Memory {
  static const operations = const ['%', '/', 'x', '-', '+', '='];
  final _buffer = [0.0, 0.0];
  var _bufferIndex = 0;
  String _operation;
  String _value = '0';
  bool _wiperValue = false;
  String _lastCommand;

  void applyCommand(String command) {
    if(_isReplacingOperation(command)){
      _operation =command;
      return;
    }
    if (command == 'AC') {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }
    _lastCommand = command;
  }
   _isReplacingOperation(String command){
    return operations.contains(_lastCommand)
        && operations.contains(command)
        && _lastCommand != '='
        && command != '=';

   }

  _addDigit(String digit) {
    final isDot = digit == '.';
    final emptyValue = isDot ? '0' : '';
    final wipeValue = (_value == '0' && !isDot) || _wiperValue;

    if (isDot && _value.contains('.') && !wipeValue) {
      return;
    }

    final currentValue = wipeValue ? emptyValue : _value;
    _value = currentValue + digit;
    _wiperValue = false;

    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
  }

  _setOperation(newOperation) {
    bool isEqualsing = newOperation == '=';
    if (_bufferIndex == 0) {
     if(!isEqualsing){
       _operation = newOperation;
       _bufferIndex = 1;
       _wiperValue = true;
     }
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;
      bool isEqualsing = newOperation == '=';
      _operation = isEqualsing ? null : newOperation;
      _bufferIndex = isEqualsing ? 0 : 1;
    }
    _wiperValue = true;//!isEqualsing;
  }

  _allClear() {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _bufferIndex = 0;
    _operation = null;
    _wiperValue = false;
  }

  _calculate() {
    switch (_operation) {
      case '%':
        return _buffer[0] % _buffer[1];
      case '/':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];

      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      default:
        return _buffer[0];
    }
  }

  String get value {
    return _value;
  }
}
