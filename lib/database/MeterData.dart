class MeterData{
  int _id;
  int _shopid;
  String _monthyear;
  String _date;
  String _meterimage;
  String _meterreading;


  MeterData(this._shopid,this._monthyear,this._date,this._meterimage,this._meterreading);

  MeterData.map(dynamic obj){

    this._id =obj['id'];
    this._shopid=obj['shopid'];
    this._monthyear =obj['monthyear'];
    this._date =obj['date'];
    this._meterimage=obj['meterimage'];
    this._meterreading=obj['meterreading'];
  }

  int get id =>_id;
  int get shopid =>_shopid;
  String get monthyear => _monthyear;
  String get date => _date;
  String get meterimage  =>_meterimage;
  String get meterreading =>_meterreading;

  Map<String, dynamic> toMap(){

    var map = Map<String, dynamic>();

    if(_id!=null){
      map['id']= _id;
    }
    map['shopid']=_shopid;
    map['monthyear'] = _monthyear;
    map['date'] =_date;
    map['meterimage']=_meterimage;
    map['meterreading']=_meterreading;
    return map;
  }

  MeterData.fromMap(Map<String, dynamic>map){
    this._id = map['id'];
    this._shopid= map['shopid'];
    this._monthyear = map['monthyear'];
    this._date = map['date'];
    this._meterimage = map['meterimage'];
    this._meterreading=map['meterreading'];
  }
}