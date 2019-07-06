import 'package:flutter/material.dart';
import 'package:raoroshanlalmarket/pages/AddData.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _password =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.account_circle),
        title: Text('Rao Roshan Lal Market',textAlign: TextAlign.center,),
      ),
      body: ListView(
        children: <Widget>[
          Card(margin: const EdgeInsets.only(left: 70.0, right: 50.0),
           // elevation: 5.0,
            child: Image( width: 200.0,height: 200, fit: BoxFit.fitWidth,alignment: Alignment.center,
              image:AssetImage('images/logo.png'),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              padding: const EdgeInsets.only(left:30.0,top: 15.0, bottom: 15.0,right: 30.0),
              color: Colors.lightBlueAccent,
              elevation: 3.0,
              onPressed: () {
                _login(_password.text);
                // Navigator.pop(context);
              },
              child: Text('Submit', style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
            ),
          ),
        ],
      ),
    );
  }
  _login(String password) {
    if (password.isNotEmpty && password == '2233') {
      _password.clear();
      //showmessgae("password is Right");
      var router =MaterialPageRoute(
          builder: (BuildContext context) => AddData(passd : password));
      Navigator.of(context).push(router);

    } else {
      _password.clear();
      showmessgae("password is wrong or Empty");
    }
  }

  void showmessgae (String alerts) {
    var alert = AlertDialog(
      title: Text('Error Alert'),
      content: Text('Error Alert: $alerts'),
      actions: <Widget>[
        FlatButton(
          child: Text('ok'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],

    );
    showDialog(context: context , builder:(_)=> alert);
    //showDialog(context: context , child: alert );
  }
}
