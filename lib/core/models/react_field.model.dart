import 'package:rxdart/rxdart.dart';

import '../abstractions/field.interface.dart';

class ReactFieldModel<T> extends IField<T> {
  T? _value;
  final _error = BehaviorSubject<String?>();

  var firstTimeAux = true;
  final bool validateOnType;

  ReactFieldModel({
    T? value,
    required super.validators,
    required super.controller,
    this.validateOnType = true,
  }) : _value = value {
    controller.addListener(() => onChange(controller.text));
  }

  @override
  T? get value => _value;

  @override
  set value(T? val) {
    onChange(val?.toString());
  }

  @override
  Stream<String?> get errorStream => _error.stream;

  @override
  bool get hasError => _error.value != null;

  @override
  void clearError() => _error.sink.add(null);

  @override
  void setError(String error) => _error.sink.add(error);

  @override
  void onChange(String? val) {
    if (val != null) {
      if ((runtimeType == ReactFieldModel<double>) ||
          runtimeType == ReactFieldModel<int>) {
        dynamic parse;
        final onlyNumber = val.replaceAll(RegExp('[^0-9.]'), '');
        parse = num.tryParse(onlyNumber);
        _value = parse;
        firstTimeAux = false;
      } else if (runtimeType == ReactFieldModel<String>) {
        _value = val as T;
        if (val == '') {
          controller.text = val;
        } else {
          firstTimeAux = false;
        }
      }
    }

    if (!firstTimeAux && validateOnType) validate();
    onChangeCallback?.call(_value);
  }

  @override
  bool validate() {
    _error.sink.add(super.validateValue(value));
    return _error.value == null;
  }

  @override
  void dispose() {
    _error.close();
    controller.dispose();
  }
}
