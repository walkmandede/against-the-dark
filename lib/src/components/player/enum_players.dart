enum EnumPlayerCharacter {
  maskDude(
    name: "Mask Dude",
    imagePath: "Mask Dude",
    thumbnail: "assets/images/Main Characters/Mask Dude/Fall (32x32).png",
  ),
  ninjaFrog(
    name: "Ninja Frog",
    imagePath: "Ninja Frog",
    thumbnail: "assets/images/Main Characters/Ninja Frog/Fall (32x32).png",
  ),
  pinkMan(
    name: "Pink Man",
    imagePath: "Pink Man",
    thumbnail: "assets/images/Main Characters/Pink Man/Fall (32x32).png",
  ),
  virtualGuy(
    name: "Virtual Guy",
    imagePath: "Virtual Guy",
    thumbnail: "assets/images/Main Characters/Virtual Guy/Fall (32x32).png",
  ),
  ;

  final String name;
  final String imagePath;
  final String thumbnail;
  const EnumPlayerCharacter({
    required this.name,
    required this.imagePath,
    required this.thumbnail,
  });
}
