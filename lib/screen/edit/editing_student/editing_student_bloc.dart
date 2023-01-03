import 'package:bloc/bloc.dart';
import 'package:database_project/model/data_model.dart';

part 'editing_student_event.dart';
part 'editing_student_state.dart';

class EditingStudentBloc
    extends Bloc<EditingStudentEvent, EditingImageState> {
  EditingStudentBloc() : super(InitialState()) {
    on<UpdateEditedImage>((event, emit) {



      
      emit(EditingImageState(image: event.updateImage));
    });
  }
}
