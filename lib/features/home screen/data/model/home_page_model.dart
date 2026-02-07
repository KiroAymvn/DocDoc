import 'package:appointment/core/models/doctor_model.dart';

class HomePageModel {

final int id;
final String specName;
final List<DoctorModel> ?doctorModelList;

  HomePageModel({required this.id, required this.specName, required this.doctorModelList});

factory HomePageModel.fromJson(Map<String, dynamic> json) {
  return HomePageModel(
    id: json['id'] as int,
    specName: json['name'] as String,
    doctorModelList: (json["doctors"] as List).map((e)=>DoctorModel.fromMap(e)).toList(),
  );
}}