import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:super_fitness/core/extensions/context_spacing_extension.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/custom_image_view.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/view_model/forget_password_view_model.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  String otp = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackdrop(
        image: AssetsManager.authBackground,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                "OTP CODE",
                style: context.appTheme.regular16.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              context.h(15),
              Text(
                "Enter Your OTP Check your email",
                style: context.appTheme.regular16.copyWith(fontSize: 18),
              ).tr(),

              context.h(25),
              BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
                listener: (context, state) {
                  if (state.verifyResetCodeState?.isLoaded ?? false) {
                    context.read<ForgetPasswordViewModel>().doUiIntent(
                      NavigateToResetPasswordViewIntent(),
                    );
                  } else if (state.verifyResetCodeState?.isError ?? false) {
                    context.read<ForgetPasswordViewModel>().doUiIntent(
                      ShowToast(
                        message: state.verifyResetCodeState!.errorMessage!,
                        isError: true,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading =
                      state.verifyResetCodeState?.isLoading ?? false;
                  final isResendEnabled = state.resendRemainingSeconds == 0;

                  return GlassContainer(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    child: Column(
                      children: [
                        PinCodeTextField(
                          appContext: context,
                          length: 7,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          enableActiveFill: true,
                          onCompleted: (code) {
                            otp = code;
                          },
                          onChanged: (value) {},
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeColor: context.appTheme.primary,
                            selectedColor: Colors.transparent,
                            inactiveColor: Colors.white,
                            activeFillColor: Colors.transparent,
                            selectedFillColor: Colors.transparent,
                            inactiveFillColor: Colors.transparent,
                          ),
                          cursorColor: context.appTheme.primary,
                          enablePinAutofill: true,

                          textStyle: TextStyle(
                            color: context.appTheme.primary,
                            fontWeight: FontWeight.bold,
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
                                    context
                                        .read<ForgetPasswordViewModel>()
                                        .doIntent(VerifyResetCodeIntent(otp));
                                  },

                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text("Confirm").tr(),
                          ),
                        ),
                        context.h(15),
                        Text(
                          "didnt recieve verification code?",
                          style: context.appTheme.regular16.copyWith(
                            fontSize: 18,
                          ),
                        ).tr(),
                        InkWell(
                          onTap: isResendEnabled
                              ? () {
                                  context
                                      .read<ForgetPasswordViewModel>()
                                      .doIntent(ResendOtpIntent());
                                }
                              : null,
                          child: Text(
                            isResendEnabled
                                ? "Resend Code?"
                                : "Resend in ${state.resendRemainingSeconds}s",
                            style: context.appTheme.regular16.copyWith(
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: isResendEnabled
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
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
    );
  }
}
