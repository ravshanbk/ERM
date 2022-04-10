
class Result {
    Result({
        this.sellerId,
        this.result,
        this.who,
    });

    String? sellerId;
    List<ResultElement>? result;
    String? who;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        sellerId: json["sellerId"],
        result: List<ResultElement>.from(json["result"].map((x) => ResultElement.fromJson(x))),
        who: json["who"],
    );

    Map<String, dynamic> toJson() => {
        "sellerId": sellerId,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "who": who,
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
