import '../../import.dart';

import '../auth.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  String? errorMessage = "";
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async{
    try{
        await AuthCtrl().signInWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text
        );
    }
    on FirebaseAuthException catch (e){
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async{
    try{
        await AuthCtrl().createUserWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text
        );
    }
    on FirebaseAuthException catch (e){
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(
    String title,
    TextEditingController controller
  ){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Firebase Auth")),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _entryField("email", _controllerEmail),
            _entryField("password", _controllerPassword),
            Text(errorMessage == "" ? "" : "Humm ? $errorMessage"),
            ElevatedButton(
              onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword, 
              child: Text(isLogin ? "Login" : "Register")),
            TextButton(
              onPressed: (){
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(isLogin ? "Register instead" : "Login instead")
            )
          ],
        ),
        )
    );
  }
}