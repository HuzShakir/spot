import 'package:flutter/material.dart';

class User {
  final String username;
  final String email;
  final String password;

  User(this.username, this.email,this.password);

  User.fromJson(Map<String, dynamic> json): username = json['name'],
        password=json['password'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': username,
        'email': email,
        'password':password,
        // 'playlist':[]
      };
}