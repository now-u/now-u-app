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
