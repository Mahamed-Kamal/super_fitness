sealed class ProfileEvents {}

sealed class ProfileUiEvents {}

class GetUserDataEvent extends ProfileEvents {}

class OnLogoutClickIntent extends ProfileUiEvents {}

class OnLSecurityClickIntent extends ProfileUiEvents {}

class OnPrivacyClickIntent extends ProfileUiEvents {}

class OnHeloClickIntent extends ProfileUiEvents {}

class OnEditProfileClickIntent extends ProfileUiEvents {}
