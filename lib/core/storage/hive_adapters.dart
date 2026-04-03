import 'package:hive_flutter/hive_flutter.dart';
import 'package:appointment/core/models/doctor_model.dart';
import 'package:appointment/core/models/speciality_model.dart';
import 'package:appointment/core/models/user_model.dart';
import 'package:appointment/features/home%20screen/data/model/home_page_model.dart';
import 'package:appointment/features/appointment/data/model/appointment_model.dart';

// ---------- Type ID constants (must be unique across the app) ----------
// SpecialityModel    → typeId: 0
// DoctorModel        → typeId: 1
// HomePageModel      → typeId: 2
// UserModel          → typeId: 3
// AppointmentModel   → typeId: 4

/// Hand-written Hive adapter for [SpecialityModel].
/// No build_runner needed — simpler and easier to read.
class SpecialityModelAdapter extends TypeAdapter<SpecialityModel> {
  @override
  final int typeId = 0;

  @override
  SpecialityModel read(BinaryReader reader) {
    return SpecialityModel(
      specialityID: reader.readInt(),
      specialityName: reader.readString(),
      specialityImage: reader.readBool() ? reader.readString() : null,
    );
  }

  @override
  void write(BinaryWriter writer, SpecialityModel obj) {
    writer.writeInt(obj.specialityID);
    writer.writeString(obj.specialityName);
    // Write a boolean flag before the nullable field
    writer.writeBool(obj.specialityImage != null);
    if (obj.specialityImage != null) {
      writer.writeString(obj.specialityImage!);
    }
  }
}

/// Hand-written Hive adapter for [DoctorModel].
class DoctorModelAdapter extends TypeAdapter<DoctorModel> {
  @override
  final int typeId = 1;

  @override
  DoctorModel read(BinaryReader reader) {
    return DoctorModel(
      doctorId: reader.readInt(),
      name: reader.readString(),
      email: reader.readString(),
      phone: reader.readString(),
      photo: reader.readBool() ? reader.readString() : null,
      gender: reader.readString(),
      address: reader.readString(),
      description: reader.readString(),
      degree: reader.readString(),
      specialization: reader.read() as SpecialityModel,
      appointPrice: reader.readInt(),
      startTime: reader.readString(),
      endTime: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, DoctorModel obj) {
    writer.writeInt(obj.doctorId);
    writer.writeString(obj.name);
    writer.writeString(obj.email);
    writer.writeString(obj.phone);
    writer.writeBool(obj.photo != null);
    if (obj.photo != null) writer.writeString(obj.photo!);
    writer.writeString(obj.gender);
    writer.writeString(obj.address);
    writer.writeString(obj.description);
    writer.writeString(obj.degree);
    writer.write(obj.specialization); // uses SpecialityModelAdapter
    writer.writeInt(obj.appointPrice);
    writer.writeString(obj.startTime);
    writer.writeString(obj.endTime);
  }
}

/// Hand-written Hive adapter for [HomePageModel].
class HomePageModelAdapter extends TypeAdapter<HomePageModel> {
  @override
  final int typeId = 2;

  @override
  HomePageModel read(BinaryReader reader) {
    return HomePageModel(
      id: reader.readInt(),
      specName: reader.readString(),
      doctorModelList: (reader.readList()).cast<DoctorModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, HomePageModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.specName);
    writer.writeList(obj.doctorModelList ?? []);
  }
}

/// Hand-written Hive adapter for [UserModel].
class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 3;

  @override
  UserModel read(BinaryReader reader) {
    return UserModel(
      id: reader.readInt(),
      name: reader.readString(),
      email: reader.readString(),
      phone: reader.readString(),
      gender: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.email);
    writer.writeString(obj.phone);
    writer.writeString(obj.gender);
  }
}

/// Hand-written Hive adapter for [AppointmentModel].
class AppointmentModelAdapter extends TypeAdapter<AppointmentModel> {
  @override
  final int typeId = 4;

  @override
  AppointmentModel read(BinaryReader reader) {
    return AppointmentModel(
      id: reader.readInt(),
      doctor: reader.read() as DoctorModel,
      patient: reader.read() as UserModel,
      appointmentTime: reader.readString(),
      appointmentEndTime: reader.readString(),
      status: reader.readString(),
      notes: reader.readString(),
      appointmentPrice: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentModel obj) {
    writer.writeInt(obj.id);
    writer.write(obj.doctor); // uses DoctorModelAdapter
    writer.write(obj.patient); // uses UserModelAdapter
    writer.writeString(obj.appointmentTime);
    writer.writeString(obj.appointmentEndTime);
    writer.writeString(obj.status);
    writer.writeString(obj.notes);
    writer.writeInt(obj.appointmentPrice);
  }
}
