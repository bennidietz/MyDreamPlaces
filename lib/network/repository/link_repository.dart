import 'package:cloud_firestore/cloud_firestore.dart';

abstract class LinkRepository {

  Future add({
    String? url,
    String? description
  });

}

class LinkReposityImpl implements LinkRepository {

  static final LINK_TABLE_NAME = "";

  @override
  Future add({String? url, String? description}) async {
    final travel_link_table = FirebaseFirestore.instance.collection(LINK_TABLE_NAME);
    return travel_link_table.add({
      'url': url,
      'description': description,
    });
  }
  //
  // @override
  // Future<QuerySnapshot<Map<String, dynamic>>> getAll() async {
  //   return FirebaseFirestore.instance
  //         .collection(LINK_TABLE_NAME)
  //         .get();
  // }

}