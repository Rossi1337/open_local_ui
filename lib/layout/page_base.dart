import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

class PageBaseLayout extends StatelessWidget {
  final Widget body;

  const PageBaseLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AdaptiveTheme.of(context).mode.isDark
            ? Colors.black12
            : Colors.white,
      ),
      padding: const EdgeInsets.all(32.0),
      child: body,
    );
  }
}
