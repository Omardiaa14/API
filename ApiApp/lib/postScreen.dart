import 'dart:async';
import 'dart:convert';

import 'package:apiapp/Posts.dart';
import 'package:flutter/material.dart';
import "package:sky_engine/_http/" as http;

class postScreen extends StatefulWidget {
  const postScreen({Key? key}) : super(key: key);

  @override
  State<postScreen> createState() => _postScreenState();
}

class _postScreenState extends State<postScreen> {
  Future<List<posts>> getposts() async {
    List<posts> listposts = [];
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var response = await http.get(url);
    var responsbody = jsonDecode(response.body);
    for (int i = 0; i <= responsbody.length; i++) {
      listposts.add(posts(responsbody[i]["userId"], responsbody[i]["id"],
          responsbody[i]["title"], responsbody[i]["body"]));
    }
    return listposts;
  }

  @override
  void initstate() {
    getposts();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("post"),
        ),
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return (snapshot.hasData)?ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text("${snapshot.data["index"].id}"),
                  title: Text("${snapshot.data["index"].title}"),
                  subtitle:Text("${snapshot.data["index"].body}"),
                );
              },
            ) : Center(child: CircularProgressIndicator());
          },
        ));
  }
}
