abstract class AuthError {
  final String dialogTitle;
  final String dialogText;

  const AuthError({
    required this.dialogTitle,
    required this.dialogText,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AuthError &&
      other.dialogTitle == dialogTitle &&
      other.dialogText == dialogText;
  }

  @override
  int get hashCode => dialogTitle.hashCode ^ dialogText.hashCode;

  @override
  String toString() => 'AuthError_8(dialogTitle: $dialogTitle, dialogText: $dialogText)';
}
