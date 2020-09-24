import 'package:equatable/equatable.dart';

abstract class Mappable {
  Map<String, dynamic> toMap();
}

abstract class JSONModel extends Equatable implements Mappable {
  final String value;

  const JSONModel(this.value);

  @override
  List<Object> get props => [value];
}
