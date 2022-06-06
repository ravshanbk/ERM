class Result {
  Result({
    this.when,
    this.result,
    this.who,
    this.id,
    this.v,
  });

int? when;
  List<ResultElement>? result;
  String? who;
  String? id;
  int? v;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        when: json["when"],
        result: List<ResultElement>.from(
            json["result"].map((x) => ResultElement.fromJson(x))),
        who: json["who"],
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "when": when,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "who": who,
        "_id": id,
        "__v": v,
      };
}

class ResultElement {
  ResultElement({
    this.context,
    this.done,
    this.letter,
  });

  String? context;
  bool? done;
  String? letter;

  factory ResultElement.fromJson(Map<String, dynamic> json) => ResultElement(
        context: json["context"],
        done: json["done"],
        letter: json["letter"],
      );

  Map<String, dynamic> toJson() => {
        "context": context,
        "done": done,
        "letter": letter,
      };
}
