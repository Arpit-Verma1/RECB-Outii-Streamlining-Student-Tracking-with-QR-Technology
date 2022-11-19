import 'package:google_sign_in/google_sign_in.dart';
class Googleauthapi{
  static final _googlesignin=GoogleSignIn(scopes: ['https://mail.google.com/']);
  static Future<GoogleSignInAccount?>signIn()async{
    if(await _googlesignin.isSignedIn()){
      return _googlesignin.currentUser;
    }else{
    return await _googlesignin.signIn();}

  }
  static Future signOut()=>_googlesignin.signOut();
}