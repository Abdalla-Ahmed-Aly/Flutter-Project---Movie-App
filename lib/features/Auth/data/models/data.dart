
class Data {
  final String? email;
  final String? password;
  final String? name;
  final String? phone;
  final int? avaterId;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const Data({
    this.email,
    this.password,
    this.name,
    this.phone,
    this.avaterId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json['email'] as String?,
        password: json['password'] as String?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        avaterId: json['avaterId'] as int?,
        id: json['_id'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
      );


}
