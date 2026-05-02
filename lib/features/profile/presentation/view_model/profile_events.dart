sealed class ProfileEvents {}

sealed class ProfileUiEvents {}

class GetUserDataEvent extends ProfileEvents {}

class OnLanguageClickIntent extends ProfileUiEvents {}

class OnLogoutClickIntent extends ProfileUiEvents {}


