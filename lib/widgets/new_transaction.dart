import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if(amountController.text.isEmpty){
    return;
  }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate==null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate){
      if(pickedDate==null)
      {return;}
      setState(() {
        _selectedDate=pickedDate;
        
      });
      

    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              //onChanged: (val){
              //titleInput=val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              //onChanged: (val)=>amountInput=val,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                 Expanded(child: Text(_selectedDate==null?'No date chosen':DateFormat.yMd().format(_selectedDate))),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              color: Colors.purple,
              textColor: Colors.white,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
