class Badge {
  String name;
  int points; // also used as id
  String image; 
  String successMessage;

  Badge({
    this.name,
    this.points,
    this.image,
    this.successMessage,
  });

  String getName() {
    return name;
  }
  String getImage() {
    return image;
  }
  String getSuccessMessage() {
    return successMessage;
  }
  int getPoints() {
    return points;
  }
}

// Must be in order
final List<Badge> badges = [
  Badge(
    name: "now-u superhero",
    image: "assets/imgs/logo.png",
    points: 10,
    successMessage: "You gained 50 points. Congratulations, now-u are a true superstar"
  ),
  Badge(
    name: "now-u novice",
    image: "assets/imgs/logo.png",
    points: 30,
    successMessage: "You gained 50 points. Congratulations, now-u are a true superstar"
  ),
  Badge(
    name: "now-u hero",
    image: "assets/imgs/logo.png",
    points: 50,
    successMessage: "You gained 50 points. Congratulations, now-u are a true superstar"
  ),
  Badge(
    name: "now-u thing",
    image: "assets/imgs/intro/il-mail@4x.png",
    points: 80,
    successMessage: "You gained 50 points. Congratulations, now-u are a true superstar"
  ),
  Badge(
    name: "now-u whatsit",
    image: "assets/imgs/logo.png",
    points: 100,
    successMessage: "You gained 50 points. Congratulations, now-u are a true superstar"
  ),
  Badge(
    name: "now-u supersuperhero",
    image: "assets/imgs/logo.png",
    points: 500,
    successMessage: "You gained 50 points. Congratulations, now-u are a true superstar"
  ),
];

int getNextBadge(int currentPoints) {
  for(int i = 0; i < badges.length; i++) {
    if (badges[i].getPoints() > currentPoints) {
      return badges[i].getPoints();
    }
  }
  return null;
}
