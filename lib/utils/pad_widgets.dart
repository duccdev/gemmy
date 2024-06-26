import 'package:flutter/material.dart';

List<Widget> padWidgets(EdgeInsets padding, List<Widget> widgets) {
  return widgets
      .asMap()
      .entries
      .map((e) => e.key == (widgets.length - 1)
          ? e.value
          : Padding(padding: padding, child: e.value))
      .toList();
}
