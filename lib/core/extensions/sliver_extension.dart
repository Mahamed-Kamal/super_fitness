import 'package:flutter/material.dart';

extension SliverExtension on Widget {
  SliverToBoxAdapter get toSliver => SliverToBoxAdapter(child: this);
}
