import 'package:flutter/widgets.dart';

abstract final class AppElevation {
  AppElevation._();

  static const List<BoxShadow> level0 = <BoxShadow>[];

  static const List<BoxShadow> level1 = <BoxShadow>[
    BoxShadow(color: Color(0x26000000), offset: Offset(0, 1), blurRadius: 2),
  ];

  static const List<BoxShadow> level2 = <BoxShadow>[
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 2), blurRadius: 4),
  ];

  static const List<BoxShadow> level3 = <BoxShadow>[
    BoxShadow(color: Color(0x24000000), offset: Offset(0, 4), blurRadius: 8),
  ];

  static const List<BoxShadow> level4 = <BoxShadow>[
    BoxShadow(color: Color(0x2E000000), offset: Offset(0, 10), blurRadius: 15),
  ];

  static const double glassBlurSigma = 12;
}
