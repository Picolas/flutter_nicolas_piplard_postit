import 'package:flutter/material.dart';

class Post {
  IconData icon;
  String nom;
  String description;
  String category;
  DateTime creationDate;
  bool status;

  Post(this.icon, this.nom, this.description, this.category,
      this.creationDate, this.status);
}