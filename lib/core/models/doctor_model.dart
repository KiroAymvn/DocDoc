
import 'package:appointment/core/models/speciality_model.dart';

class DoctorModel {
  final int doctorId;
  final String name;
  final String email;
  final String phone;
  final String ?photo;

  final String gender;
  final String address;
  final String description;
  final String degree;
  SpecialityModel specialization;
  final int appointPrice;
  final String startTime;
  final String endTime;

  DoctorModel({
    required this.doctorId,
    required this.name,
    required this.email,
    required this.phone,
    this.photo,
    required this.gender,
    required this.address,
    required this.description,
    required this.degree,
    required this.specialization,
    required this.appointPrice,
    required this.startTime,
    required this.endTime,
  });

 static  List<DoctorModel>  docList = [
  DoctorModel(doctorId: 1,
  name: "Finn Orn DVM",
  email: "roderick51@example.net",
  phone: "+1.956.684.0448",
  gender: "Male",
  address: "258 Tiffany View Suite 262\nPort Alyceland, ND 16329-8282",
  photo: "assets/images/man4.png",
  description: "Velit et.",
  degree: "Consultant",
  specialization: SpecialityModel(specialityID: 1, specialityName: "Gastroenterology"),
  appointPrice: 300,
  startTime: "14:00:00 PM",
  endTime: "20:00:00 PM"),
  DoctorModel(doctorId: 1,
  name: "Finn Orn DVM",
  email: "lirpasd@gmail.com",
  phone: "01278854405",
  gender: "Male",
  address: "nasr city",
  photo: "assets/images/man4.png",
  description: "a prof doctor at the habdation process",
  degree: "degree",
  specialization: SpecialityModel(specialityID: 1, specialityName: "Neurology"),
  appointPrice: 200,
  startTime: "14:00:00 PM",
  endTime: "20:00:00 PM"),
  DoctorModel(doctorId: 1,
  name: "kiro",
  email: "lirpasd@gmail.com",
  phone: "01278854405",
  gender: "Male",
  address: "nasr city",
  photo: "assets/images/man4.png",
  description: "a prof doctor at the habdation process",
  degree: "Specialist",
  specialization: SpecialityModel(specialityID: 1, specialityName: "specialityName"),
  appointPrice: 200,
  startTime: "14:00:00 PM",
  endTime: "20:00:00 PM"),
  DoctorModel(doctorId: 1,
  name: "kiro",
  email: "lirpasd@gmail.com",
  phone: "01278854405",
  gender: "Male",
  address: "nasr city",
  photo: "assets/images/man4.png",
  description: "a prof doctor at the habdation process",
  degree: "degree",
  specialization: SpecialityModel(specialityID: 1, specialityName: "specialityName"),
  appointPrice: 200,
  startTime: "14:00:00 PM",
  endTime: "20:00:00 PM"),
  DoctorModel(doctorId: 1,
  name: "kiro",
  email: "lirpasd@gmail.com",
  phone: "01278854405",
  gender: "Male",
  address: "nasr city",
  photo: "assets/images/man4.png",
  description: "a prof doctor at the habdation process",
  degree: "degree",
  specialization: SpecialityModel(specialityID: 1, specialityName: "specialityName"),
  appointPrice: 200,
  startTime: "14:00:00 PM",
  endTime: "20:00:00 PM"),
  ];
  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      doctorId: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      photo: map['photo'] as String,
      gender: map['gender'] as String,
      address: map['address'] as String,
      description: map['description'] as String,
      degree: map['degree'] as String,
      specialization: (SpecialityModel.fromMap(map["specialization"])),
      appointPrice: map['appoint_price'] as int,
      startTime: map['start_time'] as String,
      endTime: map['end_time'] as String,
    );
  }
}
