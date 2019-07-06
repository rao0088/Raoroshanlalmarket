//import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raoroshanlalmarket/database/RentData.dart';
import 'package:raoroshanlalmarket/database/RentHelper.dart';

class Rentdetails extends StatefulWidget {
  final int id;
  Rentdetails({Key key, this.id}): super(key : key);
  @override
  _RentdetailsState createState() => _RentdetailsState();
}

class _RentdetailsState extends State<Rentdetails> {
     RentHelper rentHelper = RentHelper();
  final List <RentData> _userlistd =<RentData>[];

  @override
  void initState() {
    super.initState();
    _showdata(widget.id);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meter Details'),
      ),
      body: Container(
        child: ListView.builder(
            padding:  const EdgeInsets.all(8.0),
            reverse: false,
            itemCount: _userlistd.length,
            itemBuilder: (_,int index){

              return Card(
                child: ListTile(
                  leading: Text("${_userlistd[index].id}"),
                  title:Text("${_userlistd[index].date}"),
                  subtitle: Text(" Rent ${_userlistd[index].rentprice} "),

                  trailing: GestureDetector(
                    child: Icon(Icons.delete,color: Colors.red,),
                    onTap: () =>_deletealert(_userlistd[index].id, index),
                  ),
                ),

              );

            }),
      ),
    );
  }


  _showdata(int id) async{
    List items = await rentHelper.getUserslist(id);
    items.forEach((item){

      // UserData userd = UserData.map(item);

      setState(() {

        _userlistd.add(RentData.map(item));


      });

      //print("this title :${userd.name}");
      //debugPrint("$user");

    });


  }

  _deletealert(int id, int index) {

    var alert = AlertDialog(
      title: Text('Error Alert delete'),
      content: Text('Error Alert: Are You Sure to delete?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            _delete(id, index);
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],

    );
    showDialog(context: context , builder:(_)=> alert);
    //showDialog(context: context , child: alert );
  }

  _delete (int ids, int index) async{

    int id = await rentHelper.deleteUser(ids);

    print("user deleted: $id");

    setState(() {
      _userlistd.removeAt(index);
    });

  }



}
