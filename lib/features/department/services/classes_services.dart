import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetable_data/features/department/data/models/class_data_model.dart';

class ClassesServices{
  
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _collection = _firestore.collection('classes');


  static String get id => _collection.doc().id;

  static Future<bool> addClass(Map<String, dynamic> data) async {
    try {
      await _collection.doc(id).set(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateClass(String id, Map<String, dynamic> data) async {
    try {
      await _collection.doc(id).update(data);
      return true;
    } catch (e) {
      return false;
    }
  }


  static Future<bool> deleteClass(String id) async {
    try {
      await _collection.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Stream<List<ClassModel>> getClasses(String department) {
    return _collection.where(
      'department',
      isEqualTo: department,
    ).snapshots().map((snapshot) => snapshot.docs
        .map((doc) => ClassModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }
}