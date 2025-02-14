
//Home model
class Homemodel {
    int id;
    String title;
    String description;
    String image;

    Homemodel({
        required this.id,
        required this.title,
        required this.description,
        required this.image,
    });

    factory Homemodel.fromJson(Map<String, dynamic> json) => Homemodel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
    };
}
