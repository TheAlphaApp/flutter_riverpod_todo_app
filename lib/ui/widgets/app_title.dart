import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    this.fontSize = 24,
    this.leadingTitle = '',
    this.trailingTitle = '',
    Key? key,
  }) : super(key: key);
  final double? fontSize;
  final String leadingTitle;
  final String trailingTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          leadingTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: fontSize,
              ),
        ),
        Text(
          trailingTitle == '' || leadingTitle == '' ? '' : ' ',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: fontSize,
              ),
        ),
        Text(
          trailingTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: fontSize,
              ),
        ),
      ],
    );
  }
}
