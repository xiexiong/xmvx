import 'package:flutter/material.dart';

class OptionGridView extends StatelessWidget {
  final int itemCount;
  final double spacing;
  final int crossAxisCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const OptionGridView({
    super.key,
    required this.itemCount,
    this.spacing = 8.0,
    this.crossAxisCount = 3,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        final itemWidth = (width - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(
            itemCount,
            (i) => SizedBox(width: itemWidth, child: itemBuilder(ctx, i)),
          ),
        );
      },
    );
  }
}
