import 'package:bookmark_llm/features/carousel_animation/widgets/page_indicator_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageIndicator extends ConsumerStatefulWidget {
  const PageIndicator(
      {super.key,
      required this.currentPageIndex,
      required this.tabController,
      required this.onUpdateCurrentPageIndex});
  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends ConsumerState<PageIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        widget.tabController.length,
        (int index) {
          return index == widget.currentPageIndex
              ? const PageIndicatorPill()
              : AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                );
        },
      ),
    );
  }
}
