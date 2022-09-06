
import 'package:mobile_api/Controller/Export/export_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
TextEditingController _userNameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
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
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DeliveryScreen()));
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
}
