import 'dart:io';

import 'package:database_project/model/data_model.dart';

import 'package:database_project/screen/details/screen_details.dart';
import 'package:database_project/screen/search/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Screensearch extends StatelessWidget {
  Screensearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          TextFormField(
            onChanged: (value) {
              BlocProvider.of<SearchBloc>(context)
                  .add(SearchDoneValue(searchValue: value));
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              hintText: "Search here",
            ),
          ),
          // data = StudentList[index];
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Expanded(
                child: (state.studentSearchResultList.isNotEmpty)
                    ? ListView.separated(
                        itemBuilder: (context, index) {
                          final data = state.studentSearchResultList[index];
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => detailsScreen(
                                          student: data,
                                          // student: data,
                                        )),
                              );
                            },
                            leading: CircleAvatar(
                              backgroundImage: FileImage(File(
                                  state.studentSearchResultList[index].image!)),
                            ),
                            title:
                                Text(state.studentSearchResultList[index].name),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: state.studentSearchResultList.length)
                    : Center(child: Text(" Not found")),
              );
            },
          )
        ]),
      ),
    );
  }
}
