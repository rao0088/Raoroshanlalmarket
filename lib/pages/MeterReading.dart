import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:raoroshanlalmarket/database/MeterData.dart';
import 'package:raoroshanlalmarket/database/MeterHelper.dart';

class MeterReading extends StatefulWidget {
  final int id;
  MeterReading({Key key, this.id}): super(key : key);
  @override
  _MeterReadingState createState() => _MeterReadingState();
}

class _MeterReadingState extends State<MeterReading> {
  Meterhelper   meterdbhelper = Meterhelper();
  TextEditingController _meterreading =TextEditingController();

  String formattedYear =
  DateFormat('h:mm a,EEEE d MMMM yyyy').format(DateTime.now());
  String monthyear =
  DateFormat('MMMMyyyy').format(DateTime.now());


  File _image;
  String base64Image;
  String _images;

  Future getmeterImage() async {
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

  void _saveData(shopid,monthyear,date,meterimage,meterreading) async {

    MeterData muser = MeterData(shopid,monthyear,date,meterimage,meterreading);
    int svdata = await meterdbhelper.saveUser(muser);
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
        title: Text('Meter Reading'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Card(child: ListTile(title: Text('$formattedYear'),) ,),

            ListTile(
              title: TextField(
                controller: _meterreading,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Meter Reading',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            RaisedButton(
              child: Text('Pick Meter Image'),
              color: Colors.lightBlue,
              onPressed: ()=> getmeterImage(),
            ),

            Card(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(
                _image,
                width: 250.0,
                height: 300.0,
                fit: BoxFit.fill,
              ),
            ),
           RaisedButton(
             child: Text('Submit'),
             padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
             color: Colors.deepOrangeAccent ,
             onPressed: (){
               if(_image != null && _meterreading.text!=null){
                 _saveData(widget.id,monthyear,formattedYear,_images,_meterreading.text);

               }else{
                 _alert();
               }
             },
           )
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




