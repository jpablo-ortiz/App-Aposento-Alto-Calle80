import 'dart:async';
import 'package:app_aposento_alto_calle80/services/get_it.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app_aposento_alto_calle80/models/user_app.dart';
import 'package:app_aposento_alto_calle80/services/repositories/member_repository.dart';

part 'members_list_event.dart';
part 'members_list_state.dart';

class MembersListBloc extends Bloc<MembersListEvent, MembersListState> {
  final MemberRepository _memberRepository;
  StreamSubscription? _membersSubscription;

  MembersListBloc()
      : _memberRepository = getIt.get<MemberRepository>(),
        super(MembersListLoading()) {
    _membersSubscription = _memberRepository.getMembersStream().listen(
          (members) => add(MembersListUpdate(members)),
          onError: (error) => add(MembersListUpdateError(error.toString())),
        );
  }

  @override
  Stream<MembersListState> mapEventToState(
    MembersListEvent event,
  ) async* {
    if (event is LoadMembersList) {
      yield* _mapLoadMembersToState();
    }
    if (event is MembersListUpdate) {
      yield* _mapMembersUpdateToState(event);
    }
  }

  Stream<MembersListState> _mapLoadMembersToState() async* {
    yield MembersListLoading();
    try {
      _membersSubscription?.cancel();
      _membersSubscription = _memberRepository.getMembersStream().listen(
            (members) => add(MembersListUpdate(members)),
            onError: (error) => add(MembersListUpdateError(error.toString())),
          );
    } catch (_) {
      yield const MembersListError(error: 'Something went wrong!');
    }
  }

  Stream<MembersListState> _mapMembersUpdateToState(MembersListUpdate event) async* {
    yield MembersListLoaded(members: event.members);
  }

  @override
  Future<void> close() {
    _membersSubscription?.cancel();
    return super.close();
  }
}
