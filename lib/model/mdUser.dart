class MDUser {
  String? idUser;
  String? name;
  String? gender;
  String? phoneNumber;
  String? email;
  String? birthday;
  String? address;
  int? point;
  String? image;
  MDUser(
      {this.idUser,
      this.name,
      this.gender,
      this.address,
      this.email,
      this.birthday,
      this.phoneNumber,
      this.point,
      this.image});
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'idUser': idUser,
        'gender': gender,
        'phoneNumber': phoneNumber,
        'birthday': birthday,
        'address': address,
        'point': point,
        'image': image
      };
  factory MDUser.fromJson(Map<String, dynamic> json) {
    return MDUser(
      idUser: json['idUser'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      birthday: json['birthday'],
      address: json['address'],
      point: json['point'],
      image: json['image'],
    );
  }
}
