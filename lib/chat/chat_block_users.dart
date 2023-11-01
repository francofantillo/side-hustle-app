import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:side_hustle/chat/widgets/chat_all_user_list.dart';
import 'package:side_hustle/chat/widgets/chat_block_user_list.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/search_text_field.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class ChatBlockUsers extends StatefulWidget {
  const ChatBlockUsers({super.key});

  @override
  State<ChatBlockUsers> createState() => _ChatBlockUsersState();
}

class _ChatBlockUsersState extends State<ChatBlockUsers> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.blockedUsers,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: AppDimensions.rootPadding,
              right: AppDimensions.rootPadding,
            ),
            child: SearchTextField(
                hintText: AppStrings.searchChatHint, onChanged: (search) {}),
          ),
          const ChatBlockUsersList(),
          Padding(
            padding: EdgeInsets.only(
              left: AppDimensions.rootPadding + 8,
              right: AppDimensions.rootPadding + 8,
            ),
            child: customMaterialButton(
                onPressed: () {},
                borderRadius: 16,
                name: AppStrings.unblockAll),
          ),
          height(0.02.sh),
        ],
      ),
    );
  }
}
