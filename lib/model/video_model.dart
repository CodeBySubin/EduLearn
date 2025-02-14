
//Video model

class Videomodel {
    int id;
    String title;
    String description;
    VideoType videoType;
    String videoUrl;

    Videomodel({
        required this.id,
        required this.title,
        required this.description,
        required this.videoType,
        required this.videoUrl,
    });

    factory Videomodel.fromJson(Map<String, dynamic> json) => Videomodel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        videoType: videoTypeValues.map[json["video_type"]]!,
        videoUrl: json["video_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "video_type": videoTypeValues.reverse[videoType],
        "video_url": videoUrl,
    };
}

enum VideoType {
    VIMEO,
    YOU_TUBE
}

final videoTypeValues = EnumValues({
    "Vimeo": VideoType.VIMEO,
    "YouTube": VideoType.YOU_TUBE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
