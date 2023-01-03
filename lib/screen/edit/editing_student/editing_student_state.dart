part of 'editing_student_bloc.dart';

class EditingImageState {
  final String image;

  EditingImageState({
    required this.image,
  });
}

class InitialState extends EditingImageState {
  InitialState() : super(image: '');
}
