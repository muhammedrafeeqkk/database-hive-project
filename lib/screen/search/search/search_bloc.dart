import 'package:bloc/bloc.dart';
import 'package:database_project/model/data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitiaState()) {
    List<studentmodel> studentList =
        Hive.box<studentmodel>('student_db').values.toList();
     List<studentmodel> displayStudent =
        List<studentmodel>.from(studentList);


    on<SearchDoneValue>((event, emit) {
      displayStudent = studentList
          .where((element) => element.name
              .toLowerCase()
              .contains(event.searchValue.toLowerCase()))
          .toList();

      emit(SearchState(
          studentList: studentList, studentSearchResultList: displayStudent));
    });
  }
}


 