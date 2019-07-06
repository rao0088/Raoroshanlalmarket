import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:raoroshanlalmarket/database/MeterData.dart';
import 'package:raoroshanlalmarket/database/MeterHelper.dart';

class MeterDetails extends StatefulWidget {
  final int id;
  MeterDetails({Key key, this.id}): super(key : key);
  @override
  _MeterDetailsState createState() => _MeterDetailsState();
}

class _MeterDetailsState extends State<MeterDetails> {
  Meterhelper   meterdbhelper = Meterhelper();
  final List <MeterData> _userlistd =<MeterData>[];

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
                  onTap: (){
                    _meaterDatas(_userlistd[index].monthyear,_userlistd[index].shopid);
                  },
                  subtitle: Text("Meter Reading : ${_userlistd[index].meterreading} "),

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
    List items = await meterdbhelper.getUserslist(id);
    items.forEach((item){

      // UserData userd = UserData.map(item);

      setState(() {

        _userlistd.add(MeterData.map(item));


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

    int id = await meterdbhelper.deleteUser(ids);

    print("user deleted: $id");

    setState(() {
      _userlistd.removeAt(index);
    });

  }

  _meaterDatas(String months,int shopid) async {
    MeterData map = await meterdbhelper.getMeterData(shopid,months);
    Uint8List _bytesImage;
    print(map.monthyear);
    print(map.date);
    _bytesImage = Base64Decoder().convert(map.meterimage);



    var alert = AlertDialog(
      title: Text(' Meters Month Details'),
      content:ListView(
        children: <Widget>[
          Card(child:ListTile(title: Text('${map.date}'),leading: Icon(Icons.date_range,color:Colors.lightBlue,),),),
          Card(
            child: _bytesImage == null
                ? new Text('No image value.')
                :  Image.memory(_bytesImage,width: 300.0,height: 350.0,fit: BoxFit.fill,),
          ),

        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            //_delete(id, index);
            Navigator.pop(context);
          },
        ),
      ],

    );
    showDialog(context: context , builder:(_)=> alert);
    //showDialog(context: context , child: alert );
  }




}


