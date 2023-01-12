

class QuoteModel {
  final String ? content;
  final String ? author;

  QuoteModel({
    this.content,
    this.author,
  });

  factory QuoteModel.formJson(dynamic json){
    if(json==null){
      return QuoteModel();
    }

    return QuoteModel(
      content: json["content"],
      author: json["author"],
    );
  }
}