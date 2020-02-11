class RatingModel {
  String _source;
  String _value;

  RatingModel({String source, String value}) {
    this._source = source;
    this._value = value;
  }

  RatingModel.fromJson(Map<String, dynamic> parsedJson) {
    this._source = parsedJson['Source'];
    this._value = parsedJson['Value'];
  }

  String get source => _source;

  String get value => _value;
}