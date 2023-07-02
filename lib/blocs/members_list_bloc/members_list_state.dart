part of 'members_list_bloc.dart';

abstract class MembersListState extends Equatable {
  const MembersListState();

  @override
  List<Object> get props => [];
}

class MembersListLoading extends MembersListState {}

class MembersListError extends MembersListState {
  final String error;

  const MembersListError({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MembersListError { error: $error }';
}

class MembersListLoaded extends MembersListState {
  final List<UserApp> members;

  const MembersListLoaded({required this.members});

  @override
  List<Object> get props => [members];

  @override
  String toString() => 'MembersListLoaded { members: $members }';
}
