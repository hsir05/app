import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/res/resources.dart';

/// 间隔
class Gaps {
  /// 水平间隔
  static const Widget hGap4 = const SizedBox(width: 4.0);
  static const Widget hGap5 = const SizedBox(width: Dimens.gap_dp5);
  static const Widget hGap8 = const SizedBox(width: 8.0);
  static const Widget hGap10 = const SizedBox(width: Dimens.gap_dp10);
  /// 垂直间隔
  static const Widget vGap4 = const SizedBox(height: 4.0);
  static const Widget vGap5 = const SizedBox(height: Dimens.gap_dp5);
  static const Widget vGap8 = const SizedBox(height: 8.0);

  static Widget line = const Divider();

  static Widget vLine = const SizedBox(
    width: 0.6,
    height: 24.0,
    child: const VerticalDivider(),
  );
  
  static const Widget empty = const SizedBox();
}
