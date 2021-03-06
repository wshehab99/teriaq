import 'package:find_doctor/bloc/api_cubit.dart';
import 'package:find_doctor/bloc/app_cubit.dart';
import 'package:find_doctor/bloc/app_states.dart';
import 'package:find_doctor/screens/nursing_task/ceners_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class SelectCenterScreen extends StatelessWidget {
  const SelectCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApiCubit(InitialAppState()),
      child: BlocConsumer<ApiCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ApiCubit cubit = ApiCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Select Center'),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: DatePicker(
                          DateTime.now(),
                          initialSelectedDate: DateTime.now(),
                          onDateChange: (date) {
                            cubit.changeDate(date);
                          },
                        ),
                      ),
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return CenterList(
                            centerName: "centerName",
                            centerAddress: "centerAddress");
                      },
                      itemCount: 5),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
