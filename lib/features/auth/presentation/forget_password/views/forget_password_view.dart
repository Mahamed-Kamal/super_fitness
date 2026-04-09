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
import 'package:super_fitness/core/widgets/show_toast.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/view_model/forget_password_view_model.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late StreamSubscription<ForgetPasswordUiIntent> _uiEventSubscription;
  // final viewModel = getIt.get<ForgetPasswordViewModel>();
  @override
  void dispose() {
    // _emailController.dispose();
    _uiEventSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _uiEventSubscription = context
        .read<ForgetPasswordViewModel>()
        .forgetPasswordUiEvent
        .listen((event) {
          switch (event) {
            case ShowToast():
              {
                if (!mounted) return;
                Toast.showToast(context, event.message, isError: event.isError);
              }
            case NavigateToOtpViewIntent():
              {
                if (!mounted) return;

                Navigator.pushNamed(context, AppRoutes.otp);
              }
            case NavigateToResetPasswordViewIntent():
              {
                if (!mounted) return;

                ///Navigator.pushNamed(context, AppRoutes.appSection);
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackdrop(
        image: AssetsManager.authBackground,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
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
                  "Enter Your Email",
                  style: context.appTheme.regular16.copyWith(fontSize: 18),
                ).tr(),
                context.h(15),
                Text(
                  "Forget password",
                  style: context.appTheme.regular16.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
                context.h(25),
                BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
                  listenWhen: (previous, current) =>
                      previous.verifyResetCodeState !=
                      current.verifyResetCodeState,
                  listener: (context, state) {
                    ///
                    if (state.forgotPasswordState?.isLoaded ?? false) {
                      context.read<ForgetPasswordViewModel>().doUiIntent(
                        NavigateToOtpViewIntent(),
                      );
                    } else if (state.forgotPasswordState?.isError ?? false) {
                      context.read<ForgetPasswordViewModel>().doUiIntent(
                        ShowToast(
                          message: state.forgotPasswordState!.errorMessage!,
                          isError: true,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading =
                        state.forgotPasswordState?.isLoading ?? false;

                    return GlassContainer(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            validator: FormValidators.email,
                            decoration: InputDecoration(
                              prefix: Icon(Icons.email_outlined),
                              hintText: "Email".tr(),
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
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<ForgetPasswordViewModel>()
                                            .doIntent(
                                              SendResetPasswordCodeIntent(
                                                _emailController.text,
                                              ),
                                            );
                                      }
                                    },

                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: context.appTheme.primary,
                                    )
                                  : Text("Sent OTP").tr(),
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
    );
  }
}
