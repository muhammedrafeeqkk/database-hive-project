part of 'search_bloc.dart';
 class SearchState {
  final List<studentmodel>studentList;
  final List<studentmodel>studentSearchResultList;

  SearchState({required this.studentList,required this.studentSearchResultList});
 }

class InitiaState extends SearchState {
  InitiaState():super(studentList: [],studentSearchResultList: []);
  
}
