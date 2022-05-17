import 'package:flutter/material.dart';
import 'package:post_it/Models/Post.dart';

import 'Color.dart';
import 'ListPostData.dart';

class PostIt extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _PostItState();
}

class _PostItState extends State<PostIt> {
  bool value = false;

  @override
  State<StatefulWidget> createState() => _PostItState();

  @override
  Widget build(BuildContext context) {

    List<Post> unvalidatedListPost = listPost.where((post) => post.status == false).toList();

    print(unvalidatedListPost);

    return Scaffold(
      body: Center(

        child: GridView.builder(
            physics: ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2),
            itemCount: unvalidatedListPost.length,
            itemBuilder: (BuildContext ctx, index) {
              return Card(
                color: primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Column(
                      children: [
                        Row(
                            children: [
                              Icon(unvalidatedListPost[index].icon),
                              Text(unvalidatedListPost[index].nom)
                            ]
                        ),
                        Text(unvalidatedListPost[index].description),
                        Row(
                            children: [
                              Text(unvalidatedListPost[index].category),
                              Checkbox(
                                activeColor: highlightColor,
                                value: unvalidatedListPost[index].status,
                                onChanged: (value) {
                                  unvalidatedListPost[index].status = value!;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('La tache vient d\'être terminé et est disponible dans l\'historique'),
                                    ),
                                  );
                                  setState(() {
                                    this.value = value!;
                                  });
                                },
                              ),
                              Expanded(child: Text(unvalidatedListPost[index].creationDate.day.toString() + '/' + unvalidatedListPost[index].creationDate.month.toString() + '/' + unvalidatedListPost[index].creationDate.year.toString()))
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