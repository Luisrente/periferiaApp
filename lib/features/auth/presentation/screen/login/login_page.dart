import 'package:periferiamovies/features/auth/domain/usecases/post_login.dart';
import 'package:periferiamovies/features/auth/presentation/blog/login/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:periferiamovies/core/core.dart';
import 'package:periferiamovies/features/auth/presentation/widget/input/custom_text_form_field.dart';
import 'package:periferiamovies/features/features.dart';
import 'package:periferiamovies/utils/enums.dart';
import 'package:periferiamovies/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';


class LoginPage extends StatefulWidget {
 
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  

  final _conDni = TextEditingController();
  final _conPassword = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthBlog, AuthState>(
          listener: (_, state) {
            if (state.status == Status.success) {
              context.dismiss();
              TextInput.finishAutofillContext();
            } else if (state.status == Status.loading) {
              context.show();
            } else if (state.status == Status.error) {
              context.dismiss();
                ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: AutofillGroup(
                  child: Form(
                    key: _keyForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 190,
                            child: Image.asset(
                              'assets/images/ic_logo.png',
                            )
                        ),
                        const Text(
                          "Hola, Bienvenido de nuevo",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.people),
                          controller: _conDni,
                          textInputAction: TextInputAction.next,
                          hint: 'Identificacion',
                          textInputType: TextInputType.number,
                           inputFormatter: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                            ],
                          validation: (String? val) {
                            if (val == null || val.isEmpty) {
                              return 'This field can\'t be empty';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          prefixIcon: const Icon(Icons.key),
                          maxLine: 1,
                          controller: _conPassword,
                          textInputAction: TextInputAction.go,
                          hint: 'Contraseña',
                          isSecureField: true,
                          validation: (String? val) {
                            if (val == null || val.isEmpty) {
                              return 'This field can\'t be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                            },
                            child: const Text(
                              'Olvidaste contraseña?',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_keyForm.currentState?.validate() ?? false) {
                                  context.read<AuthBlog>().add(
                                    LoginEvent(
                                        LoginParams(
                                          identificacion: int.parse(_conDni.text),
                                          clave: _conPassword.text,
                                        ),
                                      ));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  // backgroundColor:
                                  //      ColorsCustom.primary,
                                  side: BorderSide(
                                      color: Colors.grey.withOpacity(0.1))),
                              child: const Text("Iniciar Sesion ")),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'No tienes una cuenta?',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.pushNamed(Routes.register.name);
                                },
                                child: const Text(
                                  'Registrar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
