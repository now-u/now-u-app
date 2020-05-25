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

//Badge getLockedBadge(int points) {
//  return Badge(
//    name: "Locked",
//    image: "assets/imgs/logo.png",
//    points: points,
//    successMessage: "You need ${points} to unlock this badge"
//  );
//}

// Must be in order
final List<Badge> badges = [
  Badge(
    name: "now-u superhero",
    image: "assets/imgs/badges/achievement badges-new.png",
    points: 10,
    successMessage: "You gained 50 points. Congratulations, now-u are a true superstar"
  ),
  Badge(
    name: "now-u novice",
    image: "assets/imgs/badges/achievement badges-hero.png",
    points: 30,
    successMessage: "You gained 50 points. Congratulations, now-u are a true superstar"
  ),
  Badge(
    name: "now-u hero",
    image: "assets/imgs/badges/achievement badges-intermediate.png",
    points: 50,
    successMessage: "You gained 50 points. Congratulations, now-u are a true superstar"
  ),
  Badge(
    name: "now-u thing",
    image: "assets/imgs/badges/achievement badges-champion.png",
    points: 80,
    successMessage: "You gained 50 points. Congratulations, now-u are a true superstar"
  ),
  Badge(
    name: "now-u whatsit",
    image: "assets/imgs/badges/achievement badges-superhero.png",
    points: 100,
    successMessage: "You gained 50 points. Congratulations, now-u are a true superstar"
  ),
  Badge(
    name: "now-u supersuperhero",
    image: "assets/imgs/badges/achievement badges-pro.png",
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
