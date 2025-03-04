class ResetPasswordRequest {
  final String? oldPassword;
  final String? newPassword;

  const ResetPasswordRequest({this.oldPassword, this.newPassword});

  Map<String, dynamic> toJson() => {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      };
}
