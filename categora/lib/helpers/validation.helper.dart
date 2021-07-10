bool isValidCredientials(String email, String password) {
  return validEmail(email) && validPassword(password);
}

bool validPassword(String password) {
  bool isValidPassword = true;

  if (password.length == 0) {
    isValidPassword = false;
  }

  return isValidPassword;
}

bool validEmail(String email) {
  bool isValidEmail = true;

  if (email.length == 0) {
    isValidEmail = false;
  }

  return isValidEmail;
}
