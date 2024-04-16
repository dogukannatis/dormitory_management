import 'package:json_annotation/json_annotation.dart';

part 'dormitory_details.g.dart';

@JsonSerializable()
class DormitoryDetails {
  @JsonKey(includeIfNull: false)
  final int? detailId;
  final int? dormitoryId;
  String? contactNo;
  String? email;
  String? faxNo;
  String? address;
  int? capacity;
  String? description;
  String? internetSpeed;
  bool? hasKitchen;
  bool? hasCleanService;
  bool? hasShowerAndToilet;
  bool? hasBalcony;
  bool? hasTV;
  bool? hasMicrowave;
  bool? hasAirConditioning;
  @JsonKey(includeIfNull: false)
  List? photoUrls;
  DateTime? createdAt;
  DateTime? updatedAt;

  DormitoryDetails({
    required this.detailId,
    required this.dormitoryId,
    this.contactNo,
    this.email,
    this.faxNo,
    this.address,
    this.capacity,
    this.description,
    this.internetSpeed,
    this.hasKitchen,
    this.hasCleanService,
    this.hasShowerAndToilet,
    this.hasBalcony,
    this.hasTV,
    this.hasMicrowave,
    this.hasAirConditioning,
    this.createdAt,
    this.photoUrls,
    this.updatedAt
  });

  factory DormitoryDetails.fromJson(Map<String, dynamic> json) => _$DormitoryDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DormitoryDetailsToJson(this);
}
