import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ScrollController useControllerForAnimation(
        AnimationController backwardAnimController,
        AnimationController forwardAnimController) =>
    use(_ScrollControllerForAnimationHook(
        backwardAnimController: backwardAnimController,
        forwardAnimController: forwardAnimController));

class _ScrollControllerForAnimationHook extends Hook<ScrollController> {
  final AnimationController backwardAnimController;
  final AnimationController forwardAnimController;
  const _ScrollControllerForAnimationHook({
    required this.backwardAnimController,
    required this.forwardAnimController,
  });
  @override
  _ScrollControllerForAnimationHookState createState() =>
      _ScrollControllerForAnimationHookState();
}

class _ScrollControllerForAnimationHookState
    extends HookState<ScrollController, _ScrollControllerForAnimationHook> {
  late ScrollController _scrollController;
  @override
  void initHook() {
    _scrollController = ScrollController();

    _scrollController.addListener(
      () {
        if (_scrollController.position.atEdge &&
            _scrollController.position.pixels == 0) {
          hook.backwardAnimController.forward();
          hook.forwardAnimController.reverse();
        } else if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          hook.backwardAnimController.reverse();
          hook.forwardAnimController.forward();
        }
      },
    );
  }

  @override
  ScrollController build(BuildContext context) => _scrollController;

  @override
  void dispose() {
    _scrollController.dispose();
  }
}
