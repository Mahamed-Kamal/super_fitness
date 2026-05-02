sealed class MealDetailsIntent {}

class GetMealDetails extends MealDetailsIntent {
  final String id;

  GetMealDetails({required this.id});
}
