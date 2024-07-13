import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timetable_data/features/department/data/department_model.dart';

class AuthServices {
  static final FirebaseFirestore firebase = FirebaseFirestore.instance;

  static Future<(String, DepartmentModel?)> findDepartment(
      {required String id, required String password}) async {
    try {
      var data = await firebase
          .collection('departments')
          .where('id', isEqualTo: id.toUpperCase())
          .get();
      if (data.docs.isNotEmpty) {
        var list = data.docs.map((e) => DepartmentModel.fromMap(e.data())).toList();
        var getDataWithPassword = list.where((element) => element.password == password).toList();
        if(getDataWithPassword.isNotEmpty){
          return Future.value(
            ('Login Successful', getDataWithPassword[0]));
        }else{
          return Future.value(('Invalid Password', null));
        
        }
      }
      return Future.value(('No Departed Found with ID and Password', null));
    } catch (error) {
      return Future.value((error.toString(), null));
    }
  }
}
