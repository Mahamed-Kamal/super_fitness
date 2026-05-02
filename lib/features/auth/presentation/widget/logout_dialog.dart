import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/core/widgets/show_toast.dart';
import 'package:super_fitness/features/auth/presentation/logout/logout_events.dart';
import 'package:super_fitness/features/auth/presentation/logout/logout_state.dart';
import 'package:super_fitness/features/auth/presentation/logout/logout_view_model.dart';

class LogOuDialog extends StatefulWidget {
  const LogOuDialog({super.key});

  @override
  State<LogOuDialog> createState() => _LogOuDialogState();
}

class _LogOuDialogState extends State<LogOuDialog> {
  LogoutCubit logoutCubit = getIt<LogoutCubit>();

  @override
  void initState() {
    super.initState();
    logoutCubit.logoutUiEvent.listen((event) {
      if (!mounted) return;
      switch (event) {
        case ShowToast():
          {
            Toast.showToast(context, event.message, isError: event.isError);
          }

        case NavigateToLogin():
          {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          }

        case NavigatePop():
          {
            Navigator.pop(context);
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocProvider<LogoutCubit>(
        create: (context) => logoutCubit,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("logout".tr(), style: context.appTheme.semiBold18),

            const SizedBox(height: 12),

            Text("confirm_logout!!".tr(), style: context.appTheme.medium16),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      logoutCubit.doEvent(NavigatePop());
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: context.appTheme.neutral),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "cancel".tr(),
                      style: context.appTheme.medium16,
                    ).tr(),
                  ),
                ),

                const SizedBox(width: 12),

                BlocListener<LogoutCubit, LogoutStates>(
                  listener: (context, state) {
                    final logoutState = state.logoutState;
                    if (logoutState == null) {
                      return;
                    } else if (logoutState.errorMessage != null) {
                      logoutState.isError == true;
                      logoutCubit.doEvent(
                        ShowToast(
                          message: logoutState.errorMessage!,
                          isError: logoutState.isError,
                        ),
                      );
                    } else if (logoutState.data != null) {
                      logoutState.isError == false;

                      logoutCubit.doEvent(
                        ShowToast(
                          message: "logout_success".tr(),
                          isError: logoutState.isError,
                        ),
                      );
                      logoutCubit.doEvent(NavigateToLogin());
                    }
                  },

                  child: Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        logoutCubit.doIntent(LogoutEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.appTheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                      ),
                      child: Text(
                        "logout".tr(),
                        style: context.appTheme.medium16.copyWith(
                          color: context.appTheme.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
