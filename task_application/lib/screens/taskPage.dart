import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_application/screens/addPage.dart';
import 'package:http/http.dart' as http;
const IconData delete = IconData(0xe1b9, fontFamily: 'MaterialIcons');
class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List items = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTasks();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body:RefreshIndicator( 
        onRefresh: fetchTasks,
        child: ListView.builder(
        itemCount: items.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context,index){
          final item = items[index] as Map;
          final objectId = item['objectId'];
          return Card(
           child: ListTile(
            leading: CircleAvatar(child: Text('${index+1}')),
            title: Row(
                children: [
                  Text(item["Task"]),
                  IconButton(
                    icon: Icon(Icons.edit),
                    iconSize: 18,
                    onPressed: () {
                      navigateToEditPage(item);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    iconSize: 18,
                    onPressed: () {
                      deleteById(objectId);
                    },
                  ),
                ],
              ),
            subtitle: Text(item["Details"]),
          )
          );
        })
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: navigateToAddPage, label: Text("Add Task")),
    );
  }
  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(builder: (context) =>AddPage());
    await Navigator.push(context,route);
    setState(() {
      isLoading = true;
    });
    fetchTasks();
  }
  void navigateToEditPage(Map item){
    final route = MaterialPageRoute(builder: (context) =>AddPage(task: item));
    Navigator.push(context,route);
  }
  Future<void> deleteById(String id) async {
    final headers = {
      "X-Parse-Application-Id":"pOAK8NmMOHaPrlUyOqtnHSCAlrpN75FbSUbNyvio",
      "X-Parse-REST-API-Key":"eYNrP7QUfckn3BnenHMJtbS3EwNZz4jguPmZxAEr",
      "Content-type":"Application/json"
    };
    final url = Uri.parse('https://parseapi.back4app.com/classes/Task_details/$id');
    final response = await http.delete(url, headers: headers);
    if (response.statusCode==200){
      setState(() {
        items = items.where((element) => element("objectId") != id).toList();  
      });
    }
  }

  Future<void> fetchTasks() async{
    final headers = {
      "X-Parse-Application-Id":"pOAK8NmMOHaPrlUyOqtnHSCAlrpN75FbSUbNyvio",
      "X-Parse-REST-API-Key":"eYNrP7QUfckn3BnenHMJtbS3EwNZz4jguPmZxAEr",
      "Content-type":"Application/json"
    };
    final url = Uri.parse('https://parseapi.back4app.com/classes/Task_details');
    final response = await http.get(url, headers: headers);
    if (response.statusCode==200){
      final json = jsonDecode(response.body) as Map;
      final result = json["results"] as List;
      setState(() {
        items = result;
      });
    }else{
      print("Something went wrong");
    }
  }
}