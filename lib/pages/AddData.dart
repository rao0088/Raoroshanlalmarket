import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'dart:convert';
//import 'dart:typed_data';
import 'package:raoroshanlalmarket/pages/AddPageinformation.dart';
import 'package:raoroshanlalmarket/database/UserData.dart';
import 'package:raoroshanlalmarket/database/DataHelper.dart';
import 'package:raoroshanlalmarket/pages/Viewinformation.dart';
class AddData extends StatefulWidget {
  final String passd;
  AddData({Key key, this.passd}): super(key : key);
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  Databasehelper dbhelper = Databasehelper();
  final List <UserData> _userlistd =<UserData>[];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _showdata();

  }

  Future<void> refresh() {
    // dummy code
    _userlistd.clear();
    _showdata();
    return Future.value();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Information'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          var router =MaterialPageRoute(
              builder: (BuildContext context) => AddPageinformation() );
          Navigator.of(context).push(router);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refresh,
        child: ListView.builder(
            padding:  const EdgeInsets.all(8.0),
            reverse: false,
            itemCount: _userlistd.length,
            itemBuilder: (_,int index){

              return Card(
                child: ListTile(
                  leading: Text("${_userlistd[index].id}"),
                  title:Text("Shop Name: ${_userlistd[index].shopname}"),
                  onTap: (){

                    var router = MaterialPageRoute(
                        builder: (BuildContext context) => ViewPageInformation(id : _userlistd[index].id) );
                    Navigator.of(context).push(router);

                  },
                  subtitle: Text("Owner name: ${_userlistd[index].ownername}"),

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
  _showdata() async{
    List items = await dbhelper.gettwoUsers();
    items.forEach((item){

      // UserData userd = UserData.map(item);

      setState(() {

        _userlistd.add(UserData.map(item));


      });

      //print("this title :${userd.name}");
      //debugPrint("$user");

    });


  }

  _delete (int ids, int index) async{

    int id = await dbhelper.deleteUser(ids);

    print("user deleted: $id");

    setState(() {
      _userlistd.removeAt(index);
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


}

