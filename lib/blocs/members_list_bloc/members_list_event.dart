part of 'members_list_bloc.dart';

abstract class MembersListEvent extends Equatable {
  const MembersListEvent();

  @override
  List<Object> get props => [];
}

class LoadMembersList extends MembersListEvent {}

class MembersListUpdate extends MembersListEvent {
  final List<UserApp> members;

  const MembersListUpdate(this.members);

  @override
  List<Object> get props => [members];
}

class MembersListUpdateError extends MembersListEvent {
  final String error;

  const MembersListUpdateError(this.error);

  @override
  List<Object> get props => [error];
}
