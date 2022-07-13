import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key, required this.document, required this.id})
      : super(key: key);

  final Map<String, dynamic> document;
  final String id;




  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  /*late TextEditingController dateinput;*/


  late String type;
  late String category;

  bool edit = false;

  @override
  void initState() {
    super.initState();
    String title = widget.document["title"] ?? "No Task Title";
    titleController = TextEditingController(text: title);
    descriptionController =
        TextEditingController(text: widget.document["description"]);
    type = widget.document["type"];
    category = widget.document["category"];
    /*dateinput = TextEditingController(text: widget.document["format"]);*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          color: edit ? Colors.black : Colors.lightBlue.shade300,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.black,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 28,
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("mytask")
                              .doc(widget.id)
                              .delete()
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: edit ? Colors.red : Colors.black,
                      size: 28,
                    ),
                    onPressed: () {
                      setState(() {
                        edit = !edit;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 2),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(edit ? "Editing" : "View",
                          style: TextStyle(
                            fontSize: 28,
                            color: edit ? Colors.redAccent : Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("Your Task",
                          style: TextStyle(
                            fontSize: 28,
                            color: edit ? Colors.redAccent : Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          )),
                      SizedBox(
                        height: 30,
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label("Task Title "),
                    TextField(
                      controller: titleController,
                      enabled: edit,

                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.5,
                          color: edit? Colors.white : Colors.black54),
                      decoration: const InputDecoration(
                        //contentPadding: EdgeInsets.all(10.0),
                        hintStyle: TextStyle(
                            color: Colors.redAccent, letterSpacing: 2),
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
                      height: 20,
                    ),

                    // ----- Enter description--------
                    label("Description"),
                    TextField(
                      controller: descriptionController,
                      enabled: edit,
                      style:  TextStyle(
                          color: edit? Colors.white : Colors.black54,
                        fontSize: 18,
                        letterSpacing: 0.5,
                      ),
                      decoration: const InputDecoration(
                        hintMaxLines: null,
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
                        Category_type("Run", 0xffcc0099),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),


                    const SizedBox(
                      height: 10,
                    ),

                    // -----Choose Date---------
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              edit ? button() : Container(),
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
        FirebaseFirestore.instance.collection("mytask").doc(widget.id).update({
          "title": titleController.text,
          "description": descriptionController.text,
          "type": type,
          "category": category,
          // "format": date,
        }).then((value) => print(widget.id));
        Navigator.pop(context);
      },
      child: Center(
        child: Container(
          width: 200,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [Color(0x5cf55145), Color(0xfc700d06)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )),
          child: const Center(
            child: Text(
              "Update",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(label,
        style: TextStyle(
          color: edit ? Colors.red : Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 16.5,
          letterSpacing: 1,
        ));
  }

  Widget task_type(String label, int color) {
    return InkWell(
      onTap: edit
          ? () {
              setState(() {
                type = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: type == label ? Colors.black54 : Color(color),
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
      onTap: edit
          ? () {
              setState(() {
                category = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: category == label ? Colors.black54 : Color(color),
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

}
