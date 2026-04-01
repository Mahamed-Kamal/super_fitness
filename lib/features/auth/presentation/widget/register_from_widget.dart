import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/validation/form_validator.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key, required this.pageController});
  final PageController pageController;

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
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              prefixIcon: Icon(Icons.person_outline_rounded),
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
              prefixIcon: Icon(Icons.person_outline_rounded),
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
              prefixIcon: Icon(Icons.email_outlined),
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
              prefixIcon: Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
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
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                widget.pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
                setState(() {
                  formKey.currentState!.save();
                });
              }
            },
            child: Text('register'.tr()),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'already_have_an_account'.tr(),
                style: context.appTheme.regular16,
              ),
              InkWell(
                onTap: () {},
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
  }
}
