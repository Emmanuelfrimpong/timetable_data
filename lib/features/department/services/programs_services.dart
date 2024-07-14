import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetable_data/features/department/data/models/program_data_model.dart';

class ProgramsServices {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

 static Future<bool> addProgram(ProgramsDataModel program) async {
    try {
      await firestore
          .collection('programs')
          .doc(program.id)
          .set(program.toMap());
      return true;
    } catch (error) {
      return false;
    }
  }

 static Future<bool> updateProgram(ProgramsDataModel program) async {
    try {
      await firestore
          .collection('programs')
          .doc(program.id)
          .update(program.toMap());
      return true;
    } catch (error) {
      return false;
    }
  }

 static Future<bool> deleteProgram(String id) async {
    try {
      await firestore.collection('programs').doc(id).delete();
      return true;
    } catch (error) {
      return false;
    }
  }

 static Stream<List<ProgramsDataModel>> getPrograms({required String dep}) {
    return firestore.collection('programs').where('departmentId',isEqualTo: dep).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProgramsDataModel.fromMap(doc.data()))
          .toList();
    });
  }

  
}
