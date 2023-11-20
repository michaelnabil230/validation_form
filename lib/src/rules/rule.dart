import 'package:validation_form/src/classes/default_validation_messages.dart';
import 'package:validation_form/src/types/index.dart';

export 'package:validation_form/src/classes/validation_names.dart';
export 'package:validation_form/src/classes/default_validation_messages.dart';

abstract class Rule {
  Rule();

  late String attribute;

  ValidationMessage? customValidationMessage;

  void initialization(String attribute) => this.attribute = attribute;

  bool isValid(String value);

  String get name;

  List get parameters => [];

  String get error {
    return customValidationMessage == null
        ? defaultValidationMessages[name]!.call(attribute, parameters)
        : customValidationMessage!.call(attribute, parameters);
  }
}