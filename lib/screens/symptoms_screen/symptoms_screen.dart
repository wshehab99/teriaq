import 'package:find_doctor/bloc/app_cubit.dart';
import 'package:find_doctor/bloc/app_states.dart';
import 'package:find_doctor/screens/search/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SymptomsScreen extends StatelessWidget {
  SymptomsScreen({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  Map response = {};
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(InitialAppState()),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: ((context, state) {}),
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            cubit.loadingSymptom();
            return Scaffold(
                backgroundColor: (state is DoneState || state is ErrorState)
                    ? Colors.grey
                    : Colors.white,
                appBar: AppBar(
                  title: const Text("Medical Diagnosis"),
                  centerTitle: true,
                ),
                body: state is LoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is ErrorState
                        ? AlertDialog(
                            title: const Text('Error !'),
                            content: const Text(
                                "Something went wrong, please try again later"),
                            actions: [
                              ElevatedButton(
                                  onPressed: cubit.backToNormalState,
                                  child: const Text("back")),
                            ],
                          )
                        : state is DoneState
                            ? AlertDialog(
                                clipBehavior: Clip.hardEdge,
                                title: const Text('Diagnos'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "You may have a/an ${response.keys}!",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        "this is not alternative of doctor visit plese try to visit a ${response.values} doctor")
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: cubit.backToNormalState,
                                      child: const Text("back"))
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      'Add Your Sympotoms',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xff1171C8),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Add as many symptoms as you can for the most accurate results',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SearchTextFeild(
                                    searchTextFeildColor: Colors.grey[300],
                                    controller: controller,
                                    hint: "Search, e.g. headache",
                                    onSearch: (value) {
                                      cubit.searchOnSymptoms(value: value);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  cubit.veiwedSymptoms.isEmpty
                                      ? Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Wrap(
                                              alignment: WrapAlignment.start,
                                              children: List.generate(
                                                  cubit.selectedSymptoms.length,
                                                  (index) {
                                                return Container(
                                                  margin:
                                                      const EdgeInsets.all(2.0),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 4.0),
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF1171C8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0)),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        cubit.selectedSymptoms[
                                                            index],
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xff0D5496),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0)),
                                                        child: InkWell(
                                                            onTap: () {
                                                              cubit
                                                                  .deleteSymptom(
                                                                      index);
                                                            },
                                                            child: const Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          flex: 4,
                                          child: ListView.builder(
                                            keyboardDismissBehavior:
                                                ScrollViewKeyboardDismissBehavior
                                                    .onDrag,
                                            itemCount:
                                                cubit.veiwedSymptoms.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  cubit.selectSymptoms(index);
                                                  controller.clear();
                                                  cubit.searchOnSymptoms(
                                                      value: controller.text);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              226,
                                                              226,
                                                              226)),
                                                  child: Text(
                                                    cubit.veiwedSymptoms[index],
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                  Center(
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color(0xFF1171C8))),
                                        onPressed:
                                            cubit.selectedSymptoms.length >= 3
                                                ? () async {
                                                    response = await cubit
                                                        .medicalDiagnosis();
                                                  }
                                                : null,
                                        child: const Text("Continue")),
                                  ),
                                ],
                              ));
          }),
    );
  }
}
