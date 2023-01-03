import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'adding_student_event.dart';
part 'adding_student_state.dart';

class AddingStudentBloc extends Bloc<AddingStudentEvent, AddingStudentState> {
  AddingStudentBloc() : super(InitialState()) {
    on<AddingImage>((event, emit) {
      final studentimage = AddingStudentState(imagePath: event.image);
      emit(studentimage);
    });
  }
}
