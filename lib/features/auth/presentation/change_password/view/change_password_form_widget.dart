import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/utils/validation/form_validator.dart';
import 'package:super_fitness/features/auth/presentation/change_password/view_model/change_password_intents.dart';
import 'package:super_fitness/features/auth/presentation/change_password/view_model/change_password_state.dart';
import 'package:super_fitness/features/auth/presentation/change_password/view_model/change_password_view_model.dart';

class ChangePasswordFormWidget extends StatefulWidget {
  const ChangePasswordFormWidget({super.key});

  @override
  State<ChangePasswordFormWidget> createState() =>
      _ChangePasswordFormWidgetState();
}

class _ChangePasswordFormWidgetState extends State<ChangePasswordFormWidget> {
  bool isCurrentPasswordShown = false;
  bool isNewPasswordShown = false;
  bool isNewPasswordConfirmationShown = false;
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController newPasswordConfirmationController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    _initTextEditingControllers();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _disposeTextEditingControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildPasswordField(
          labelKey: 'current_password'.tr(),
          hintKey: 'enter_current_password'.tr(),
          controller: currentPasswordController,
          isShown: isCurrentPasswordShown,
          onToggle: () =>
              setState(() => isCurrentPasswordShown = !isCurrentPasswordShown),
        ),
        const SizedBox(height: 16),
        _buildPasswordField(
          labelKey: 'new_password'.tr(),
          hintKey: 'enter_new_password'.tr(),
          controller: newPasswordController,
          isShown: isNewPasswordShown,
          onToggle: () =>
              setState(() => isNewPasswordShown = !isNewPasswordShown),
        ),
        const SizedBox(height: 16),
        _buildPasswordField(
          labelKey: 'confirm_new_password'.tr(),
          hintKey: 'confirm_your_new_password'.tr(),
          controller: newPasswordConfirmationController,
          isShown: isNewPasswordConfirmationShown,
          onToggle: () => setState(
            () => isNewPasswordConfirmationShown =
                !isNewPasswordConfirmationShown,
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<ChangePasswordViewModel, ChangePasswordState>(
          builder: (context, state) {
            return state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<ChangePasswordViewModel>().doIntent(
                          ChangePasswordButtonClick(
                            currentPassword: currentPasswordController.text,
                            newPassword: newPasswordController.text,
                          ),
                        );
                      }
                    },
                    child: Text('register'.tr()),
                  );
          },
        ),
      ],
    ),
  );

  void _initTextEditingControllers() {
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    newPasswordConfirmationController = TextEditingController();
  }

  void _disposeTextEditingControllers() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    newPasswordConfirmationController.dispose();
  }

  Widget _buildPasswordField({
    required String labelKey,
    required String hintKey,
    required TextEditingController controller,
    required bool isShown,
    required VoidCallback onToggle,
  }) => TextFormField(
    decoration: InputDecoration(
      labelText: labelKey.tr(),
      hintText: hintKey.tr(),
      prefixIcon: const Icon(Icons.lock_outline_rounded),
      suffixIcon: IconButton(
        onPressed: onToggle,
        icon: Icon(
          isShown ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        ),
      ),
    ),
    validator: (value) => FormValidators.password(value),
    keyboardType: TextInputType.visiblePassword,
    obscureText: !isShown,
    controller: controller,
  );
}
