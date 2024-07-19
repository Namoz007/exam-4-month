import 'package:exam_4_month/blocs/auth_blocs/auth_bloc_event.dart';
import 'package:exam_4_month/blocs/auth_blocs/auth_bloc_state.dart';
import 'package:exam_4_month/blocs/auth_blocs/auth_block.dart';
import 'package:exam_4_month/data/models/errormessage.dart';
import 'package:exam_4_month/data/models/user.dart';
import 'package:exam_4_month/data/repositories/auth_repositories.dart';
import 'package:exam_4_month/ui/screens/authentification.dart/login_screen.dart';
import 'package:exam_4_month/ui/screens/authentification.dart/login_textfields.dart';
import 'package:exam_4_month/ui/screens/authentification.dart/registration_passwords.dart';
import 'package:exam_4_month/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _firstPasswordController = TextEditingController();
  final _secondPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  String? error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100,),
                const Text("Tadbiro",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 45,),),
                const SizedBox(height: 20,),
                BlocBuilder<AuthBloc,AuthBlocState>(builder: (context,state){
                  if(state is LoadedAuthBlocState && AppUtils.errorMessageStatus[state.message.message] != null){
                    return Center(child: Text("${AppUtils.errorMessageStatus[state.message.message]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.red,),),);
                  }
                  return Container();
                }),
                const SizedBox(height: 30,),
                const Text("Ro'yxatdan o'tish",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
        
                Padding(padding: EdgeInsets.symmetric(horizontal: 30),child: LoginTextfield(controller: _loginController,),),
                const SizedBox(height: 20,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30),child: RegistrationPasswords(firstController: _firstPasswordController,secondController: _secondPasswordController,name: _nameController,),),
                const SizedBox(height: 30,),
        
                InkWell(
                  onTap: () async{
                    if(_formKey.currentState!.validate()){
                      context.read<AuthBloc>().add(CreateUserAuthBlocEvent(user: UserData(id: '', name: _nameController.text, email: _loginController.text, deviceId: '', myFavoriteEvent: []),email: _loginController.text, password: _firstPasswordController.text,),);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 250,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    child:  BlocBuilder<AuthBloc,AuthBlocState>(
                      builder: (context,state){
                        if(state is LoadingAuthBlocState){
                          return const Center(child: CircularProgressIndicator(color: Colors.red,),);
                        }
                        return const Text("Ro'yxatdan o'tish",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),);
                      },
                    )
                  ),
                ),
                InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: const Text("Tizimga kirish",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),))
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}
