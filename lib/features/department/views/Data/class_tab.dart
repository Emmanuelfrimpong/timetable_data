import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/core/widget/custom_button.dart';
import 'package:timetable_data/core/widget/custom_drop_down.dart';
import 'package:timetable_data/core/widget/custom_input.dart';
import 'package:timetable_data/utils/styles.dart';

class ClassTab extends ConsumerStatefulWidget {
  const ClassTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClassTabState();
}

class _ClassTabState extends ConsumerState<ClassTab> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     var styles = Styles(context);
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Card(
            color: Colors.white,
            child: Container(
              width: 400,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'New Class',
                        style: styles.body(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            desktop: 30),
                      ),
                      const Divider(
                        thickness: 4,
                        color: primaryColor,
                        height: 15,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFields(
                        hintText: 'Class Name (e.g. ITE 300B)',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter class name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomDropDown(
                          hintText: 'Select Department',
                          items: [],
                          onChanged: (value) {}),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 500,
                        child: CustomTextFields(
                          hintText: 'Search for class',
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                      const Spacer(),
                      CustomButton(
                          radius: 10,
                          color: secondaryColor,
                          text: 'Add Class',
                          onPressed: () {},
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 4,
                  color: primaryColor,
                  height: 15,
                ),
                Expanded(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('Class $index'),
                            subtitle: Text('Class $index'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          );
                        },
                        itemCount: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
