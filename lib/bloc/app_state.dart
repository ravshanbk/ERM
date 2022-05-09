import 'package:roxcrm/app_error.dart';
import 'package:roxcrm/models/employee_model.dart';
import 'package:roxcrm/models/user/user_model.dart';

abstract class AppState {
  final bool isLoading;
  final AuthError? authError;
 const  AppState({
    required this.isLoading,
    this.authError,
  });
}

class AppStateLoggedIn extends AppState {
  final User user;
  final Iterable<Employee> employees;

  AppStateLoggedIn({
    required bool isLoading,
    required this.user,
    required this.employees,
    AuthError? authError,
  }) : super(
    
          isLoading: isLoading,
          authError: authError,
        );

  @override
  bool operator ==(other) {
    final otherClass = other;
    if (otherClass is AppStateLoggedIn) {
      return isLoading == otherClass.isLoading &&
          user.token == otherClass.user.token &&
          user.name == otherClass.user.name &&
          employees.length == otherClass.employees.length;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => Object.hash(
        user.token,
        user.name,
        employees,
      );

  @override
  String toString() => 'AppStateLogedIn, User: name = ${user.name}, employees = ${employees.length}';
}
class AppStateLoggedOut extends AppState {
 const  AppStateLoggedOut({
    required bool isLoading,
    AuthError? authError_8,
  }) : super(
          isLoading: isLoading,
          authError: authError_8,
        );
  @override
  String toString() =>
      'AppStateLogedOut, isLoading = $isLoading, authError = $authError';
}
