import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/settings.dart';

class SettingsServices{
  final CollectionReference _settingsCollection = FirebaseFirestore.instance.collection('settings');

  Future<List<SettingsData>> getSettings() async {
    var snapshot = await _settingsCollection.get();
    return snapshot.docs.map((e) => SettingsData.fromMap(e.data()as Map<String,dynamic>)).toList();
  }

  Future<void> addSettings(SettingsData settings) async {
    await _settingsCollection.add(settings.toMap());
  }

  Future<void> updateSettings(SettingsData settings) async {
    await _settingsCollection.doc(settings.id).update(settings.toMap());
  }

  String getSettingsId() {
    return _settingsCollection.doc().id;
  }

  Stream<List<SettingsData>> settingsStream() {
    return _settingsCollection.snapshots().map((event) => event.docs.map((e) => SettingsData.fromMap(e.data() as Map<String,dynamic>)).toList());
  }
}