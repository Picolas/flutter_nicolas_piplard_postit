import 'package:flutter/material.dart';
import 'package:post_it/ListPostData.dart';
import 'package:post_it/PostIt.dart';

import 'Color.dart';
import 'Historique.dart';
import 'Models/Post.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Post IT App - Nicolas PIPLARD';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: textColor,
          displayColor: textColor,
        ),

      ),
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    String formDialogName = "";
    String formDialogDescription = "";
    String formDialogCategorie = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post IT App - Nicolas PIPLARD'),
        backgroundColor: primaryColor,
      ),
      body: (_selectedIndex == 0) ? PostIt() : Historique(),

      floatingActionButton: FloatingActionButton(
        backgroundColor: highlightColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: primaryColor,
                  content: Stack(
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -40.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                style: TextStyle(color: textColor),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Nom',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez rentrer un nom';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value != null || !value.isEmpty) {
                                    formDialogName = value;
                                  }
                                }
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                style: TextStyle(color: textColor),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Description'
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez rentrer une description';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value != null || !value.isEmpty) {
                                    formDialogDescription = value;
                                  }
                                }
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                  style: TextStyle(color: textColor),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Categorie'
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez rentrer une categorie';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    if (value != null || !value.isEmpty) {
                                      formDialogCategorie = value;
                                    }
                                  }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: Text("Créer"),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    listPost.add(
                                      Post(Icons.alarm, formDialogName, formDialogDescription, formDialogCategorie, DateTime.now(), false)
                                    );
                                    Navigator.pop(context);
                                    setState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('La tâche a bien été ajouté'),
                                      ),
                                    );
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryColor,
        selectedItemColor: highlightColor,
        unselectedItemColor: secondaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Boite de reception',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historique',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}