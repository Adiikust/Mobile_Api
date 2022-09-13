import 'dart:convert';
/// PersonalID : 179.0
/// UserFullName : "test  user"
/// Role : "BOClerk"
/// Location : "Postmall Islamabad"
/// UserID : 10.0
/// ShiftID : 1
/// strLoginName : "testu1"
/// strPasswordHash : "testpass"
/// LocationId : 3617.0

LoginMode loginModeFromJson(String str) => LoginMode.fromJson(json.decode(str));
String loginModeToJson(LoginMode data) => json.encode(data.toJson());
class LoginMode {
  LoginMode({
      num? personalID, 
      String? userFullName, 
      String? role, 
      String? location, 
      num? userID, 
      num? shiftID, 
      String? strLoginName, 
      String? strPasswordHash, 
      num? locationId,}){
    _personalID = personalID;
    _userFullName = userFullName;
    _role = role;
    _location = location;
    _userID = userID;
    _shiftID = shiftID;
    _strLoginName = strLoginName;
    _strPasswordHash = strPasswordHash;
    _locationId = locationId;
}

  LoginMode.fromJson(dynamic json) {
    _personalID = json['PersonalID'];
    _userFullName = json['UserFullName'];
    _role = json['Role'];
    _location = json['Location'];
    _userID = json['UserID'];
    _shiftID = json['ShiftID'];
    _strLoginName = json['strLoginName'];
    _strPasswordHash = json['strPasswordHash'];
    _locationId = json['LocationId'];
  }
  num? _personalID;
  String? _userFullName;
  String? _role;
  String? _location;
  num? _userID;
  num? _shiftID;
  String? _strLoginName;
  String? _strPasswordHash;
  num? _locationId;
LoginMode copyWith({  num? personalID,
  String? userFullName,
  String? role,
  String? location,
  num? userID,
  num? shiftID,
  String? strLoginName,
  String? strPasswordHash,
  num? locationId,
}) => LoginMode(  personalID: personalID ?? _personalID,
  userFullName: userFullName ?? _userFullName,
  role: role ?? _role,
  location: location ?? _location,
  userID: userID ?? _userID,
  shiftID: shiftID ?? _shiftID,
  strLoginName: strLoginName ?? _strLoginName,
  strPasswordHash: strPasswordHash ?? _strPasswordHash,
  locationId: locationId ?? _locationId,
);
  num? get personalID => _personalID;
  String? get userFullName => _userFullName;
  String? get role => _role;
  String? get location => _location;
  num? get userID => _userID;
  num? get shiftID => _shiftID;
  String? get strLoginName => _strLoginName;
  String? get strPasswordHash => _strPasswordHash;
  num? get locationId => _locationId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PersonalID'] = _personalID;
    map['UserFullName'] = _userFullName;
    map['Role'] = _role;
    map['Location'] = _location;
    map['UserID'] = _userID;
    map['ShiftID'] = _shiftID;
    map['strLoginName'] = _strLoginName;
    map['strPasswordHash'] = _strPasswordHash;
    map['LocationId'] = _locationId;
    return map;
  }

}