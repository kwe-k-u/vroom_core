

class Driver{
  final String id;
  final String name;
  final String phoneNumber;
  final String imageUrl;
  
  Driver({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.phoneNumber,
});
  
  factory Driver.fromJson(Map<String,dynamic> map) => Driver(
    phoneNumber: map["phoneNumber"],
    name: map["name"],
    id: map["id"],
    imageUrl: map["imageUrl"]
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "imageUrl" : imageUrl,
    "name" : "name",
    "phoneNumber" : phoneNumber
  };
}