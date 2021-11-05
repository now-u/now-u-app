class Badge {
  String? name;
  int? points; // also used as id
  String? image;
  String? successMessage;

  Badge({
    this.name,
    this.points,
    this.image,
    this.successMessage,
  });

  String? getName() {
    return name;
  }

  String? getImage() {
    return image;
  }

  String? getSuccessMessage() {
    return successMessage;
  }

  int? getPoints() {
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
      name: "now-u pioneer",
      image: "assets/imgs/badges/achievement badges-01.png",
      points: 50,
      successMessage:
          "Congratulations! You've completed your first actions and joined the now-u community! It's time to change together!"),
  Badge(
      name: "now-u apprentice",
      image: "assets/imgs/badges/achievement badges-02.png",
      points: 100,
      successMessage:
          "Nice work! You took the next step with now-u and are making a real difference. Lets do this!"),
  Badge(
      name: "now-u high-flyer",
      image: "assets/imgs/badges/achievement badges-03.png",
      points: 200,
      successMessage:
          "Good stuff! You're finding your groove and gaining momentum!  Keep going!"),
  Badge(
      name: "now-u star",
      image: "assets/imgs/badges/achievement badges-04.png",
      points: 350,
      successMessage:
          "Awesome work! Feels good to do good, right? Stay positive!"),
  Badge(
      name: "now-u superstar",
      image: "assets/imgs/badges/achievement badges-05.png",
      points: 500,
      successMessage:
          "Well done! The time is now - simple steps, real progress! Don't stop!"),
  Badge(
      name: "now-u champion",
      image: "assets/imgs/badges/achievement badges-06.png",
      points: 750,
      successMessage:
          "Great job! Your efforts are paying off together we can do this!"),
  Badge(
      name: "now-u hero",
      image: "assets/imgs/badges/achievement badges-07.png",
      points: 1000,
      successMessage:
          "Amazing work! You are really playing your part as an active global citizen!"),
  Badge(
      name: "now-u superhero",
      image: "assets/imgs/badges/achievement badges-08.png",
      points: 1250,
      successMessage:
          "Another win! Progress is made with each action you take! Keep it up!"),
  Badge(
      name: "now-u top dog",
      image: "assets/imgs/badges/achievement badges-09.png",
      points: 1500,
      successMessage:
          "Look at us go! Each small win will culminate into bigger victories down the line! "),
  Badge(
      name: "now-u leader",
      image: "assets/imgs/badges/achievement badges-10.png",
      points: 2000,
      successMessage:
          "Really impressive! Just look back at the progress you have made! Keep it up!"),
  Badge(
      name: "now-u expert",
      image: "assets/imgs/badges/achievement badges-11.png",
      points: 2500,
      successMessage:
          "Nicely done! Persistence and perseverance really does pay off!"),
  Badge(
      name: "now-u master",
      image: "assets/imgs/badges/achievement badges-12.png",
      points: 3000,
      successMessage:
          "Incredible! You stepped up to the role and have played a huge part in driving positive change! Bravo!"),
];

int? getNextBadge(int currentPoints) {
  for (int i = 0; i < badges.length; i++) {
    if (badges[i].getPoints()! > currentPoints) {
      return badges[i].getPoints();
    }
  }
  return null;
}

Badge? getNextBadgeFromInt(int points) {
  for (int i = 0; i < badges.length; i++) {
    if (badges[i].getPoints()! >= points) {
      return badges[i];
    }
  }
  return null;
}
