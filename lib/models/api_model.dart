// To parse this JSON data, do
//
//     final giveaway = giveawayFromJson(jsonString);

import 'dart:convert';

List<Giveaway> welcomeFromJson(String str) => List<Giveaway>.from(json.decode(str).map((x) => Giveaway.fromJson(x)));

String welcomeToJson(List<Giveaway> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Giveaway {
    Giveaway({
        this.id,
        this.title,
        this.worth,
        this.thumbnail,
        this.image,
        this.description,
        this.instructions,
        this.openGiveawayUrl,
        this.publishedDate,
        this.type,
        this.platforms,
        this.endDate,
        this.users,
        this.status,
        this.gamerpowerUrl,
        this.openGiveaway,
    });

    int? id;
    String? title;
    String? worth;
    String? thumbnail;
    String? image;
    String? description;
    String? instructions;
    String? openGiveawayUrl;
    String? publishedDate;
    String? type;
    String? platforms;
    String? endDate;
    int? users;
    String? status;
    String? gamerpowerUrl;
    String? openGiveaway;

    factory Giveaway.fromJson(Map<String, dynamic> json) => Giveaway(
        id: json["id"],
        title: json["title"],
        worth: json["worth"],
        thumbnail: json["thumbnail"],
        image: json["image"],
        description: json["description"],
        instructions: json["instructions"],
        openGiveawayUrl: json["open_giveaway_url"],
        publishedDate: json["published_date"],
        type: json["type"],
        platforms: json["platforms"],
        endDate: json["end_date"],
        users: json["users"],
        status: json["status"],
        gamerpowerUrl: json["gamerpower_url"],
        openGiveaway: json["open_giveaway"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "worth": worth,
        "thumbnail": thumbnail,
        "image": image,
        "description": description,
        "instructions": instructions,
        "open_giveaway_url": openGiveawayUrl,
        "published_date": publishedDate,
        "type": type,
        "platforms": platforms,
        "end_date": endDate,
        "users": users,
        "status": status,
        "gamerpower_url": gamerpowerUrl,
        "open_giveaway": openGiveaway,
    };
}
