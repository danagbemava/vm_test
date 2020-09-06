import 'package:flutter/foundation.dart';
import 'package:vm_test/mixins/logger_mixin.dart';

abstract class BaseChangeNotifier<T> extends ChangeNotifier
    with LoggerMixin<T> {
  void setState([VoidCallback cb]) {
    if (cb != null) {
      cb();
    }

    notifyListeners();
  }
}
