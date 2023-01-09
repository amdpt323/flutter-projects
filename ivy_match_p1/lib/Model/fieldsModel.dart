class Fields {
  final String ? name;
  final String ? type;
  final List<String?>? enums;

  Fields({
    this.name,
    this.type,
    this.enums,
});

  factory Fields.fromJson(dynamic json){
    if(json==null){
      return Fields();
    }

    return Fields(
      name:json["name"],
      type: json["type"],

    );
  }
}

