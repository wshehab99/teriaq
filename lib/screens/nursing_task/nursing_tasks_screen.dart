import 'package:find_doctor/bloc/app_states.dart';
import 'package:find_doctor/screens/nurse_map/nurse_map.dart';
import 'package:find_doctor/screens/search/search_widget.dart';
import 'package:find_doctor/shared/app_button.dart';
import 'package:flutter/material.dart';

import '../../bloc/api_cubit.dart';
import '../../shared/custom_appbar.dart';
import 'nursing_task_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NursingTasksScreen extends StatelessWidget {
  const NursingTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => ApiCubit(InitialAppState())),
      child: BlocConsumer<ApiCubit, AppStates>(
          listener: ((context, state) {}),
          builder: (context, state) {
            ApiCubit cubit = ApiCubit.get(context);
            return Scaffold(
              appBar: CustomAppbar(context, titleText: "Nursing Tasks"),
              body: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SearchTextFeild(
                    hint: 'Search',
                    onSearch: (value) {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemBuilder: ((context, index) {
                          return NursingTaskCard(
                            title: ApiCubit.nursingTsks[index]['title'],
                            description: ApiCubit.nursingTsks[index]
                                ['description'],
                            index: index,
                            onChange: () {
                              cubit.changeNurseListBouttonValue();
                            },
                          );
                        }),
                        itemCount: ApiCubit.nursingTsks.length),
                  )
                ],
              ),
              bottomNavigationBar: AppButton(
                text: 'Continue',
                borderradius: BorderRadius.circular(35),
                bottenColor: Colors.green.withOpacity(0.7),
                textColor: Colors.white,
                onPressed: cubit.nursingListContinue
                    ? () async {
                        cubit.nursingListContinue = false;

                        await cubit.getLocation(value: null);

                        var location = ApiCubit.initialPosition;
                        var nurses = await cubit.getNearestNurses(
                            location!.latitude, location.longitude);
                        var locationData = await cubit.geCurrentLocation();
                        nurses?.forEach((element) {
                          print("==================================${element}");
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NurseMap(
                                      nurses: nurses!,
                                      locationData: locationData!,
                                    )));
                      }
                    : null,
              ),
            );
          }),
    );
  }
}
