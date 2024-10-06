import 'package:duapa/models/onboarding_class.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;

  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  List<OnboardingItem> onboardingPages = [
    const OnboardingItem(
      image: 'assets/img/artboard_1.png',
      title: 'Buy Farm Products',
      text:
          'Order Seeds, Crop Nutrition, Crop Protection, Fertilizers, Hardwares, Animal needs etc from the app and get it delivered to your doorstep.',
    ),
    const OnboardingItem(
      image: 'assets/img/artboard_2.png',
      title: 'Agri Expert Advice',
      text:
          'Upload pictures and get real time solutions from Agric Experts for any crop issues. Our Experts will answer all your Questions, also give suppoort for Profit Farming and other Agri services.',
    ),
    const OnboardingItem(
      image: 'assets/img/artboard_3.png',
      title: 'Sell Your Produce',
      text:
          'Buy & Sell your Crops to anyone from anywhere in the world with Duapa. Hassle free transactions between Buyers and Sellers',
    ),
    const OnboardingItem(
      image: 'assets/img/artboard_4.png',
      title: 'Watch Posts & Videos',
      text:
          'Watch Crop related customised Posts, Videos, News, Subsidy, Articles from our experts as per your needs which Increase your Profit & Knowledge of farming.',
    ),
  ];
}
