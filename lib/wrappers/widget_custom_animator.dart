import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class WidgetCustomAnimator extends StatelessWidget {
  final Widget childWidget;
  final WidgetTransitionEffects? incomingEffect;
  final WidgetTransitionEffects? outGoingEffect;
  final WidgetRestingEffects? atRestEffect;

  const WidgetCustomAnimator(
      {super.key,
      required this.childWidget,
      this.incomingEffect,
      this.outGoingEffect,
      this.atRestEffect,
      });

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      incomingEffect: incomingEffect,
      outgoingEffect: outGoingEffect,
      atRestEffect: atRestEffect,
      child: childWidget,
    );
  }
}
