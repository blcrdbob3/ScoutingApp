import 'package:flutter/cupertino.dart';

class Question {
  String id;
  String title;
  String type;
  bool isRequired;
  String? errorText;
  IconData icon;
  List<String>? options;
  double? minimum;
  double? maximum;

  Question(
      {required this.id,
        required this.title,
        required this.type,
        required this.icon,
        required this.isRequired,
        this.errorText = "This question is required",
        this.options = const ["Default"],
        this.minimum = 0,
        this.maximum = 10});
  Question.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        type = data['type'],
        icon = data['icon'],
        isRequired = data['isRequired'] ?? false,
        errorText = data['errorText'] == null
            ? null
            : data['errorText'] = "This question is required",
        options =
        data['options'] == null ? null : data['options'] = ["Default"],
        minimum = data['minimum'] == null ? null : data['minimum'] = -1.00,
        maximum = data['maximum'] == null ? null : data['maximum'] = -1.00;
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'id': id,
      'title': title,
      'type': type,
      'icon': icon,
      'isRequired': isRequired,
      'errorText': errorText,
      'options': options,
      'minimum': minimum,
      'maximum': maximum,
    };
    if (options == ["Default"]) {
      data['options'] == null;
    }
    if (errorText == "This question is required") {
      data['errorText'] == null;
    }
    if (minimum == -1.00) {
      data['minimum'] == null;
    }
    if (maximum == -1.00) {
      data['maximum'] == null;
    }
    return data;
  }
}

class ScoutForm {
  final String id;
  final String name;
  final List<Question> questions;

  ScoutForm({required this.id, required this.name, this.questions = const []});

  ScoutForm.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        questions = List<Question>.from(
            json['questions'].map((question) => Question.fromJson(question)));

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'questions': questions.map(((e) => e.toJson())).toList()
    };
  }
}
