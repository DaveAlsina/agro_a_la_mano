import 'package:flutter_test/flutter_test.dart';

class EmailFieldValidator {
  static String? validate(String email) {
    if (email.isEmpty) {
      return "El correo no puede ser vacío";
    } else {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (!emailValid) {
        return "El texto ingresado no es un correo";
      } else {
        return null;
      }
    }
  }
}

class PasswordFieldValidator {
  static const int MIN_LEN_PWD = 5;

  static String? validate(String value) {
    if (value.isEmpty) {
      return "La contraseña no puede ser vacía";
    } else if (value.length < MIN_LEN_PWD) {
      return "La contraseña debe tener mínimo $MIN_LEN_PWD caracteres";
    } else {
      return null;
    }
  }
}

// EMAIL VALIDATION
void main() {
  test("mensaje para email vacio", () {
    var result = EmailFieldValidator.validate("");
    expect(result, "El correo no puede ser vacío");
  });

  test("mensaje para texto que no tiene forma de correo", () {
    // correo incorrecto
    var result = EmailFieldValidator.validate("juan.ruiz");
    expect(result, "El texto ingresado no es un correo");
  });

  test("validacion de correo correcto", () {
    var result = EmailFieldValidator.validate("juan.ruiz@gmail.com");
    expect(result, null);
  });

// PASSWORD VALIDATION
  test("mensaje para contraseña vacia", () {
    var result = PasswordFieldValidator.validate("");
    expect(result, "La contraseña no puede ser vacía");
  });

  test("mensaje para contraseña corta", () {
    var result = PasswordFieldValidator.validate("123");
    expect(result,
        "La contraseña debe tener mínimo ${PasswordFieldValidator.MIN_LEN_PWD} caracteres");
  });

  test("validacion de contraseña correcta", () {
    var result = PasswordFieldValidator.validate("miContraseña");
    expect(result, null);
  });
}
