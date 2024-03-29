import 'package:project_quest/features/auth/dal/repositories/sign_up.repository.dart';
import 'package:project_quest/features/auth/domain/usecases/sign_up.usecase.dart';

import '../../../../../core/abstractions/field.interface.dart';
import '../../../../../core/builders/field_validator.builder.dart';
import '../../../../../core/dal/storage/storage.interface.dart';
import '../../../../../core/inject.dart';
import '../../../../../core/models/react_field.model.dart';
import '../../../../../core/models/text_react_field.model.dart';
import '../../../dal/datasource/auth.datasource.interface.dart';
import '../../../presentation/sign_up/sign_up.controller.dart';
import 'sign_up_controller.interface.dart';

class SignUpControllerBinding {
  static void inject() {
    Inject.injectController<ISignUpController>(makeSignUpController);
  }

  static void dipose() {
    Inject.disposeController<ISignUpController>();
  }
}

ISignUpController makeSignUpController() {
  final storage = Inject.find<IStorage>();
  final authDatasource = Inject.find<IAuthDatasource>();

  final signUpRepository = SignUpRepository(
    authDatasource: authDatasource,
    storage: storage,
  );

  final signUpUsecase = SignUpUsecase(signUpRepository: signUpRepository);

  return SignUpController(
    usernameField: _makeUserNameField(),
    emailField: _makeEmailField(),
    nicknameField: _makeNicknameField(),
    passwordField: _makePasswordField(),
    centralCheckField: _makeCentralCheckField(),
    cashierCheckField: _makeCashierCheckField(),
    deliverymanCheckField: _makeDeliveryCheckField(),
    centralField: _makeCentralField(),
    loading: Inject.find(),
    signUpUsecase: signUpUsecase,
  );
}

IField<String> _makeUserNameField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().build(),
  );
}

IField<String> _makeNicknameField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().build(),
  );
}

IField<String> _makeEmailField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().email().build(),
  );
}

IField<String> _makePasswordField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().password().build(),
  );
}

IField<bool> _makeCentralCheckField() {
  return ReactFieldModel(
    value: true,
    validators: FieldValidatorBuilder<bool>().build(),
  );
}

IField<bool> _makeCashierCheckField() {
  return ReactFieldModel(
    value: false,
    validators: FieldValidatorBuilder<bool>().build(),
  );
}

IField<bool> _makeDeliveryCheckField() {
  return ReactFieldModel(
    value: false,
    validators: FieldValidatorBuilder<bool>().build(),
  );
}

IField<String> _makeCentralField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().build(),
  );
}
