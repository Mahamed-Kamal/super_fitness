import 'package:flutter/material.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/features/explore/domain/entities/explore_section.dart';

abstract class ExploreSectionFactory<T extends ExploreSection> {
  Widget buildUI(BaseState<T> data) {
    switch (data.requestState) {
      case RequestState.init:
      case RequestState.loading:
        return buildLoadingUI(data);
      case RequestState.loaded:
        return buildSuccessUI(data);
      case RequestState.error:
        return buildErrorUI(data);
    }
  }

  Widget buildSuccessUI(BaseState<T> data);
  Widget buildLoadingUI(BaseState<T> data);
  Widget buildErrorUI(BaseState<T> data);
}
