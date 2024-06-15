import 'package:bookmark_llm/features/carousel_animation/providers/carousel_animation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageIndicatorPill extends ConsumerStatefulWidget {
  const PageIndicatorPill({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PageIndicatorPillState();
}

class _PageIndicatorPillState extends ConsumerState<PageIndicatorPill>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 3400),
      )..addListener(
          () {
            setState(() {});
            if (animationController!.isCompleted) {
              ref.read(carouselAnimationRepoProvider).nextPage();
            }
          },
        );
      animationController!.forward();
    });
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 48,
      height: 6,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(6),
      ),
      child: LinearProgressIndicator(
        color: Colors.red,
        value: animationController!.value,
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
