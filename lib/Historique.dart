import 'package:flutter/material.dart';
import 'package:post_it/Models/Post.dart';

import 'Color.dart';
import 'ListPostData.dart';

class Historique extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  bool value = false;

  @override
  State<StatefulWidget> createState() => _HistoriqueState();

  @override
  Widget build(BuildContext context) {

    List<Post> validatedListPost = listPost.where((post) => post.status == true).toList();

    return Scaffold(
      body: Center(

        child: GridView.builder(
            physics: ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2),
            itemCount: validatedListPost.length,
            itemBuilder: (BuildContext ctx, index) {
              return Card(
                color: primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Column(
                      children: [
                        Row(
                            children: [
                              Icon(validatedListPost[index].icon),
                              Text(validatedListPost[index].nom)
                            ]
                        ),
                        Text(validatedListPost[index].description),
                        Row(
                            children: [
                              Text(validatedListPost[index].category),
                              Checkbox(
                                activeColor: highlightColor,
                                value: validatedListPost[index].status,
                                onChanged: (value) {
                                  validatedListPost[index].status = value!;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('La tache à été remis dans la liste à faire'),
                                    ),
                                  );
                                  setState(() {
                                    this.value = value!;
                                  });
                                },
                              ),
                              Expanded(child: Text(validatedListPost[index].creationDate.day.toString() + '/' + validatedListPost[index].creationDate.month.toString() + '/' + validatedListPost[index].creationDate.year.toString()))
                            ]
                        )
                      ]
                  ),
                ),
                elevation: 8,
              );
            }),
      ),
    );
  }
}