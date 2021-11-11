import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/bloc/drawerBloc/drawer_bloc.dart';
import 'package:plants_app/bloc/drawerBloc/drawer_event.dart';
import 'package:plants_app/bloc/drawerBloc/drawer_state.dart';
import 'package:plants_app/respository/user_respon.dart';
import 'package:plants_app/screens/dashboard.dart';
import 'package:plants_app/screens/drawer.dart';
import 'package:plants_app/screens/login.dart';

class LayoutDrawer extends StatefulWidget {
  User? user;
  UserResponsitory? userResponsitory;
  LayoutDrawer({this.user, this.userResponsitory});
  @override
  _LayoutDrawerState createState() => _LayoutDrawerState();
}

class _LayoutDrawerState extends State<LayoutDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Duration duration = Duration(milliseconds: 400);
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: duration);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            DrawerBloc(userResponsitory: widget.userResponsitory),
        child: Scaffold(
          body: Stack(
            children: [
              MainWidget(
                user: widget.user,
                userResponsitory: widget.userResponsitory,
              ),
              Dashboard()
            ],
          ),
        ));
  }
}

// class LayOutDrawer extends StatelessWidget {
//   User? user;
//   UserResponsitory? userRepository;

//   LayOutDrawer({this.user, this.userRepository});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DrawerBloc(userResponsitory: userRepository),
//       child: HomePage(user: user, userRepository: userRepository),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   User? user;
//   UserResponsitory? userRepository;

//   HomePage({this.user, this.userRepository});
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   DrawerBloc? homePageBloc;

//   @override
//   Widget build(BuildContext context) {
//     homePageBloc = BlocProvider.of<DrawerBloc>(context);
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Text("email"),
//           centerTitle: true,
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(
//                 Icons.close,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 homePageBloc!.add(LogOutButtonOnPressState());
//               },
//             ),
//           ],
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               alignment: Alignment.center,
//               child: Text('${widget.user!.email}'),
//             ),
//             BlocListener<DrawerBloc, DrawerState>(
//               listener: (context, state) {
//                 if (state is LogoutSuccessfulState) {
//                   navigateToSignUpPage(context);
//                 }
//               },
//               child: BlocBuilder<DrawerBloc, DrawerState>(
//                 builder: (context, state) {
//                   if (state is LogoutSuccessfulState) {
//                     return Container();
//                   } else if (state is LogoutInitialState) {}
//                   return Container();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  // void navigateToSignUpPage(BuildContext context) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //     return LoginPageParent(userRepository: widget.userRepository);
  //   }));
  // }

