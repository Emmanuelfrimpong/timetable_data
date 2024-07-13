import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/core/widget/custom_button.dart';
import 'package:timetable_data/core/widget/custom_dialog.dart';
import 'package:timetable_data/core/widget/custom_input.dart';
import 'package:timetable_data/features/department/data/models/program_data_model.dart';
import 'package:timetable_data/features/department/provider/programs_provider.dart';
import 'package:timetable_data/features/login/provider/login_provider.dart';
import 'package:timetable_data/utils/styles.dart';

class ProgramsTab extends ConsumerStatefulWidget {
  const ProgramsTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProgramsTabState();
}

class _ProgramsTabState extends ConsumerState<ProgramsTab> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
     var styles = Styles(context);
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      
    );
  }

  Widget _buildRowItem(ProgramsDataModel program) {
     var styles = Styles(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 1),
              bottom: BorderSide(color: Colors.grey.shade300, width: 1))),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: Text(
              program.id ?? 'Program Id'.toUpperCase(),
              style: program.id == null
                  ? styles.title(
                      desktop: 22,
                      color: primaryColor,
                      fontWeight: FontWeight.bold)
                  : styles.title (fontWeight: FontWeight.bold, desktop: 18),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 2,
            child: Text(
              program.name!,
              style: styles.body(
                  fontWeight:
                      program.id == null ? FontWeight.bold : FontWeight.w500,
                  color: program.id == null ? primaryColor : null,
                  desktop: program.id == null ? 22 : 18),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              program.department!,
              style: program.id == null
                  ? styles.body(
                      desktop: 22,
                      color: primaryColor,
                      fontWeight: FontWeight.bold)
                  : styles.body(
                      desktop: 18,
                      fontWeight: FontWeight.w500,
                    ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),

          //edit button and delete button
          program.id == null
              ? Text(
                  'Action',
                  style: styles.body(
                      desktop: 22,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                )
              : IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    //delete program
                  })
        ],
      ),
    );
  }

  Widget _buildListSection() {
    var programStream = ref.watch(programsStreamProvider);
    var styles = Styles(context);
    return SizedBox(
      child: Card(
        child: programStream.when(data: (data) {
          var programs = ref.watch(programsProvider);
          if (programs[0].id != null) {
            programs.insert(
                0,
                ProgramsDataModel(
                  createdAt: 0,
                  department: 'Department',
                  departmentId: '000',
                  name: 'Program Name',
                ));
          }
          return Row(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ListView.builder(
                    itemCount: programs.length,
                    itemBuilder: (context, index) {
                      var program = programs[index];
                      return _buildRowItem(program);
                    }),
              ),
            ],
          );
        }, error: (error, stack) {
          return const Center(
            child: Text('Error Loading Data'),
          );
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }

  Widget _buildInputSection() {
    var styles = Styles(context);
    var notifier = ref.read(programsProvider.notifier);
    var department = ref.watch(userProvider);
    return Card(
      color: Colors.white,
      child: Container(
        color: Colors.white,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                'New Program',
                style: styles.title(
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
                height: 30,
              ),
              CustomTextFields(
                hintText: 'Enter Programs Name',
                controller: _controller,
                onSaved: (value) {},
              ),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                text: 'Add Program',
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                color: secondaryColor,
                onPressed: () {
                  if (_controller.text.isEmpty) {
                    CustomDialog.showToast(message: 'Enter Programs Name');
                    return;
                  }
                  if (_controller.text.length < 5) {
                    CustomDialog.showToast(
                        message:
                            'Enter a valid Program name (more than 5 characters)');
                    return;
                  }
                  if (department == null) {
                    CustomDialog.showToast(message: 'You are logged Out');
                    return;
                  }
                  notifier.addProgram(
                      ref: ref,
                      program: _controller.text,
                      department: department);
                  _controller.clear();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
