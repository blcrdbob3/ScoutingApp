/*
scoutingPage.dart, a file that creates a dynamic form

Current issues with this file:
Fix orientation issues with dynamic sizing
Save form with validator so that if user accidentally dies/exits app, form is saved instead of
being wiped
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:scoutingapp/components/common/form.dart';
import 'package:scoutingapp/main.dart';

//import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

// create template questions (temporary until server can send ScoutForm)

ScoutForm form = ScoutForm(id: 'testform', name: 'Test Form', questions: [
  Question(
      id: "team",
      title: "Team Number",
      isRequired: true,
      errorText: "Answer the question, mate",
      type: "number",
      icon: Icons.person),
  Question(
      id: "match",
      title: "Match Number",
      errorText: "Literally no idea what you're talking about",
      isRequired: true,
      type: "number",
      icon: Icons.confirmation_number),
  Question(
      id: "numofpts",
      title: "# of pts scored",
      errorText: "Well, what am I supposed to do?",
      isRequired: true,
      type: "number",
      icon: Icons.sports_soccer),
  Question(
      id: "multi",
      title: "Multi-select question",
      isRequired: true,
      type: "multiselect",
      icon: Icons.abc,
      options: ["Sanjith", "Loves", "FalseBoolean"]),
  Question(
      id: "loverobotics",
      title: "Do you love Robotics?",
      isRequired: true,
      errorText: "Answer it, answer it please!",
      type: "boolean",
      icon: Icons.favorite),
  Question(
      id: "extracomments",
      title: "Extra Comments",
      isRequired: false,
      type: "text",
      icon: Icons.comment),
  Question(
      id: "checkbox",
      title: "Checklist",
      isRequired: true,
      errorText: "Chiran can do better than you, what'cha doing bro?",
      type: "checkbox",
      icon: Icons.comment,
      options: ["Option 1", "Option 2", "Option 3"]),
  Question(
      id: "slider",
      title: "Match Rating",
      isRequired: true,
      errorText: "Don't you know how to use this?",
      type: "slider",
      icon: Icons.comment),
]);

// create scouting page

class ScoutingPage extends StatelessWidget {
  const ScoutingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScoutingWizard',
      theme: ThemeData(primarySwatch: customColor),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.delegate.supportedLocales,
      home: const Scaffold(
        body: ScoutingPageForm(),
      ),
    );
  }
}

// create form state

class ScoutingPageForm extends StatefulWidget {
  const ScoutingPageForm({Key? key}) : super(key: key);

  @override
  ScoutingPageFormState createState() {
    return ScoutingPageFormState();
  }
}

// create custom text class

class FormText extends StatelessWidget {
  final String label;
  final bool isRequired;

  const FormText({super.key, required this.label, required this.isRequired});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: ' $label',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 4.w,
          )),
      TextSpan(
          text: isRequired ? '* ' : ' ',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 4.w,
          )),
    ]));
  }
}

// create form state widget

class ScoutingPageFormState extends State<ScoutingPageForm> {
  // create question variable
  var _questions = form.questions.iterator;

  // create key
  final _formKey = GlobalKey<FormBuilderState>();

  _question(int index) {
    // implement save every single change if you'd like

    // create variables
    var questionType = _questions.current.type;
    // variable for text question
    var text =
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Expanded(
          child: FormBuilderTextField(
        name: _questions.current.id,
        decoration: InputDecoration(
            icon: Icon(_questions.current.icon),
            label:
                FormText(label: _questions.current.title, isRequired: false)),
      ))
    ]);
    // variable for number question
    var number =
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Expanded(
        child: FormBuilderTextField(
            name: _questions.current.id,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                icon: Icon(_questions.current.icon),
                label: FormText(
                    label: _questions.current.title,
                    isRequired: _questions.current.isRequired)),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
            // validator
            validator: (value) {
              if (value == null && form.questions[index].isRequired == true) {
                return form.questions[index].errorText;
              } else {
                return null;
              }
            }),
      )
    ]);
    // variable for boolean question
    var boolean =
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Expanded(
        child: FormBuilderRadioGroup(
            name: _questions.current.id,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                icon: Icon(_questions.current.icon),
                label: FormText(
                    label: _questions.current.title,
                    isRequired: _questions.current.isRequired)),
            // options
            options: const [
              FormBuilderFieldOption(value: "True", child: Text("True")),
              FormBuilderFieldOption(value: "False", child: Text("False"))
            ],
            // validator
            validator: (value) {
              if (value == null && form.questions[index].isRequired == true) {
                return form.questions[index].errorText;
              } else {
                return null;
              }
            }),
      )
    ]);
    // variable for multiselect question
    var multiselect =
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Expanded(
        child: FormBuilderRadioGroup(
            name: _questions.current.id,
            orientation: OptionsOrientation.vertical,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                icon: Icon(_questions.current.icon),
                label: FormText(
                    label: _questions.current.title,
                    isRequired: _questions.current.isRequired)),
            // options
            options: _questions.current.options!
                .map((option) =>
                    FormBuilderFieldOption(value: option, child: Text(option)))
                .toList(growable: false),
            // validator
            validator: (value) {
              if (value == null && form.questions[index].isRequired == true) {
                return form.questions[index].errorText;
              } else {
                return null;
              }
            }),
      )
    ]);
    var checkbox =
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Expanded(
        child: FormBuilderCheckboxGroup(
            name: _questions.current.id,
            orientation: OptionsOrientation.vertical,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                icon: Icon(_questions.current.icon),
                label: FormText(
                    label: _questions.current.title,
                    isRequired: _questions.current.isRequired)),
            options: _questions.current.options!
                .map((option) =>
                    FormBuilderFieldOption(value: option, child: Text(option)))
                .toList(growable: false),
            // validator
            validator: (value) {
              if (value == null && form.questions[index].isRequired == true) {
                return form.questions[index].errorText;
              } else {
                return null;
              }
            }),
      )
    ]);
    var slider =
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Expanded(
          child: FormBuilderSlider(
              name: _questions.current.id,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                  icon: Icon(_questions.current.icon),
                  label: FormText(
                      label: _questions.current.title,
                      isRequired: _questions.current.isRequired)),
              initialValue: _questions.current.minimum!,
              min: _questions.current.minimum!,
              max: _questions.current.maximum!,
              divisions: 20,
              validator: (value) {
                if (value == form.questions[index].minimum &&
                    form.questions[index].isRequired == true) {
                  return form.questions[index].errorText;
                }
                if (value != form.questions[index].minimum &&
                    form.questions[index].isRequired == true) {
                  form.questions[index].isRequired = false;
                  return null;
                } else {
                  return null;
                }
              }))
    ]);

    if (!_questions.moveNext()) {
      _questions = form.questions.iterator;
    }
    switch (questionType) {
      case "text":
        return text;
      case "boolean":
        return boolean;
      case "multiselect":
        return multiselect;
      case "number":
        return number;
      case "checkbox":
        return checkbox;
      case "slider":
        return slider;
    }
  }

  @override
  Widget build(BuildContext context) {
    _questions.moveNext();
    // create list of questions
    return FormBuilder(
        key: _formKey,
        child: Scaffold(
            appBar: AppBar(title: Text(form.name)),
            body: Column(children: <Widget>[
              Flexible(
                  child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: form.questions.length,
                      itemBuilder: (context, index) {
                        return _question(index);
                      })),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    // validator
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final formData = _formKey.currentState?.value;
                      debugPrint(formData.toString());
                      // processing data message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      // submitted data message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Submitted Data')),
                      );
                      // return to homePage after data has been submitted w/ navigator
                      // add wait for when data is being processed
                    }
                  },
                  child: const Text("Submit"),
                ),
              ),
            ])));
  }
}
