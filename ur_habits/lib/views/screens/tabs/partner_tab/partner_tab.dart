// import 'package:flutter/material.dart';
// import 'package:ur_habits/resources/colors.dart';
// import 'package:ur_habits/routers/route_manager.dart';
// import 'package:ur_habits/view_models/firestore_view_model.dart';
// import 'package:ur_habits/views/components/Indicator/custom_indicator.dart';
// import 'package:ur_habits/views/screens/tabs/components/panel/login_panel.dart';
// import 'package:ur_habits/views/screens/tabs/components/panel/partner_request_panel.dart';
// import 'package:ur_habits/views/screens/tabs/partner_tab/components/partner_details_panel.dart';

// /// パートナー画面を表示するウィジェット
// class PartnerTab extends StatelessWidget {
//   const PartnerTab({
//     super.key,
//     required this.firebaseViewModel,
//     required this.routeManager,
//   });

//   final FirebaseViewModel firebaseViewModel;
//   final RouteManager routeManager;

//   /// 認証されているユーザー向けのビューを構築
//   Widget _buildAuthenticatedView(
//     BuildContext context,
//     double screenWidth,
//     double screenHeight,
//   ) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           _buildPartnerSection(
//             context,
//             screenWidth,
//             screenHeight * 0.79,
//           ),
//         ],
//       ),
//     );
//   }

//   /// パートナー情報のセクションを構築
//   Widget _buildPartnerSection(
//     BuildContext context,
//     double screenWidth,
//     double screenHeight,
//   ) {
//     return SingleChildScrollView(
//       child: StreamBuilder(
//         stream: firebaseViewModel.getPartnerSnapshot(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CustomIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return PartnerRequestPanel(
//               routeManager: routeManager,
//               firebaseViewModel: firebaseViewModel,
//               backgroundColor: kTextBaseColor,
//             );
//           }
//           return PartnerDetailsPanel(
//             screenWidth: screenWidth,
//             screenHeight: screenHeight,
//             partnerSnapshot: snapshot,
//             firebaseViewModel: firebaseViewModel,
//             routeManager: routeManager,
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return StreamBuilder(
//       stream: firebaseViewModel.getSteamUser(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CustomIndicator(),
//           );
//         }
//         if (snapshot.hasData) {
//           return _buildAuthenticatedView(
//             context,
//             screenWidth,
//             screenHeight,
//           );
//         }
//         return LoginPanel(
//           routeManager: routeManager,
//           backgroundColor: kTextBaseColor,
//         );
//       },
//     );
//   }
// }
