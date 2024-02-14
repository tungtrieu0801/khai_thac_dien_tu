

import 'package:flutter/material.dart';

class Sizeresponsive {
  Size getScreenSize() {
    return MediaQueryData.fromView(WidgetsBinding.instance!.window).size;
  }
}
