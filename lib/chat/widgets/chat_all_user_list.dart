import 'package:flutter/material.dart';
import 'package:side_hustle/chat/widgets/chat_all_user_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';

class ChatAllUsersList extends StatefulWidget {
  final List? itemList;

  const ChatAllUsersList({super.key, this.itemList});

  @override
  State<ChatAllUsersList> createState() => _ChatAllUsersListState();
}

class _ChatAllUsersListState extends State<ChatAllUsersList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
        itemCount: 6,
        // Replace with your item count
        itemBuilder: (context, index) {
          // Replace with your horizontal list item
          return Material(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.chatOneToOneScreenRoute);
              },
              child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                  child: ChatAllUsersItem(
                    image: AlphaAppData.chatAllUsersList[index].image,
                    time: AlphaAppData.chatAllUsersList[index].time,
                    name: AlphaAppData.chatAllUsersList[index].name,
                    message: AlphaAppData.chatAllUsersList[index].message,
                  )),
            ),
          );
        },
      ),
    );
  }
}

/// Search List Plugin
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:searchable_listview/resources/arrays.dart';
// import 'package:searchable_listview/searchable_listview.dart';
// import 'package:side_hustle/chat/widgets/chat_all_user_item.dart';
// import 'package:side_hustle/event/widgets/event_item.dart';
// import 'package:side_hustle/utils/alpha_app_data.dart';
// import 'package:side_hustle/utils/app_colors.dart';
// import 'package:side_hustle/utils/app_dimen.dart';
// import 'package:side_hustle/utils/app_strings.dart';
// import 'package:side_hustle/utils/assets_path.dart';
//
// class ChatAllUsersList extends StatefulWidget {
//   const ChatAllUsersList({super.key});
//
//   @override
//   State<ChatAllUsersList> createState() => _ChatAllUsersListState();
// }
//
// class _ChatAllUsersListState extends State<ChatAllUsersList> {
//   final List<Actor> actors = [
//     Actor(age: 47, name: 'Leonardo', lastName: 'DiCaprio'),
//     Actor(age: 58, name: 'Johnny', lastName: 'Depp'),
//     Actor(age: 78, name: 'Robert', lastName: 'De Niro'),
//     Actor(age: 44, name: 'Tom', lastName: 'Hardy'),
//     Actor(age: 66, name: 'Denzel', lastName: 'Washington'),
//     Actor(age: 49, name: 'Ben', lastName: 'Affleck'),
//   ];
//
//   late FocusNode _focusNode;
//   late bool _isFocused;
//
//   @override
//   void initState() {
//     super.initState();
//     _isFocused = false;
//     _focusNode = FocusNode();
//     // _focusNode.unfocus();
//     _focusNode.addListener(_onFocusChange);
//   }
//
//   void _onFocusChange() {
//     setState(() {
//       _isFocused = _focusNode.hasFocus;
//     });
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // return Expanded(
//     //   child: ListView.builder(
//     //     physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
//     //     shrinkWrap: true,
//     //     scrollDirection: Axis.vertical,
//     //     // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
//     //     itemCount: 10,
//     //     // Replace with your item count
//     //     itemBuilder: (context, index) {
//     //       // Replace with your horizontal list item
//     //       return Padding(
//     //         padding: const EdgeInsets.only(right: 16.0, left: 8.0),
//     //         child: ChatAllUsersItem()
//     //       );
//     //     },
//     //   ),
//     // );
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.only(right: 16.0, left: 8.0),
//         child: SearchableList<Actor>.async(
//           displayClearIcon: false,
//           autoFocusOnSearch: false,
//           // onPaginate: () async {
//           //   await Future.delayed(const Duration(milliseconds: 1000));
//           //   print("list size: ${actors.length}");
//           //   setState(() {
//           //     actors.addAll([
//           //       Actor(age: 22, name: 'Fathi', lastName: 'Hadawi'),
//           //       Actor(age: 22, name: 'Hichem', lastName: 'Rostom'),
//           //       Actor(age: 22, name: 'Kamel', lastName: 'Twati'),
//           //     ]);
//           //   });
//           // },
//           builder: (actors, index, actor) => ChatAllUsersItem(),
//
//           loadingWidget: const Expanded(
//             child: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text('Loading actors...')
//                 ],
//               ),
//             ),
//           ),
//           // errorWidget: Column(
//           //   mainAxisAlignment: MainAxisAlignment.center,
//           //   children: const [
//           //     Icon(
//           //       Icons.error,
//           //       color: Colors.red,
//           //     ),
//           //     SizedBox(
//           //       height: 20,
//           //     ),
//           //     Text('Error while fetching actors')
//           //   ],
//           // ),
//           asyncListCallback: () async {
//             // await Future.delayed(
//             //   const Duration(
//             //     milliseconds: 1000,
//             //   ),
//             // );
//             return actors;
//           },
//           asyncListFilter: (q, list) {
//             return list.where((element) => element.name.contains(q)).toList();
//           },
//           emptyWidget: const EmptyView(),
//           focusNode: _focusNode,
//           onRefresh: () async {},
//           onItemSelected: (Actor item) {},
//           onSubmitSearch: (v) {},
//           inputDecoration: InputDecoration(
//             hintText: AppStrings.searchChatHint,
//             fillColor: Colors.white,
//             prefixIcon: const Icon(
//               Icons.search,
//               color: AppColors.greyColor,
//               size: 34,
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(
//                 color: AppColors.greyColor,
//                 width: 1.0,
//               ),
//               borderRadius:
//                   BorderRadius.circular(AppDimensions.textFieldBorderRadius),
//             ),
//             border: OutlineInputBorder(
//               borderSide: const BorderSide(
//                 color: AppColors.greyColor,
//                 width: 1.0,
//               ),
//               borderRadius:
//                   BorderRadius.circular(AppDimensions.textFieldBorderRadius),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Actor {
//   int age;
//   String name;
//   String lastName;
//
//   Actor({
//     required this.age,
//     required this.name,
//     required this.lastName,
//   });
// }
//
// class ActorItem extends StatelessWidget {
//   final Actor actor;
//
//   const ActorItem({
//     Key? key,
//     required this.actor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: 60,
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           children: [
//             const SizedBox(
//               width: 10,
//             ),
//             Icon(
//               Icons.star,
//               color: Colors.yellow[700],
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Firstname: ${actor.name}',
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'Lastname: ${actor.lastName}',
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'Age: ${actor.age}',
//                   style: const TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class EmptyView extends StatelessWidget {
//   const EmptyView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: const [
//         Icon(
//           Icons.error,
//           color: Colors.red,
//         ),
//         Text('no actor is found with this name'),
//       ],
//     );
//   }
// }
