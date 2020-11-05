/* https://flutter.dev/docs/development/data-and-backend/json#creating-model-classes-the-json_serializable-way // TODO - Pourquoi ne peut on pas implémenter ça ? */
class Ticket {
  Ticket.fromJson(Map<String, dynamic> json) {
    print(json);
    _id = json['id'] as String;
    _idUser = json['id_user'] as String;
    _dateTakeoff = DateTime.parse(json['date_takeoff'] as String);
    _dateCreation = DateTime.parse(json['date_creation'] as String);
    _massage = json['massage'] as bool;
    _gravityMeal = json['no_gravity_meal'] as bool;
    _gravityPool = json['no_gravity_pool'] as bool;
  }

  String _id;
  String _idUser;
  DateTime _dateTakeoff;
  DateTime _dateCreation;
  bool _massage;
  bool _gravityMeal;
  bool _gravityPool;

  String get id => _id;
  String get idUser => _idUser;
  DateTime get dateTakeoff => _dateTakeoff;
  DateTime get dateCreation => _dateCreation;
  bool get massage => _massage;
  bool get gravityMeal => _gravityMeal;
  bool get gravityPool => _gravityPool;
}