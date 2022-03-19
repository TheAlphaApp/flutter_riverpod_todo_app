import 'package:flutter/material.dart';
import 'package:flutter_riverpod_todo_app/ui/widgets/app_title.dart';

class AppTitleWithTransition extends AppBarTitle {
  const AppTitleWithTransition(this.titleAnimController,
      {final double? fontSize = 24, Key? key})
      : super(key: key, fontSize: fontSize);
  final AnimationController titleAnimController;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: titleAnimController,
      child: AppBarTitle(
        fontSize: fontSize,
        trailingTitle: 'Todopad',
      ),
    );
  }
}
