part of 'members_list_bloc.dart';

abstract class MembersListEvent extends Equatable {
  const MembersListEvent();

  @override
  List<Object> get props => [];
}

class LoadMembersList extends MembersListEvent {}
