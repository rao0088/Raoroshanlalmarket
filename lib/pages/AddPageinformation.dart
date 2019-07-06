import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
//import 'package:intl/intl.dart';
import 'package:raoroshanlalmarket/database/UserData.dart';
import 'package:raoroshanlalmarket/database/DataHelper.dart';

class AddPageinformation extends StatefulWidget {
  @override
  _AddPageinformationState createState() => _AddPageinformationState();
}

class _AddPageinformationState extends State<AddPageinformation> {

  Databasehelper dbhelper = Databasehelper();
  TextEditingController _shopname = TextEditingController();
  TextEditingController _ownername = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phoneno = TextEditingController();

  File _image;
  String base64Image;
  String _images;

  File _image1;
  String base64Image1;
  String _images1;

  Future getaddImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 300.0, maxHeight: 350);
    //List<int> image2 = await image.readAsBytes();
    List<int> imageBytes1 = image.readAsBytesSync();
    print(imageBytes1);
    base64Image = base64Encode(imageBytes1);
    //print('string is');
    //print(base64Image);
    //print("You selected gallery image : " + image.path);

    //_bytesImage = Base64Decoder().convert(base64Image);

    if (image != null) {
      setState(() {
        _image = image;
        _images = base64Image;
        //print("$image");
      });
    }
  }
  Future getownerImage() async {
    var image1 = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 300.0, maxHeight: 350);
    //List<int> image2 = await image.readAsBytes();
    List<int> imageBytes = image1.readAsBytesSync();
    print(imageBytes);
    //base64Image1 = base64Encode(imageBytes);
    base64Image1 = base64Encode(imageBytes);
    //_base64 = BASE64.encode(response.bodyBytes);

    //print('string is');
    //print(base64Image);
    //print("You selected gallery image : " + image.path);

    //_bytesImage = Base64Decoder().convert(base64Image);

    if (image1 != null) {
      setState(() {
        _image1 = image1;
        _images1 = base64Image1;
        //print("$image");
      });
    }
  }


  void _saveData(shopname,ownername, address, phoneno,addimage,ownerimage) async {
    _shopname.clear();
    _address.clear();
    _ownername.clear();
    _phoneno.clear();
    UserData user = UserData(shopname, ownername,address,phoneno,addimage,ownerimage);
    int svdata = await dbhelper.saveUser(user);
//    UserData svdatas = await dbhelper.getUser(svdata);

    //UserData svdatas = await dbhelper.getUser(svdata);

    //print("item saved id: $svdata");

    print("item saved id: $svdata");
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // leading: Icon(Icons.supervised_user_circle),
        title: Text('User Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
              child: TextField(
                controller: _shopname,
                decoration: InputDecoration(
                  labelText: 'Shop Name',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
            ),

            TextField(
              controller: _ownername,
              decoration: InputDecoration(
                labelText: 'Owner Name',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),

            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: TextField(
                controller: _address,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
            ),

            TextField(
              controller: _phoneno,
              decoration: InputDecoration(
                labelText: 'Phone No',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                children: <Widget>[
                  RaisedButton(
                color: Colors.lightBlue,
                    child: Text('Owner Photo '),
                    onPressed: (){
                      //debugPrint('Owner Photo');
                      getownerImage();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: RaisedButton(
                      color: Colors.deepOrangeAccent,
                      child: Text('Address Proof'),
                      onPressed: (){
                        getaddImage();
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(children: <Widget>[
                Card(
                  child: _image1 == null
                      ? Text('No image selected.')
                      : Image.file(
                    _image1,
                    width: 150.0,
                    height: 200.0,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                child:Card(
                  child: _image == null
                      ? Text('No image selected.')
                      : Image.file(
                    _image,
                    width: 150.0,
                    height: 200.0,
                    fit: BoxFit.fill,
                  ),
                ),
                ),
              ],),
            ),
            RaisedButton(
              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
              color: Colors.lightBlue,
              child: Text('Submit'),
              onPressed: (){
                if (_shopname.text != null && _ownername != null && _address != null &&_phoneno!=null &&_image!=null && _image1 != null) {
                  _saveData(_shopname.text,_ownername.text, _address.text,_phoneno.text, _images,_images1);
                  //print('scusses');
                } else {
                  _alert();
                }
              },
            ),
          ],
        ),
      ),
    );
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

