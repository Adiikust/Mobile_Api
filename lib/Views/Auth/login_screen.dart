



import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_api/Controller/Export/export_screen.dart';
import 'package:http/http.dart' as http;




class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
 final TextEditingController _passwordController = TextEditingController();



  Future logIn(String username,password) async {
    Response response = await http.post(
      Uri.parse('http://58.65.169.108:999/MobileApp/Login'),
      headers: {"Accept": "Application/json"},
      body: {
        'strLoginName': username,
        'strPasswordHash': password,
      },
    );
    if(response.statusCode ==200) {
      var data = jsonDecode(response.body.toString());
      return data;
    }

  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 60),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:   [
            const Text("LogIn",style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold),),
            SizedBox(height: data.size.height * 0.05,),
            const Text("Please login to continue using our app.",style: TextStyle(fontSize: 16),),
            SizedBox(height: data.size.height * 0.05,),
            TextFormField(
              controller: _userNameController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                hintText: "User Name",
                ),
              ),
            SizedBox(height: data.size.height * 0.05,),
            TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                hintText: "Password",
              ),
            ),
            SizedBox(height: data.size.height * 0.05,),
            InkWell(
              onTap: () async {

                 var rep = await logIn(
                      _userNameController.text.toString(),
                      _passwordController.text.toString()
                  );
   Navigator.push(context, MaterialPageRoute(builder: (context) =>  DeliveryScreen(locationId: rep["PersonalID"],location: rep["Location"],personalID: rep["LocationId"],)));


                   },

              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.kButton,
                    borderRadius:BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Text('Login',
                    style: TextStyle(
                        color: AppColors.kWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
          ),
        ),
        ),
      ),
    );
  }
/*  Future<void> logIn() async {
    if(_userNameController.text.isNotEmpty && _passwordController.text.isNotEmpty){
      var response = await http.post(Uri.parse('http://58.65.169.108:999/api/values/Login?'),
          body: ({
            'username':_userNameController.text,
            'password':_passwordController.text,}));

      if(response.statusCode == 200){
       // ignore: use_build_context_synchronously
       Navigator.push(context, MaterialPageRoute(builder: (context) => const   DeliveryScreen()));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Black Filed not Allowed ")));
    }
  }*/
}


