import 'package:food/core/constants/app_icons.dart';
import 'onboarding_model.dart';

class OnboardingData {
  static List<OnboardingModel> items = [
    OnboardingModel(
      imageUrl: AppIcons.onboarding1,
      headline: 'Fast Delivery, Fresh Meals',
      description: 'Enjoy hot and delicious meals delivered to your doorstep in no time.',
    ),
    OnboardingModel(
      imageUrl: AppIcons.onboarding2,
      headline: 'Your Favorite Restaurants, One Click Away',
      description: 'Discover and order from the best local eateries with a simple tap.',
    ),
    OnboardingModel(
      imageUrl: AppIcons.onboarding3,
      headline: 'Order Anytime, Anywhere',
      description: 'Craving something special? Were here for you 24/7, wherever you are.',
    ),
  ];
}
