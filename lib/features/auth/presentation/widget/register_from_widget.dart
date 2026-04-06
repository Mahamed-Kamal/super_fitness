import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/validation/form_validator.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  bool isShowPassword = false;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterViewModel, RegisterState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "register".tr(),
                style: context.appTheme.semiBold24,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'first_name'.tr(),
                  hintText: 'enter_first_name'.tr(),
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                ),
                validator: (value) => FormValidators.firstName(value),
                keyboardType: TextInputType.name,
                controller: firstNameController,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'last_name'.tr(),
                  hintText: 'enter_last_name'.tr(),
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                ),
                validator: (value) => FormValidators.lastName(value),
                keyboardType: TextInputType.name,
                controller: lastNameController,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'email'.tr(),
                  hintText: 'enter_email'.tr(),
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                validator: (value) => FormValidators.email(value),
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'password'.tr(),
                  hintText: 'enter_password'.tr(),
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => isShowPassword = !isShowPassword),
                    icon: isShowPassword
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined),
                  ),
                ),
                validator: (value) => FormValidators.password(value),
                keyboardType: TextInputType.visiblePassword,
                obscureText: !isShowPassword,
                controller: passwordController,
              ),
              const SizedBox(height: 20),

              state.requestState == RequestState.loading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<RegisterViewModel>().doIntent(
                            RegisterButtonClickedIntent(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                            ),
                          );
                        }
                      },
                      child: Text('register'.tr()),
                    ),

              if (state.requestState == RequestState.error &&
                  state.errorMessage != null) ...[
                const SizedBox(height: 8),
                Text(
                  state.errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ],

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'already_have_an_account'.tr(),
                    style: context.appTheme.regular16,
                  ),
                  InkWell(
                    onTap: () => context.read<RegisterViewModel>().doIntent(
                      LoginNavigationButtonClickedIntent(),
                    ),
                    child: Text(
                      'login'.tr(),
                      style: context.appTheme.semiBold16.copyWith(
                        color: context.appTheme.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: context.appTheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
