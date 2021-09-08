import 'package:firebase_auth/firebase_auth.dart';

class LogInUtil {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> getVerificationCode(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: _onCodeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    );
  }

  void _onVerificationCompleted(PhoneAuthCredential authCredential) {
    print('LogInUtil._onVerificationCompleted: ${authCredential.smsCode}');
  }

  void _onVerificationFailed(FirebaseAuthException exception) {
    print('LogInUtil._onVerificationFailed: ${exception.message}');
  }

  void _onCodeSent(String phone, int? code) {
    print('LogInUtil._onCodeSent: $phone - $int');
  }

  void _codeAutoRetrievalTimeout(String data) {
    print('LogInUtil._codeAutoRetrievalTimeout: $data');
  }
}
