import 'package:app_aposento_alto_calle80/blocs/members_list_bloc/members_list_bloc.dart';
import 'package:app_aposento_alto_calle80/screens/home/members_list/widgets/member_card.dart';
import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MembersListScreen extends StatelessWidget {
  const MembersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MembersListBloc>(
        create: (context) => MembersListBloc(),
        child: const Padding(
          padding: EdgeInsets.all(paddingLarge),
          child: MembersListView(),
        ),
      ),
    );
  }
}

class MembersListView extends StatefulWidget {
  const MembersListView({Key? key}) : super(key: key);

  @override
  _MembersListViewState createState() => _MembersListViewState();
}

class _MembersListViewState extends State<MembersListView> {
  late final MembersListBloc _membersListBloc;

  @override
  void initState() {
    super.initState();
    _membersListBloc = BlocProvider.of<MembersListBloc>(context)..add(LoadMembersList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembersListBloc, MembersListState>(
      bloc: _membersListBloc,
      builder: (context, state) {
        if (state is MembersListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MembersListLoaded) {
          return ListView.builder(
            primary: false,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: state.members.length,
            itemBuilder: (context, index) {
              return MemberCard(
                user: state.members[index],
              );
            },
          );
        }
        if (state is MembersListError) {
          return const Center(
            child: Text('Error'),
          );
        }
        return Container();
      },
    );
  }
}

/*
class ListaMiembros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp>(context);

    return StreamProvider<List<Usuario>>.value(
      value: DatabaseService(uid: user.uid).usuarios,
      builder: (context, snapshot) {
        List<Usuario> users = Provider.of<List<Usuario>>(context) ?? [];
        return Stack(
          children: <Widget>[
            PantallaFix(
              background: fondoGradient,
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) => MemberCard(user: users[index]),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
*/