import 'package:find_doctor/bloc/api_cubit.dart';
import 'package:find_doctor/bloc/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../shared/constant.dart';

import '../../shared/searchBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doctor_list_widget..dart';

// ignore: must_be_immutable
class DoctorListScreen extends StatelessWidget {
  DoctorListScreen({Key? key, this.dignoseName, this.videocall})
      : super(key: key);
  bool? videocall;
  String? dignoseName;
  List shownList = [];
  String value1 = " ";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApiCubit(InitialAppState()),
      child: BlocConsumer<ApiCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ApiCubit cubit = ApiCubit.get(context);

          cubit.getDoctor();
          shownList = cubit.searchAboutDoctor(dignoseName!, value1, videocall);
          return Scaffold(
            backgroundColor: kBackgroundColor,
            body: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset('assets/icons/menu.svg'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Find Your Desired\n$dignoseName Doctor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: kTitleTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: SearchBar(
                        hint: "Search for doctors",
                        onSearch: (value) {
                          value1 = value!;
                          shownList = cubit.searchAboutDoctor(
                              dignoseName!, value, videocall);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    (state is LoadingState)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child: DoctorListWidget(
                                videoCall: videocall,
                                dignoseName: dignoseName!,
                                shownList: shownList),
                          ),
                  ],
                )),
          );
        },
      ),
    );
  }
}
