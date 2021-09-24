import 'package:cloud_firestore/cloud_firestore.dart';

class MyPlace {
  final String? category;
  final String? name;
  final String? from;
  final double latitude;
  final double longitude;
  final String description;
  final String? imageUrl;
  final String? website;

  MyPlace(
      {this.category,
      this.name,
      this.from,
      required this.latitude,
      required this.longitude,
      required this.description,
      this.imageUrl,
      this.website});

  MyPlace.fromJson(Map<String, Object?> json)
      : this(
          category: json['category'] as String?,
          name: json['name'] as String?,
          from: json['from'] as String?,
          latitude: json['latitude'] as double,
          longitude: json['longitude']! as double,
          imageUrl: json['imageUrl']! as String?,
          description: json['description']! as String,
          website: json['website'] as String?,
        );

  Map<String, Object?> toJson() {
    return {
      'category': category,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'from': from,
      'description': description,
      'imageUrl': imageUrl,
      'website': website,
    };
  }
}

final placeRef = FirebaseFirestore.instance
    .collection('dream_places')
    .withConverter<MyPlace>(
      fromFirestore: (snapshot, _) => MyPlace.fromJson(snapshot.data()!),
      toFirestore: (movie, _) => movie.toJson(),
    );
