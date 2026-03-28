class RegisterFormData {
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String rePassword;
  final String gender;
  final int height;
  final int weight;
  final int age;
  final String goal;
  final String activityLevel;

  const RegisterFormData({
    this.firstname = '',
    this.lastname = '',
    this.email = '',
    this.password = '',
    this.rePassword = '',
    this.gender = '',
    this.height = 0,
    this.weight = 0,
    this.age = 0,
    this.goal = '',
    this.activityLevel = '',
  });

  RegisterFormData copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? password,
    String? rePassword,
    String? gender,
    int? height,
    int? weight,
    int? age,
    String? goal,
    String? activityLevel,
  }) => RegisterFormData(
    firstname: firstname ?? this.firstname,
    lastname: lastname ?? this.lastname,
    email: email ?? this.email,
    password: password ?? this.password,
    rePassword: rePassword ?? this.rePassword,
    gender: gender ?? this.gender,
    height: height ?? this.height,
    weight: weight ?? this.weight,
    age: age ?? this.age,
    goal: goal ?? this.goal,
    activityLevel: activityLevel ?? this.activityLevel,
  );
}
