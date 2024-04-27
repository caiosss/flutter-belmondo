import 'package:aplicacao_mobile/components/dialog_box.dart';
import 'package:aplicacao_mobile/data/Validador.dart';

class Usuario implements Validador {
  String email;
  String password;

  Usuario(this.email, this.password);

  @override
  void validarEmail() {
    if (!email.contains("@")) {
      DialogBox("Email inválido!");
    }
  }

  @override
  void validarSenha() {
    if (password.length > 8) {
      DialogBox("Sua senha é maior que 8 caracteres!");
    }
  }
}
