import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/styles.dart';

class NewAllocation extends ConsumerStatefulWidget {
  const NewAllocation({super.key});

  @override
  ConsumerState<NewAllocation> createState() => _NewAllocationState();
}

class _NewAllocationState extends ConsumerState<NewAllocation> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    return Container();
  }
}