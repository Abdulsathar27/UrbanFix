class AddressModel {
  final String id;
  final String label; 
  final String address;

  AddressModel({
    required this.id,
    required this.label,
    required this.address,
  });

  factory AddressModel.create({required String label, required String address}) {
    return AddressModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      label: label,
      address: address,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'address': address,
      };

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'] as String,
        label: json['label'] as String,
        address: json['address'] as String,
      );
}
