import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String _title = "";
  final _formKey = GlobalKey<FormState>();
  String _priority;
  final List<String> _priorities = ['Low', 'Medium', 'High'];
  DateTime _date = DateTime.now();
  TextEditingController _datecontroller = TextEditingController();
  DateFormat _dateFormat = DateFormat("MMM dd, yyyy ");

  _handledatepicker() async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _datecontroller.text = _dateFormat.format(date);
    }
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$_title $_date $_priority');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Add Tasks",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      textsection(),
                      datesection(),
                      prioritysection(),
                      addbutton(),
                      removebutton(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textsection() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        child: TextFormField(
          style: TextStyle(fontSize: 18.0),
          decoration: InputDecoration(
              labelText: "TItle",
              labelStyle: TextStyle(fontSize: 18.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0))),
          validator: (input) =>
              input.trim().isEmpty ? 'Please enter a tile ' : null,
          onSaved: (input) => _title = input,
          initialValue: _title,
        ),
      ),
    );
  }

  Widget prioritysection() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        child: DropdownButtonFormField(
          isDense: true,
          icon: Icon(Icons.arrow_drop_down_circle),
          iconEnabledColor: Colors.red,
          iconSize: 22.0,
          items: _priorities.map((String priority) {
            return DropdownMenuItem(
              value: priority,
              child: Text(
                priority,
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            );
          }).toList(),
          style: TextStyle(fontSize: 18.0),
          decoration: InputDecoration(
              labelText: "Priority",
              labelStyle: TextStyle(fontSize: 18.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0))),
          validator: (input) =>
              _priority == null ? 'Please select priority level' : null,
          onSaved: (input) => _priority = input,
          onChanged: (value) {
            setState(() {
              _priority = value;
            });
          },
        ),
      ),
    );
  }

  Widget datesection() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        child: TextFormField(
          readOnly: true,
          controller: _datecontroller,
          onTap: _handledatepicker,
          style: TextStyle(fontSize: 18.0),
          decoration: InputDecoration(
              labelText: "Date",
              labelStyle: TextStyle(fontSize: 18.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0))),
        ),
      ),
    );
  }

  Widget addbutton() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 60.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: FlatButton(
          child: Text(
            "Add",
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: _submit,
        ));
  }

  Widget removebutton() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 60.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: FlatButton(
          child: Text(
            "Remove",
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: _submit,
        ));
  }
}
