class Character {
  String name;
  String img;
  int id;

  Character({
    required this.name,
    required this.img,
    required this.id,
  });

  Character.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        img = json['image'],
        id = json['id'];
}
