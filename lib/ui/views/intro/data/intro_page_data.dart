class IntroPageData {
  final String title;
  final String description;
  final String? image;
  final String? backgroundImage;
  final bool showSkip;
  final bool showLogo;

  IntroPageData({
    required this.title,
    required this.description,
    this.image,
    this.backgroundImage,
    this.showSkip = true,
    this.showLogo = false,
  });
}

final List<IntroPageData> introPages = [
  IntroPageData(
    title: 'Welcome',
    description:
        'Our mission is to inform, involve and inspire everyone to help tackle some of the world’s most pressing problems.',
    backgroundImage: 'assets/imgs/intro/OnBoarding1.png',
    showSkip: false,
    showLogo: true,
  ),
  IntroPageData(
    title: 'Choose causes you care about',
    description:
        'Select and support the social and environmental issues important to you.',
    image: 'assets/imgs/intro/On-Boarding illustrations-01.png',
  ),
  IntroPageData(
    title: 'Learn and take action',
    description: 'Find ways to make a difference that suit you.',
    image: 'assets/imgs/intro/On-Boarding illustrations-02.png',
  ),
  IntroPageData(
    title: 'Help shape a better world',
    description: 'Join our growing community driving lasting change.',
    image: 'assets/imgs/intro/On-Boarding illustrations-04.png',
  ),
];
