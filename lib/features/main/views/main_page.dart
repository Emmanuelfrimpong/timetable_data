import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/features/settings/provider/settings_provider.dart';
import '../../../core/widget/components/nav_bar.dart';

class MainPage extends ConsumerWidget {
  const MainPage({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settingsStreamProvider = ref.watch(settingsStream);
    return SafeArea(
        child: Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100), child: NavBar()),
      body: FutureBuilder(
          future: saveDummyData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            //return child;
            return settingsStreamProvider.when(data: (data) {
              return child;
            }, error: (error, stack) {
              return Center(child: Text('Error: $error'));
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            });
          }),
    ));
  }

  Future<bool> saveDummyData() async {
    // var settings = [
    //   SettingsData(
    //   id: SettingsServices().getSettingsId(),
    //   year: '2023/2024',
    //   semester: '1st Semester',
    //   isCurrent: false,
    // ),
    // SettingsData(
    //   id: SettingsServices().getSettingsId(),
    //   year: '2023/2024',
    //   semester: '2nd Semester',
    //   isCurrent: true,
    // ),
    // SettingsData(
    //   id: SettingsServices().getSettingsId(),
    //   year: '2022/2023',
    //   semester: '1st Semester',
    //   isCurrent: false,
    // ),
    // SettingsData(
    //   id: SettingsServices().getSettingsId(),
    //   year: '2022/2023',
    //   semester: '2nd Semester',
    //   isCurrent: false,
    // ),
    // ];
    // for (var setting in settings) {
    //   await SettingsServices().addSettings(setting);
    // }
     return Future.value(true);

  }
}
