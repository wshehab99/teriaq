import 'package:find_doctor/shared/textFieldApp.dart';
import 'package:flutter/material.dart';

import '../../fake_data/fake_data.dart';
import '../../shared/diagnosesList.dart';

class BookDoctorHomeVisit extends StatefulWidget {
  BookDoctorHomeVisit({Key? key}) : super(key: key);

  @override
  State<BookDoctorHomeVisit> createState() => _BookDoctorHomeVisitState();
}

class _BookDoctorHomeVisitState extends State<BookDoctorHomeVisit> {
  SpecializationData? sp;
  @override
  var size, height, width;

  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Book a Home Visit Doctor"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              child: Column(children: [
                Image(
                  image: AssetImage("assets/images/Dawiny logo - 2.png"),
                  height: height * .07,
                  width: width * .35,
                ),
                SizedBox(
                  height: 5,
                ),
                Image(
                  image: AssetImage("assets/images/doctorhomevisit.png"),
                  height: height * .15,
                  width: width * .5,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "احجز زياره منزلية",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: height * .033,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "الان مع داوينى يمكنك حجز زيارة منزليه مع دكتور متخصص",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: height * .023,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Icon(
                  Icons.arrow_circle_down_outlined,
                  size: height * .04,
                  color: Colors.blueGrey,
                ),
              ]),
              height: height * .423,
              width: width,
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                ),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 15,
                      offset: Offset(0, 5),
                      color: Colors.black54)
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * .015,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              height: height * .3,
              width: width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(164, 184, 184, 184),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                ),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 15, offset: Offset(0, 5), color: Colors.white)
                ],
              ),
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        sp = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DiagnosesList()),
                        );
                      },
                      child: Text("Chooes Diagnos")),
                  sp == null
                      ? Text('')
                      : Container(
                          width: 300,
                          height: 50,
                          child: Row(
                            children: [
                              Image(image: AssetImage('${sp?.imagePath}')),
                              Text("${sp?.name}")
                            ],
                          )),
                  ElevatedButton(
                      onPressed: () {}, child: Text('Chooes Location'))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
