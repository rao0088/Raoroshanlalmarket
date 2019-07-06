class RentData{
  int _id;
  int _shopid;
  String _monthyear;
  String _date;
  String _rentprice;


  RentData(this._shopid,this._monthyear,this._date,this._rentprice);

  RentData.map(dynamic obj){

    this._id =obj['id'];
    this._shopid=obj['shopid'];
    this._monthyear =obj['monthyear'];
    this._date =obj['date'];
    this._rentprice=obj['rentprice'];
  }

  int get id =>_id;
  int get shopid =>_shopid;
  String get monthyear => _monthyear;
  String get date => _date;
  String get rentprice  =>_rentprice;

  Map<String, dynamic> toMap(){

    var map = Map<String, dynamic>();

    if(_id!=null){
      map['id']= _id;
    }
    map['shopid']=_shopid;
    map['monthyear'] = _monthyear;
    map['date'] =_date;
    map['rentprice']=_rentprice;
    return map;
  }

  RentData.fromMap(Map<String, dynamic>map){
    this._id = map['id'];
    this._shopid= map['shopid'];
    this._monthyear = map['monthyear'];
    this._date = map['date'];
    this._rentprice = map['rentprice'];
  }
}