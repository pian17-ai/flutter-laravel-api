import 'package:app/screens/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  bool isLoading=false;

  void login() {
    if(emailController.text=="pian@arch.org" && passwordController.text=="121212") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wrong email or password")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Icon(Icons.shop,
              size: 50,
              color: Colors.cyan,),

              const SizedBox(height: 15,),
              const Text("CRUD FLutter App",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold
                ),
                ),

                const SizedBox(height: 40,),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    icon: Icon(Icons.email)
                  ),
                ),

                const SizedBox(height: 20,),

                TextField(
                  controller: passwordController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    // border: OutlineInputBorder()
                  ),
                ),

                const SizedBox(height: 30,),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: login,
                    child: const Text("Login",
                      style: TextStyle(fontSize: 26),),
                  ),
                )

            ], 
          ),),
        ),
      ),
    );
  }
}