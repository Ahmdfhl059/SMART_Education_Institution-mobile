// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_education_institution_mobile/logic/internet_cubit/internet_cubit.dart';
// bool isInternet=false;
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home')),
//       body: BlocConsumer<InternetCubit, InternetState>(
//         listener: (context, state) {
//           if (state is NotConnectedState) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is ConnectedState) {
//             setState(() {
//               isInternet=!isInternet;
//             });
//             return _buildTextWidget(state.message);
//           } else if (state is NotConnectedState) {
//             setState(() {
//               isInternet=!isInternet;
//             });
//             return _buildTextWidget(state.message);
//           }
//           return SizedBox();
//         },
//       ),
//     );
//   }
// }
//
// Widget _buildTextWidget(String message) {
//   return Center(child: Text(message, style: TextStyle(fontSize: 20)));
// }
