import 'package:app_aposento_alto_calle80/models/user_app.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'members_list_event.dart';
part 'members_list_state.dart';

class MembersListBloc extends Bloc<MembersListEvent, MembersListState> {
  MembersListBloc() : super(MembersListInitial()) {
    //on<LoadMembersList>(_onLoadMembersList);
  }

  //FutureOr<void> _onLoadMembersList(LoadMembersList event, Emitter<MembersListState> emit) async {
  //  emit();
  //}
}
