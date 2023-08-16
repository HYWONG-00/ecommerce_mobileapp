import '../import.dart';

//firebase - getall in collections
Future<List<Map<String, dynamic>>> loadFirebaseDataCollection(String collectionName) async {
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection(collectionName).get();

  final List<Map<String, dynamic>> dataList = querySnapshot.docs
      .map((doc) => doc.data() as Map<String, dynamic>)
      .toList();

  return dataList;
}