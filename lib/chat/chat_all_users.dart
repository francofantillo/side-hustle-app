import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/widgets/chat_all_user_list.dart';
import 'package:side_hustle/chat/widgets/message_options_bottomsheet.dart';
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
                AppUtils.showBottomModalSheet(context: context, widget: const MessageOptionsBottomSheet());
              },
            ),
          ),
        )
      ],
      body: Column(
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
                onChanged: (search) {}),
          ),
          const ChatAllUsersList(),
          height(0.02.sh)
        ],
      ),
    );
  }
}
