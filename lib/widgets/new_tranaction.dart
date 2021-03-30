import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).viewInsets.bottom + 10;
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10, bottom: bottomPadding, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 10),
              TextField(
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                    _add();
                  },
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(selectedDate == null
                      ? 'No date chosen !'
                      : DateFormat.yMd().format(selectedDate)),
                  Platform.isIOS
                      ? CupertinoButton(
                          child: Text('Select Date'), onPressed: _selectDate)
                      : FlatButton(
                          onPressed: _selectDate,
                          child: Text('Select Date'),
                          textColor: Theme.of(context).primaryColor,
                        )
                ],
              ),
              SizedBox(height: 30),
              Platform.isIOS
                  ? CupertinoButton.filled(
                      child: Text('Add Transaction'), onPressed: () => _add())
                  : FlatButton(
                      onPressed: () => _add(),
                      child: Text('Add Transaction'),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                    )
            ],
          ),
        ),
      ),
    );
  }

  void _add() {
    if (selectedDate != null)
      widget.addNewTransaction(
          _titleController.text, _amountController.text, selectedDate);
  }

  void _selectDate() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }
}
