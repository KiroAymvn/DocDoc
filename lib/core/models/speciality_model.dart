class SpecialityModel {
  final int specialityID;
  final String ?specialityImage;
  final String specialityName;

  SpecialityModel({
    required this.specialityID,
     this.specialityImage,
    required this.specialityName
  });

  static List<SpecialityModel> specialityList = [
    SpecialityModel(specialityID: 1, specialityImage: "assets/speciality/heart.png", specialityName: "Cardiology"),
    SpecialityModel(specialityID: 2, specialityImage: "assets/speciality/inside mouth.png", specialityName: "Dermatology"),
    SpecialityModel(specialityID: 3, specialityImage: "assets/speciality/Brain 1.png", specialityName: "Neurology"),
    SpecialityModel(specialityID: 4, specialityImage: "assets/speciality/teeth.png", specialityName: "Orthopedics"),
    SpecialityModel(specialityID: 5, specialityImage: "assets/speciality/liver.png", specialityName: "Pediatrics"),
    SpecialityModel(specialityID: 6, specialityImage: "assets/speciality/large intesten .png", specialityName: "Gynecology"),
    SpecialityModel(specialityID: 7, specialityImage: "assets/speciality/eye.png", specialityName: "Ophthalmology"),
    SpecialityModel(specialityID: 8, specialityImage: "assets/speciality/kidney.png", specialityName: "Urology"),
    SpecialityModel(specialityID: 9, specialityImage: "assets/speciality/lamge.png", specialityName: "Gastroenterology"),
    SpecialityModel(specialityID: 10, specialityImage: "assets/speciality/bancherias.png", specialityName: "Psychiatry"),
  ];



  factory SpecialityModel.fromMap(Map<String, dynamic> map) {
    return SpecialityModel(
      specialityID: map['id'] as int,
      specialityName: map['name'] as String,
    );
  }

}