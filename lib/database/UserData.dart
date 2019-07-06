class UserData {
  int _id;
  String _shopname;
  String _ownername;
  String _address;
  String _phoneno;
  String _addimage;
  String _ownerimage;

  UserData(this._shopname,this._ownername,this._address,this._phoneno,this._addimage,this._ownerimage);

  UserData.map(dynamic obj){

    this._id =obj['id'];
    this._shopname =obj['shopname'];
    this._ownername =obj['ownername'];
    this._address=obj['address'];
    this._phoneno=obj['phoneno'];
    this._addimage=obj['addimage'];
    this._ownerimage=obj['ownerimage'];

  }

  int get id =>_id;
  String get shopname => _shopname;
  String get ownername => _ownername;
  String get address  =>_address;
  String get phoneno => _phoneno;
  String get addimage => _addimage;
  String get ownerimage => _ownerimage;

  Map<String, dynamic> toMap(){

    var map = Map<String, dynamic>();

    if(_id!=null){
      map['id']= _id;
    }
    map['shopname'] = _shopname;
    map['ownername'] = _ownername;
    map['address'] =_address;
    map['phoneno']=_phoneno;
    map['addimage']=_addimage;
    map['ownerimage']=_ownerimage;

    return map;
  }

  UserData.fromMap(Map<String, dynamic>map){

    this._id =map['id'];
    this._shopname=map['shopname'];
    this._ownername=map['ownername'];
    this._address=map['address'];
    this._phoneno=map['phoneno'];
    this._addimage=map['addimage'];
    this._ownerimage=map['ownerimage'];
  }

}