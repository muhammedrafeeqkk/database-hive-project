part of 'editing_student_bloc.dart';

abstract class EditingStudentEvent {}

// class EditStudentmodel extends EditingStudentEvent {
//   final studentmodel student;

//   EditStudentmodel({required this.student});
// }

class UpdateEditedImage extends EditingStudentEvent {
  final String updateImage;
  UpdateEditedImage({required this.updateImage});
}
