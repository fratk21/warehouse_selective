import 'package:flutter/material.dart';
import 'package:warehouse_selective/screens/onboarding/screen_one.dart';
import 'package:warehouse_selective/screens/onboarding/screen_three.dart';
import 'package:warehouse_selective/screens/onboarding/screen_two.dart';

class onboarding_pageview extends StatefulWidget {
  const onboarding_pageview({super.key});

  @override
  State<onboarding_pageview> createState() => _onboarding_pageviewState();
}

class _onboarding_pageviewState extends State<onboarding_pageview> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        OnboardingScreenOne(),
        OnboardingScreenTwo(),
        OnboardingScreenThree(),
      ],
    );
  }
}
