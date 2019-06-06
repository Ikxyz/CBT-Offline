import 'package:cbt_offline/import.dart';

class UsersProfileClass {
  String firstName,
      lastName,
      email,
      username,
      tel,
      address,
      city,
      state,
      pwd,
      retypePwd,
      country,
      zip,
      passport,
      identification,
      utilityBill,
      uid;
  int time, likes, followers, following, rating;
  double latitude, longitude;
  bool isAdmin, isAgent, isMember, isDev, isVerified, isOrg;
  dynamic online;
  UsersProfileClass(
      {@required this.username,this.email,
      this.address,
      this.uid,
      this.firstName,
      this.lastName,
      this.state,
      this.tel,
      this.retypePwd,
      this.pwd,
      this.isAdmin,
      this.isAgent,
      this.isOrg,
      this.isDev,
      this.isMember,
      this.city,
      this.country,
      this.zip,
      this.passport,
      this.identification,
      this.utilityBill,
      this.time,
      this.rating,
      this.online,
      this.likes,
      this.followers,
      this.following,
      this.isVerified,
      this.latitude,
      this.longitude});

  factory UsersProfileClass.fromJson(Map map) {
    if (map == null) return null;
    return UsersProfileClass(
        firstName: map['firstName'],
        lastName: map['lastName'],
        username: map['username'],
        email: map['email'],
        pwd: map['pwd'],
        retypePwd: map['retypePwd'],
        tel: map['tel'],
        state: map['state'],
        address: map['address'],
        isAdmin: map['isAdmin'],
        isAgent: map['isAgent'],
        isDev: map['isDev'],
        isOrg: map['isOrg'],
        rating: map['rating'],
        isMember: map['isMember'],
        city: map['city'],
        country: map['country'],
        zip: map['zip'],
        passport: map['passport'],
        identification: map['identification'],
        utilityBill: map['utility_bill'],
        uid: map['uid'],
        time: map['time'],
        likes: map['likes'],
        followers: map['followers'],
        following: map['following'],
        latitude: map['latitude'],
        longitude: map['longitude'],
        isVerified: map['isVerified'],
        online: map['online']);
  }

    Map<String, dynamic> toJson() {
      return {
        'firstName': this.firstName,
        'lastName': this.lastName,
        'address': this.address,
        'username': this.username,
        'email': this.email,
        'state': this.state,
        'tel': this.tel,
        'retypePwd': this.retypePwd,
        'pwd': this.pwd,
        'isAdmin': this.isAdmin,
        'isAgent': this.isAgent,
        'isOrg': this.isOrg,
        'isDev': this.isDev,
        'isMember': this.isMember,
        'city': this.city,
        'country': this.country,
        'zip': this.zip,
        'passport': this.passport,
        'identification': this.identification,
        'utilityBill': this.utilityBill,
        'uid': this.uid,
        'time': this.time,
        'rating': this.rating,
        'online': this.online,
        'likes': this.likes,
        'followers': this.followers,
        'following': this.following,
        'isVerified': this.isVerified,
        'latitude': this.latitude,
        'longitude': this.longitude
      };
  }

    String toStr() {
 
    return ''' 

     firstName: ${this.firstName},
        lastName: ${this.lastName},
        username: ${this.username},
        email: ${this.email},
        pwd: ${this.pwd},
        retypePwd: ${this.retypePwd},
        tel: ${this.tel},
        state: ${this.state},
        address: ${this.address},
        isAdmin: ${this.isAdmin},
        isAgent: ${this.isAgent},
        isDev: ${this.isDev},
        isOrg: ${this.isOrg},
        rating: ${this.rating},
        isMember: ${this.isMember},
        city: ${this.city},
        country: ${this.country},
        zip: ${this.zip},
        passport: ${this.passport},
        identification: ${this.identification},
        utilityBill: ${this.utilityBill},
        uid: ${this.uid},
        time: ${this.time},
        likes: ${this.likes},
        followers: ${this.followers},
        following: ${this.following},
        latitude: ${this.latitude},
        longitude: ${this.longitude},
        isVerified: ${this.isVerified},
        online: ${this.online}
               
     ''';
  }
}
