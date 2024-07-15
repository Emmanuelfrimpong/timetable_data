import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/utils/colors.dart';
import 'package:timetable_data/utils/styles.dart';

class AllocationsPage extends ConsumerStatefulWidget {
  const AllocationsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllocationsPageState();
}

class _AllocationsPageState extends ConsumerState<AllocationsPage> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var titleStyles = styles.title(
        color: Colors.white,
        fontFamily: 'Raleway',
        desktop: 15,
        mobile: 13,
        tablet: 14);
    var rowStyles = styles.body(desktop: 16, mobile: 14, tablet: 15);
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Allocation List'.toUpperCase(),
                style: styles.title(
                    desktop: 34, mobile: 20, tablet: 24, color: primaryColor),
              ),
              const SizedBox(height: 20),
            ]));
  }
}
