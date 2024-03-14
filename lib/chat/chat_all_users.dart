import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/widgets/chat_all_user_list.dart';
import 'package:side_hustle/chat/widgets/message_options_bottomsheet.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/chat/chat_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text_field/search_text_field.dart';

class ChatAllUsers extends StatefulWidget {
  const ChatAllUsers({super.key});

  @override
  State<ChatAllUsers> createState() => _ChatAllUsersState();
}

class _ChatAllUsersState extends State<ChatAllUsers> {
  late final ChatCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    getUserData();
    getChats();
  }

  getUserData() async {
    await _bloc.getUserData();
  }

  getChats() async {
    await _bloc.getChatsCubit(context: context, mounted: mounted);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: "${AppStrings.message}s",
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 0.09.sw, // Adjust as needed
            height: 0.09.sw, // Adjust as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.backIconBackgroundColor,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.more_vert_sharp,
                size: 0.055.sw,
                color: AppColors.primaryColor,
              ),
              onPressed: () {
                AppUtils.showBottomModalSheet(
                    context: context,
                    widget: MessageOptionsBottomSheet(
                      onTap: () {
                        print("clicked");
                        Navigator.pop(context);
                        Navigator.pushNamed(
                            context, AppRoutes.chatBlockUsersScreenRoute);
                      },
                      textBlockedUserOrUnBlockedUser: AppStrings.blockedUsers,
                    ));
              },
            ),
          ),
        )
      ],
      body: BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
        return state.chatAllUsersLoading
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppDimensions.rootPadding,
                        right: AppDimensions.rootPadding),
                    child: SearchTextField(
                        height: AppDimensions.searchTextFieldHeight,
                        contentPaddingBottom: 8,
                        hintText: AppStrings.searchChatHint,
                        onChanged: (search) {
                          _bloc.searchChatList(value: search);
                        }),
                  ),
                  const ChatAllUsersList(),
                  height(0.03.sw)
                ],
              );
      }),
    );
  }
}
