import 'package:feliz_coin/models/resend_response_model.dart';
import 'package:feliz_coin/screens/auth_screen/confirm_code_screen/blocs/resend_code/resend_provider.dart';

class ResendCodeRepository {
  Future<ResendResponseModel> resendCode({
    required String email,
  }) {
    ResendCodeProvider provider = ResendCodeProvider();
    return provider.resendCode(email: email);
  }
}
