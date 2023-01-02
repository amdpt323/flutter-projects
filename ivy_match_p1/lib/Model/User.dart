class User{
  final String ? name;
  final String ? profession;
  final String ? jobPosition;

  User({
    this.name,
    this.profession,
    this.jobPosition,
  });

  factory User.fromJson(dynamic json){
    if(json==null){
      return User();
    }

    return User(
      name:json["name"],
      profession:json["profession"],
      jobPosition: json["jobPosition"],
    );
  }
}