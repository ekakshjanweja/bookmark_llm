import 'package:bookmark_llm/features/carousel_animation/enums/animation_card.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final carouselAnimationRepoProvider =
    Provider<CarouselAnimationRepo>((ref) => CarouselAnimationRepo());

class CarouselAnimationRepo {
  final CarouselController _carouselController = CarouselController();
  CarouselController get carouselController => _carouselController;

  AnimationCard _currentSection = AnimationCard.test1;
  AnimationCard get currentSection => _currentSection;

  void nextPage() {
    _carouselController.nextPage();
  }

  void setCurrentSection(AnimationCard section) {
    _currentSection = section;
  }
}
