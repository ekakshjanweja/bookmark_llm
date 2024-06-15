import 'package:flutter/material.dart';

enum AnimationCard {
  test1(),
  test2(),
  test3();

  // final String bgImageName;

  // String get bgImagePath => "assets/images/$bgImageName.png";

  //  const OnboardingSection({
  //   required this.bgImageName,
  // });

  Widget child(BuildContext context) {
    switch (this) {
      case AnimationCard.test1:
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.8,
          color: Colors.blue,
          child: const Text("test1"),
        );
      case AnimationCard.test2:
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.8,
          color: Colors.red,
          child: const Text("test2"),
        );
      case AnimationCard.test3:
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.8,
          color: Colors.green,
          child: const Text("test3"),
        );
    }
  }
}
