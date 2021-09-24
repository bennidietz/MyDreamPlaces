import 'package:cloud_firestore/cloud_firestore.dart';

class CheckboxValue {
  final String? id;
  final String? journey_id;
  final String text;
  final bool done;

  CheckboxValue({
    this.id,
    this.journey_id,
    required this.text,
    required this.done
  });


  CheckboxValue.fromJson(Map<String, Object?> json, String id)
      : this(
    id: id,
    journey_id: json['journey_id']! as String,
    text: json['text']! as String,
    done: json['done']! as bool,
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'journey_id': journey_id,
      'text': text,
      'done': done,
    };
  }
}

final luggageRef = FirebaseFirestore.instance.collection('travel_luggage').withConverter<CheckboxValue>(
  fromFirestore: (snapshot, _) => CheckboxValue.fromJson(
      snapshot.data()!, snapshot.id
  ),
  toFirestore: (movie, _) => movie.toJson(),
);

final ideasRef = FirebaseFirestore.instance.collection('travel_ideas').withConverter<CheckboxValue>(
  fromFirestore: (snapshot, _) => CheckboxValue.fromJson(
      snapshot.data()!, snapshot.id
  ),
  toFirestore: (movie, _) => movie.toJson(),
);

List<CheckboxValue> IDEAS_VALUES = [
  CheckboxValue(text: "Abends schwimmen gehen", done: false),
  CheckboxValue(text: "Tanzen", done: false),
];