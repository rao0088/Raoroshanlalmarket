//import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:raoroshanlalmarket/database/MeterHelper.dart';
import 'package:raoroshanlalmarket/database/RentHelper.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:raoroshanlalmarket/database/UserData.dart';
import 'package:raoroshanlalmarket/database/RentData.dart';
import 'package:raoroshanlalmarket/database/DataHelper.dart';
import 'package:raoroshanlalmarket/pages/MeterDetails.dart';
import 'package:raoroshanlalmarket/pages/MeterReading.dart';
import 'package:raoroshanlalmarket/database/MeterData.dart';
import 'package:raoroshanlalmarket/pages/Rentdetails.dart';

class ViewPageInformation extends StatefulWidget  {
  final int id;
  ViewPageInformation({Key key, this.id}): super(key : key);
  @override
  _ViewPageInformationState createState() => _ViewPageInformationState();
}

class _ViewPageInformationState extends State<ViewPageInformation> {
  //int ids;
  String monthyear = DateFormat('MMMMyyyy').format(DateTime.now());
  Databasehelper dbhelper = Databasehelper();
  Meterhelper  meterdbhelper = Meterhelper();
  RentHelper  rentHelper = RentHelper();
  int shopid;
  String shopname;
  String ownername;
  String address;
  String phoneno;
  Uint8List _bytesImage;
  Uint8List _bytesImageowner;
  String dateverify;
  String dateverifyrent;


  @override
  void initState() {
    super.initState();
    showdataview(widget.id);
    showmeterview(widget.id,monthyear);
    showrentview(widget.id, monthyear);

  }
  //_bytesImageadd = Base64Decoder().convert(map.addimage);
  //_bytesImageowner = Base64Decoder().convert(map.ownerimage);

  @override
  Widget build(BuildContext context) {
    //ids=widget.id;
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Card(child:ListTile(title: Text('$shopname'),leading: Icon(Icons.shop,color:Colors.lightBlue,),),),
            Card(child:ListTile( title: Text('$ownername'),leading: Icon(Icons.account_box,color:Colors.lightBlue,),),),
            Card(child: ListTile( title: Text('$address'),leading: Icon(Icons.note_add,color:Colors.lightBlue,),) ,),
           Card(child: ListTile( title: Text('$phoneno'),leading: Icon(Icons.phone_iphone,color:Colors.lightBlue,),),),


            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:8.0,right:8.0),
                  child: RaisedButton(
                    color:Colors.lightBlue,
                    child: Text('Meter Details'),
                    onPressed: (){
                      var router = MaterialPageRoute(
                          builder: (BuildContext context) => MeterDetails(id : shopid) );
                      Navigator.of(context).push(router);
                    }
                  ),
                ),
                RaisedButton(
                  color:Colors.deepOrangeAccent,
                  child: Text('Rent Details '),
                  onPressed: (){
                    var router = MaterialPageRoute(
                        builder: (BuildContext context) => Rentdetails(id : shopid) );
                    Navigator.of(context).push(router);
                  },
                ),
              ],
            ),


            Row(
              children: <Widget>[
                Card(
                  child:_bytesImage == null
                      ? new Text('No image value.')
                      :  Image.memory(_bytesImage,width: 160.0,height: 200.0,fit: BoxFit.fill,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0,right: 8.0),
                  child: Card(
                    child:_bytesImageowner == null
                        ? new Text('No image value.')
                        :  Image.memory(_bytesImageowner,width: 160.0,height: 200.0, fit: BoxFit.fill,),
                  ),
                ),
              ],
            ),

            dateverify == monthyear
                ? ListTile(title: Text('Meter Reading Already taken'),):  RaisedButton(
                color:Colors.lightBlue,
              child: Text('Meter Reading'),
              onPressed: (){

                var router = MaterialPageRoute(
                    builder: (BuildContext context) => MeterReading(id : shopid) );
                Navigator.of(context).push(router);
              },
            ),

              dateverifyrent== monthyear
              ?ListTile(title: Text('Rent Already taken'),):
              RaisedButton(
               color:Colors.deepOrangeAccent,
                child: Text('Take Rent '),
                onPressed: (){
                 _rentalert(shopid);
                },
              ),

          ],
        ),
      ),
    );
  }

  showdataview(int id) async {
    UserData map = await dbhelper.getUser(id);
    //_bytesImage = Base64Decoder().convert(map.addimage);
    //_bytesImageowner = Base64Decoder().convert(map.ownerimage);
    setState(() {
      shopid=map.id;
      shopname = map.shopname;
      address = map.address;
      phoneno= map.phoneno;
      ownername = map.ownername;
      _bytesImage = Base64Decoder().convert(map.addimage);
      _bytesImageowner = Base64Decoder().convert(map.ownerimage);

    });

}
  showmeterview(int id, String monthyear) async {
    MeterData map = await meterdbhelper.getMonthYear(id, monthyear);
    if (map.monthyear != null) {
      setState(() {
        dateverify = map.monthyear;
      });
    }else{
      setState(() {
        dateverify ='nothing';
      });
    }
  }

  showrentview(int id, String monthyear) async {
    RentData map = await rentHelper.getMonthYear(id, monthyear);
    if (map.monthyear != null) {
      setState(() {
        dateverifyrent = map.monthyear;
      });
    }else{
      setState(() {
        dateverifyrent ='nothing';
      });
    }
  }

  _rentalert(int id) {

    TextEditingController _rentprice = TextEditingController();

    String formattedYear =
    DateFormat('h:mm a,EEEE d MMMM yyyy').format(DateTime.now());

    var alert = AlertDialog(
      title: Text('Take Rent '),
      content:ListView(
        children: <Widget>[
          Card(child: ListTile(title: Text('$formattedYear'),) ,),
          //Card(child: ListTile(title: Text('$monthyear'),) ,),
          TextField(
            controller: _rentprice,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Rent Money',
              border: OutlineInputBorder(),
            ),
          ),


        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            if(_rentprice.text!=null) {
              _addrenttodatabase(id, _rentprice.text, monthyear, formattedYear);
            }
            else{
              _alert();
            }
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

  void _addrenttodatabase(int id,String rentprice,String monthyear, String formattedYear) async {

    RentData user = RentData(id,monthyear,formattedYear,rentprice);
    int svdata = await rentHelper.saveUser(user);
      print("item saved id: $svdata");
    Navigator.pop(context);


  }

  void _alert() {
    var alert = AlertDialog(
      title: Text('Error Alert'),
      content: Text('Error Alert: Please fill all the feild'),
      actions: <Widget>[
        FlatButton(
          child: Text('ok'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(context: context, builder: (_) => alert);
    //showDialog(context: context , child: alert );
  }

}
