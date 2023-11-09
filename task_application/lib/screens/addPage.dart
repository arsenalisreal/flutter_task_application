import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  final Map? task;
  const AddPage({super.key, this.task});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController TaskNameController = TextEditingController();
  TextEditingController TaskDescriptionController = TextEditingController();
  bool isEditOnly = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final taskDetails = widget.task;
    if(taskDetails != null){
      isEditOnly = true;
      final taskName = taskDetails["taskName"];
      final taskDescription = taskDetails["taskDescription"];
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditOnly ?'Edit Task Details' : 'Add task details'
          ),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          TextField(
            controller: TaskNameController,
            decoration: InputDecoration(hintText: "Task Name"),
          ),
          TextField(
            controller: TaskDescriptionController,
            decoration: InputDecoration(hintText: "Task Description"),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed:isEditOnly? editData: submitData,
            child: Text(
            isEditOnly? "Update Task":"Add Task"
            ))
        ],
      ),
    );
  }

  Future<void> editData() async{

    final task = widget.task;
    if (task == null){
      print("Something went wrong");
      return;
    }
    //print(task);
    final taskId = task["objectId"];
    final taskName = TaskNameController.text;
    final taskDescription = TaskDescriptionController.text;
    final requestBody ={
      "Task": taskName,
      "Details": taskDescription
    };
    final headers = {
      "X-Parse-Application-Id":"pOAK8NmMOHaPrlUyOqtnHSCAlrpN75FbSUbNyvio",
      "X-Parse-REST-API-Key":"eYNrP7QUfckn3BnenHMJtbS3EwNZz4jguPmZxAEr",
      "Content-type":"Application/json"
    };
    final url = Uri.parse('https://parseapi.back4app.com/classes/Task_details/$taskId');
    final response = await http.put(url, body: jsonEncode(requestBody), headers: headers);
    if(response.statusCode == 200){
      //print("Sent successfully");
      showMessageStatus("Task added successfully");
      // reset the values
      TaskNameController.text = '';
      TaskDescriptionController.text = '';
    }else{
      //print("Failed to send task details");
      showMessageStatus("Failed to add task");
    }
  }

  Future<void> submitData() async{
    final taskName = TaskNameController.text;
    final taskDescription = TaskDescriptionController.text;
    final requestBody ={
      "Task": taskName,
      "Details": taskDescription
    };
    final headers = {
      "X-Parse-Application-Id":"pOAK8NmMOHaPrlUyOqtnHSCAlrpN75FbSUbNyvio",
      "X-Parse-REST-API-Key":"eYNrP7QUfckn3BnenHMJtbS3EwNZz4jguPmZxAEr",
      "Content-type":"Application/json"
    };
    final url = Uri.parse('https://parseapi.back4app.com/classes/Task_details');
    final response = await http.post(url, body: jsonEncode(requestBody), headers: headers);
    if(response.statusCode == 201){
      //print("Sent successfully");
      showMessageStatus("Task added successfully");
      // reset the values
      TaskNameController.text = '';
      TaskDescriptionController.text = '';
    }else{
      //print("Failed to send task details");
      showMessageStatus("Failed to add task");
    }
  }

  void showMessageStatus(String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}