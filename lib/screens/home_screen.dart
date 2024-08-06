import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/api_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<ApiProvider>(context, listen: false).fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prov API with e_handling"),
        centerTitle: true,
      ),
      body: Consumer<ApiProvider>(builder: (context, apiProvider, child) {
        if (apiProvider.error != null) {
          return Center(child: Text(apiProvider.error!));
        } else if (apiProvider.data.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              itemCount: apiProvider.data.length,
              itemBuilder: ((context, index) => ListTile(
                    title: Text(apiProvider.data[index]["username"]),
                    subtitle: Text(apiProvider.data[index]["id"].toString()),
                  )));
        }
      }),
    );
  }
}
