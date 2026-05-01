import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/view_model/meal_details_intent.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/view_model/meal_details_state.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/meal_detail_body.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/view_model/meal_details_view_model.dart';

class MealDetailsView extends StatefulWidget {
  final String id;

  const MealDetailsView({super.key, required this.id});

  @override
  State<MealDetailsView> createState() => _MealDetailsViewState();
}

class _MealDetailsViewState extends State<MealDetailsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MealDetailsViewModel>().doIntent(
        GetMealDetails(id: widget.id),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MealDetailsViewModel, MealDetailsState>(
        builder: (context, state) {
          return switch (state.requestState) {
            RequestState.init || RequestState.loading => Center(
              child: CircularProgressIndicator(color: context.appTheme.primary),
            ),
            RequestState.error => _ErrorBody(
              message: state.errorMessage ?? 'something_went_wrong'.tr(),
              id: widget.id,
            ),
            RequestState.loaded => MealDetailBody(meal: state.data!),
          };
        },
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  final String message;
  final String id;

  const _ErrorBody({required this.message, required this.id});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: context.appTheme.primary,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => context.read<MealDetailsViewModel>().doIntent(
                GetMealDetails(id: id),
              ),
              child: Text('retry'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
