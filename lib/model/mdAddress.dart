class MDAddress {
  String? idAddress;
  String? name;
  String? phonenumber;
  String? street;
  String? address;
  String? idCus;
  MDAddress(
      {this.idAddress,
      this.name,
      this.phonenumber,
      this.address,
      this.street,
      this.idCus});
  factory MDAddress.fromJson(dynamic json) {
    return MDAddress(
        idCus: json['idCus'],
        name: json['name'],
        phonenumber: json['phoneNumber'],
        address: json['address'],
        street: json['street'],
        idAddress: json['idAddress']);
  }
}
