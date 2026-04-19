import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/extensions/context_spacing_extension.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/utils/validation/form_validator.dart';
import 'package:super_fitness/core/widgets/custom_image_view.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/view_model/forget_password_view_model.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late StreamSubscription<ForgetPasswordUiIntent> _uiEventSubscription;
  bool _isObscure2 = true;
  bool _isObscure = true;
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _uiEventSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _uiEventSubscription = context
        .read<ForgetPasswordViewModel>()
        .forgetPasswordUiEvent
        .listen((intent) {
          if (intent is NavigateToLoginViewIntent) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackdrop(
        image: AssetsManager.authBackground,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CustomImageView(
                        imagePath: AssetsManager.appLogoSvg,
                        fit: BoxFit.cover,
                        width: 70,
                        height: 48,
                      ),
                    ),
                    Text(
                      "make sure its 8 characters or more",
                      style: context.appTheme.regular16.copyWith(fontSize: 18),
                    ).tr(),
                    context.h(15),
                    Text(
                      "create new password",
                      style: context.appTheme.regular16.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                    context.h(25),
                    BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
                      listenWhen: (previous, current) =>
                          previous.resetPasswordState !=
                          current.resetPasswordState,
                      listener: (context, state) {
                        ///
                        if (state.resetPasswordState?.isLoaded ?? false) {
                          context.read<ForgetPasswordViewModel>().doUiIntent(
                            NavigateToLoginViewIntent(),
                          );
                          context.read<ForgetPasswordViewModel>().doUiIntent(
                            ShowToast(
                              message: "Password reset successfully",
                              isError: false,
                            ),
                          );
                        } else if (state.resetPasswordState?.isError ?? false) {
                          context.read<ForgetPasswordViewModel>().doUiIntent(
                            ShowToast(
                              message: state.resetPasswordState!.errorMessage!,
                              isError: true,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        final isLoading =
                            state.resetPasswordState?.isLoading ?? false;

                        return GlassContainer(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _passwordController,
                                validator: FormValidators.password,
                                obscureText: _isObscure,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: "Password".tr(),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              context.h(15),
                              TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: _isObscure2,

                                validator: (value) =>
                                    FormValidators.confirmPassword(
                                      value,
                                      _passwordController.text,
                                    ),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure2
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure2 = !_isObscure2;
                                      });
                                    },
                                  ),
                                  hintText: "Password".tr(),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                              context.h(15),
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: isLoading
                                        ? Colors.grey
                                        : context.appTheme.primary,
                                  ),
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          if (_formKey.currentState!
                                                  .validate() &&
                                              _passwordController.text ==
                                                  _confirmPasswordController
                                                      .text) {
                                            context
                                                .read<ForgetPasswordViewModel>()
                                                .doIntent(
                                                  ResetPasswordIntent(
                                                    state.email ?? "",
                                                    _confirmPasswordController
                                                        .text,
                                                  ),
                                                );
                                          }
                                        },

                                  child: isLoading
                                      ? CircularProgressIndicator(
                                          color: context.appTheme.primary,
                                        )
                                      : Text("Done").tr(),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
