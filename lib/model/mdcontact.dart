class MDContact {
  String? id;
  String? email;
  String? nameCus;
  String? subject;
  String? body;
  String? state;
  MDContact(
      {this.id, this.email, this.nameCus, this.subject, this.body, this.state});
  Map<String, dynamic> toJson() => {
        'name': nameCus,
        'email': email,
        'subject': subject,
        'body': body,
        'id': id,
        'state': state,
      };
  factory MDContact.fromJson(Map<String, dynamic> json) {
    return MDContact(
      id: json['id'],
      nameCus: json['name'],
      email: json['email'],
      subject: json['subject'],
      body: json['body'],
      state: json['state'],
    );
  }
}
