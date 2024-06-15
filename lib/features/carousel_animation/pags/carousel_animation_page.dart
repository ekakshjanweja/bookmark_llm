import 'package:bookmark_llm/features/carousel_animation/enums/animation_card.dart';
import 'package:bookmark_llm/features/carousel_animation/providers/carousel_animation_provider.dart';
import 'package:bookmark_llm/features/carousel_animation/widgets/page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarouselAnimationPage extends ConsumerStatefulWidget {
  static const routeName = "/carousel-animation";
  const CarouselAnimationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CarouselAnimationPageState();
}

class _CarouselAnimationPageState extends ConsumerState<CarouselAnimationPage>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: AnimationCard.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            CarouselSlider.builder(
              carouselController:
                  ref.watch(carouselAnimationRepoProvider).carouselController,
              itemCount: AnimationCard.values.length,
              itemBuilder: (context, index, realIndex) =>
                  AnimationCard.values[index].child(context),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.8,
                viewportFraction: 0.85,
                initialPage: 0,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) => ref
                    .watch(carouselAnimationRepoProvider)
                    .setCurrentSection(AnimationCard.values[index]),
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            PageIndicator(
              tabController: _tabController!,
              currentPageIndex:
                  ref.watch(carouselAnimationRepoProvider).currentSection.index,
              onUpdateCurrentPageIndex: (index) => ref
                  .watch(carouselAnimationRepoProvider)
                  .setCurrentSection(AnimationCard.values[index]),
            ),
          ],
        ),
      ),
    );
  }
}
