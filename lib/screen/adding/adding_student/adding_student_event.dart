part of 'adding_student_bloc.dart';


abstract class AddingStudentEvent {

   
}


class AddingImage extends AddingStudentEvent  {
  final String image;
  AddingImage({required this.image});
}

