class Validation {
  String? validatePassword(String value) {
    if (value != null) {
      if (!(value.length > 5) && value.isEmpty) {
        return "Vui lòng nhập mật khẩu lớn hơn 6 ký tự";
      }
      return null;
    }
  }

  String? validateName(String value) {
    if (value.length != 0) {
      if (value.isEmpty) {
        return "Vui lòng nhập họ tên";
      }
      return null;
    }
  }

  String? validatePhone(String value) {
    if (!value.isEmpty) {
      if (value.isEmpty && value.length < 10) {
        return "Vui lòng nhập số điện thoại";
      }
      return null;
    }
  }

  String? validateEmail(String value) {
    if (value != null) {
      if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
        return null;
      }
      return 'Email không chính xác';
    }
  }
}
