import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeTageState();
}

class _HomeTageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
