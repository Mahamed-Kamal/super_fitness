import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/extensions/context_spacing_extension.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/core/theme/fonts/my_font_weight.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/utils/validation/form_validator.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/core/widgets/show_toast.dart';
import 'package:super_fitness/core/widgets/super_fitness_app_bar.dart';
import 'package:super_fitness/features/auth/presentation/login/view_model/login_intent.dart';
import 'package:super_fitness/features/auth/presentation/login/view_model/login_view_model.dart';
import 'package:super_fitness/core/widgets/custom_rich_text.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  StreamSubscription<LoginUIEvents>? _uiEventsSubscription;
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    _listenToUIEvents();
    _emailController.addListener(_onChanged);
    _passwordController.addListener(_onChanged);
  }

  void _listenToUIEvents() {
    _uiEventsSubscription = context
        .read<LoginViewModel>()
        .uiEventsStream
        .listen((event) {
          if (!mounted) return;
          switch (event) {
            case LoginViewShowToast():
              Toast.showToast(context, event.message, isError: event.isError);
            case NavigateToRegister():
              Navigator.pushNamed(
                context,
                AppRoutes.registerAndCompleteRegistration,
              );
              break;
            case NavigateToForgetPassword():
              Navigator.pushNamed(context, AppRoutes.forgetPassword);
              break;
            case NavigateToHome():
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              );
          }
        });
  }

  void _onChanged() {
    context.read<LoginViewModel>().doIntent(
      FormChangedIntent(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

  @override
  void dispose() {
    _uiEventsSubscription?.cancel();
    _emailController.removeListener(_onChanged);
    _passwordController.removeListener(_onChanged);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SuperFitnessAppBar(logo: AssetsManager.appLogoSvg),
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: ScreenBackdrop(
        image: AssetsManager.authBackground,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                context.h(60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomRichText(
                    textAlign: TextAlign.start,
                    firstText: "auth.hey_there".tr(),
                    firstStyle: context.appTheme.semiBold18,
                    secondText: "auth.welcome_back".tr(),
                    secondStyle: context.appTheme.medium20.copyWith(
                      fontWeight: MyFontWeight.extraBold,
                    ),
                  ),
                ),
                context.h(8),
                GlassContainer(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "auth.login".tr(),
                          style: context.appTheme.semiBold24.copyWith(
                            color: Colors.white,
                            fontWeight: MyFontWeight.extraBold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        context.h(16),
                        TextFormField(
                          validator: FormValidators.email,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: "auth.email".tr(),
                          ),
                        ),

                        context.h(16),
                        TextFormField(
                          controller: _passwordController,
                          validator: FormValidators.password,
                          obscureText: _isPasswordObscured,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: GestureDetector(
                              onTap: () => setState(
                                () =>
                                    _isPasswordObscured = !_isPasswordObscured,
                              ),
                              child: Icon(
                                _isPasswordObscured
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                            hintText: "auth.password".tr(),
                          ),
                        ),

                        context.h(8),
                        GestureDetector(
                          onTap: () => context.read<LoginViewModel>().doIntent(
                            ForgetPasswordIntent(),
                          ),
                          child: Text(
                            "auth_forget_password?".tr(),
                            textAlign: TextAlign.end,
                            style: context.appTheme.regular14.copyWith(
                              color: context.appTheme.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: context.appTheme.primary,
                            ),
                          ),
                        ),
                        context.h(28),
                        BlocBuilder<LoginViewModel, LoginState>(
                          builder: (context, state) {
                            final isLoading = state.loginState.isLoading;
                            return ElevatedButton(
                              onPressed: state.isButtonEnabled && !isLoading
                                  ? _login
                                  : null,
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text("auth.login".tr()),
                            );
                          },
                        ),

                        context.h(8),
                        CustomRichText(
                          firstText: "auth.don_t_have_an_account_yet".tr(),
                          secondText: "auth.register".tr(),
                          onClickSecond: () => context
                              .read<LoginViewModel>()
                              .doIntent(RegisterIntent()),
                        ),
                      ],
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

  void _login() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<LoginViewModel>().doIntent(
      LoginIntent(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }
}
