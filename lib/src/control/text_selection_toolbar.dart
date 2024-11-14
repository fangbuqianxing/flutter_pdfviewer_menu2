import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextSelectionToolbar extends StatelessWidget {
  const MyTextSelectionToolbar(
      {super.key,
      required this.primaryAnchor,
      required this.onCopy,
      required this.onQuote});

  final Offset primaryAnchor;
  final VoidCallback onCopy;
  final VoidCallback onQuote;

  @override
  Widget build(BuildContext context) {
    final List<Widget> resultChildren =
        AdaptiveTextSelectionToolbar.getAdaptiveButtons(context, [
      ContextMenuButtonItem(
        onPressed: onCopy,
        type: ContextMenuButtonType.copy,
      ),
      ContextMenuButtonItem(
        onPressed: onQuote,
        label: 'Quote',
      ),
    ]).toList();

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
        return CupertinoTextSelectionToolbar(
          anchorAbove: primaryAnchor,
          anchorBelow: primaryAnchor,
          children: resultChildren,
        );
      case TargetPlatform.android:
        return TextSelectionToolbar(
          anchorAbove: primaryAnchor,
          anchorBelow: primaryAnchor,
          children: resultChildren,
        );
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return DesktopTextSelectionToolbar(
          anchor: primaryAnchor,
          children: resultChildren,
        );
      case TargetPlatform.macOS:
        return CupertinoDesktopTextSelectionToolbar(
          anchor: primaryAnchor,
          children: resultChildren,
        );
    }
  }
}
