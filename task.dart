

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
   late FlutterLocalNotificationsPlugin fltrNotify;

  @override
  void initState() {
    super.initState();
    var androidInitialize = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);



   fltrNotify =  FlutterLocalNotificationsPlugin();
    fltrNotify.initialize(initializationSettings);


    dateinput.text = "";
    super.initState();
  }

  Future _shownotification() async {
    var androidDetails = const AndroidNotificationDetails("Channel ID", "MyApp",importance: Importance.high);
    var iSODetails = const IOSNotificationDetails();
    var generalNotify =
        NotificationDetails(android: androidDetails, iOS: iSODetails);

    /*await fltrNotify.show(
        0, titleController.text, "You created a new task", generalNotify);*/

    var scheduledTime = DateTime.now().add(const Duration(seconds: 5));
    //var _choosen;


    /*f(_choosen == "Hour"){
      scheduledTime = DateTime.now().add(const Duration(hours: value1));

    }else if(_choosen == "Minute"){
      scheduledTime = DateTime.now().add(const Duration(minutes: value1));
    }else DateTime.now().add(const Duration(seconds: value1));
*/


    
    fltrNotify.schedule(0, titleController.text, descriptionController.text,
        scheduledTime, generalNotify);

  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateinput = TextEditingController();



   late String type = "";
  late String category = "";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 50,
              ),
              IconButton(
                icon: const Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 2),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Create",
                          style: TextStyle(
                            fontSize: 33,
                            color: Colors.white38,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      Text("New Task",
                          style: TextStyle(
                            fontSize: 33,
                            color: Colors.white38,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          )),
                      SizedBox(
                        height: 28,
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      /*onChanged: (value) {
                            title = value;
                          },*/

                      controller: titleController,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        //contentPadding: EdgeInsets.all(10.0),
                        hintText: "Task  Title",
                        hintStyle:
                            TextStyle(color: Colors.white, letterSpacing: 2),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    label("Task Type"),
                    const SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      children: [
                        task_type("Important", 0xffcc9900),
                        const SizedBox(
                          width: 10,
                        ),
                        task_type("Planned", 0xffcc0099),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // ----- Enter description--------
                    TextField(
                      /* onChanged: (value) {
                            desc = value;
                          },*/
                      controller: descriptionController,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        //contentPadding: EdgeInsets.all(10.0),
                        hintText: "Description ",
                        hintMaxLines: null,
                        hintStyle:
                            TextStyle(color: Colors.white, letterSpacing: 2),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38),
                        ),
                      ),
                    ),
                    // ----- Enter description--------
                    const SizedBox(
                      height: 20,
                    ),

                    label("Category Task"),
                    const SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      children: [
                        Category_type("Food", 0xffff6d6e),
                        const SizedBox(
                          width: 5,
                        ),
                        Category_type("Work", 0xfff29732),
                        const SizedBox(
                          width: 5,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Category_type("Run", 0xffcc2bc8d9),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: dateinput, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today,color: Colors.white,), //icon of text field
                      labelText: "Enter Date",labelStyle: TextStyle(color:Colors.white)//label text of field
                  ),
                  readOnly: true,  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101)
                    );

                    if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateinput.text = formattedDate; //set output date to TextField value.
                      });
                    }else{
                      print("Date is not selected");
                    }
                  },
                ),

                    // -----Choose Date---------
                  /*  SizedBox(
                      child: DateTimeField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          format = value;
                        },
                        format: format,

                        onSaved: (value) => print(value),
                        decoration: const InputDecoration(
                            hintText: "Choose Date",
                            hintStyle: TextStyle(
                                color: Colors.white, letterSpacing: 2),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white38),
                            )),
                        onShowPicker: (context, currentValue) async {
                          final date = showDatePicker(
                              context: context,
                              initialDate: currentValue ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100));

                          return date;

                        },
                      ),
                    ),*/
                    // -----Choose Date---------
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Set Reminder",
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontSize: 16),
                        ),
                        DropdownButton(
                          hint: Text('sec',style: TextStyle(color: Colors.white60),),
                            items: const [
                              DropdownMenuItem(
                                child: Text("sec"),
                                value: "Seconds"
                              ),
                              DropdownMenuItem(
                                  child: Text("min"),
                                  value: "Minutes"
                              ),
                              DropdownMenuItem(
                                  child: Text("hr"),
                                  value: "Hour"
                              )
                            ],
                            onChanged: (_val){
                              setState((){
                                var _selectedOp = _val;
                              }
                              );
                            }
                        ),
                        IconButton(
                          icon: const Icon(
                            CupertinoIcons.rays,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            _shownotification();
                            print("Notify");
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    button(),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 50,
              ),
            ]),
          )),
    );
  }



  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("mytask").add({
          "title": titleController.text,
          "description": descriptionController.text,
          "type": type,
          "category": category,
          "format": dateinput.text,
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white60,
          ),
        ),
        child: const Center(
          child: Text(
            "Add Task",
            style: TextStyle(
              color: Colors.white60,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(label,
        style: const TextStyle(
          color: Colors.white60,
          fontWeight: FontWeight.w600,
          fontSize: 16.5,
          letterSpacing: 0.2,
        ));
  }

  Widget task_type(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = label;
        });
      },
      child: Chip(
        backgroundColor: type == label ? Colors.black : Color(color),
        label: Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, letterSpacing: 1),
        ),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget Category_type(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        backgroundColor: category == label ? Colors.black : Color(color),
        label: Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, letterSpacing: 1),
        ),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

    selectNotification(String? payload) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(titleController.text),
          content: Text(descriptionController.text),
        ),
    );
  }
}
