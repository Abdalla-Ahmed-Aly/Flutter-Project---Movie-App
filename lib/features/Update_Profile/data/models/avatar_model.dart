class Avatar {
  final String imagePath;
  final String id;

  Avatar({
    required this.imagePath,
    required this.id,
  });
  static final List<Avatar> avatarPaths = [
    Avatar(imagePath: 'assets/Avatar/gamer1.png', id: '1'),
    Avatar(imagePath: 'assets/Avatar/gamer2.png', id: '2'),
    Avatar(imagePath: 'assets/Avatar/gamer3.png', id: '3'),
    Avatar(imagePath: 'assets/Avatar/gamer4.png', id: '4'),
    Avatar(imagePath: 'assets/Avatar/gamer5.png', id: '5'),
    Avatar(imagePath: 'assets/Avatar/gamer6.png', id: '6'),
    Avatar(imagePath: 'assets/Avatar/gamer7.png', id: '7'),
    Avatar(imagePath: 'assets/Avatar/gamer8.png', id: '8'),
    Avatar(imagePath: 'assets/Avatar/gamer9.png', id: '9'),
  ];
}
