class SDG {
  int? number;
  String? name;
  String? image;
  String? link;

  SDG({
    this.number,
    this.name,
    this.image,
    this.link,
  });

  int? getNumber() {
    return number;
  }

  String? getName() {
    return name;
  }

  String? getImage() {
    return image;
  }

  String? getLink() {
    return link;
  }
}

SDG? getSDGfromNumber(int? number) {
  print("getting sdg $number");
  for (int i = 0; i < sdgs.length; i++) {
    if (sdgs[i].number == number) {
      return sdgs[i];
    }
  }
  return null;
}

List<SDG> sdgs = [
  SDG(
      number: 1,
      name: "No Poverty",
      image: "assets/imgs/sdg/1.png",
      link: "https://www.un.org/sustainabledevelopment/poverty/"),
  SDG(
      number: 2,
      name: "Zero Hunger",
      image: "assets/imgs/sdg/2.png",
      link: "https://www.un.org/sustainabledevelopment/hunger/"),
  SDG(
      number: 3,
      name: "Good Health and Well-being",
      image: "assets/imgs/sdg/3.png",
      link: "https://www.un.org/sustainabledevelopment/health/"),
  SDG(
      number: 4,
      name: "Quality Education",
      image: "assets/imgs/sdg/4.png",
      link: "https://www.un.org/sustainabledevelopment/education/"),
  SDG(
      number: 5,
      name: "Gender Equality",
      image: "assets/imgs/sdg/5.png",
      link: "https://www.un.org/sustainabledevelopment/gender-equality/"),
  SDG(
      number: 6,
      name: "Clean Water and Sanitation",
      image: "assets/imgs/sdg/6.png",
      link: "https://www.un.org/sustainabledevelopment/water-and-sanitation/"),
  SDG(
      number: 7,
      name: "Affordable and Clean Energy",
      image: "assets/imgs/sdg/7.png",
      link: "https://www.un.org/sustainabledevelopment/energy/"),
  SDG(
      number: 8,
      name: "Decent Work and Economic Growth",
      image: "assets/imgs/sdg/8.png",
      link: "https://www.un.org/sustainabledevelopment/economic-growth/"),
  SDG(
      number: 9,
      name: "Industry, Innovation and Infrastructure",
      image: "assets/imgs/sdg/9.png",
      link:
          "https://www.un.org/sustainabledevelopment/infrastructure-industrialization/"),
  SDG(
      number: 10,
      name: "Reduced Inequalities",
      image: "assets/imgs/sdg/10.png",
      link: "https://www.un.org/sustainabledevelopment/inequality/"),
  SDG(
      number: 11,
      name: "Sustainable Cities and Communities",
      image: "assets/imgs/sdg/11.png",
      link: "https://www.un.org/sustainabledevelopment/cities/"),
  SDG(
      number: 12,
      name: "Responsible Consumption and Production",
      image: "assets/imgs/sdg/12.png",
      link:
          "https://www.un.org/sustainabledevelopment/sustainable-consumption-production/"),
  SDG(
      number: 13,
      name: "Climate Action",
      image: "assets/imgs/sdg/13.png",
      link: "https://www.un.org/sustainabledevelopment/climate-change/"),
  SDG(
      number: 14,
      name: "Life Below Water",
      image: "assets/imgs/sdg/14.png",
      link: "https://www.un.org/sustainabledevelopment/oceans/"),
  SDG(
      number: 15,
      name: "Life on Land",
      image: "assets/imgs/sdg/15.png",
      link: "https://www.un.org/sustainabledevelopment/biodiversity/"),
  SDG(
      number: 16,
      name: "Peace, Justice and Strong Institutions",
      image: "assets/imgs/sdg/16.png",
      link: "https://www.un.org/sustainabledevelopment/peace-justice/"),
  SDG(
      number: 17,
      name: "Partnerships for the Goals",
      image: "assets/imgs/sdg/17.png",
      link: "https://www.un.org/sustainabledevelopment/globalpartnerships/"),
];
