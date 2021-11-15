import 'package:flutter_test/flutter_test.dart';

class PreguntaFieldValidator {
  static String? validate(String pregunta) {
    if (pregunta.isEmpty) {
      return "La publicación no puede ser vacía";
    } else {
      return null;
    }
  }
}

void main() {
  test("mensaje para pregunta vacia", () {
    var result = PreguntaFieldValidator.validate("");
    expect(result, "La publicación no puede ser vacía");
  });

  test("mensaje para pregunta correcta", () {
    var result = PreguntaFieldValidator.validate(
        "¿Alguien me puede indicar como cultivar café?");
    expect(result, null);
  });
}
