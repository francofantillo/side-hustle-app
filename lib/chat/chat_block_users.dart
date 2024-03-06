import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/widgets/chat_block_user_list.dart';
import 'package:side_hustle/state_management/cubit/chat/chat_cubit.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text_field/search_text_field.dart';

class ChatBlockUsers extends StatefulWidget {
  const ChatBlockUsers({super.key});

  @override
  State<ChatBlockUsers> createState() => _ChatBlockUsersState();
}

class _ChatBlockUsersState extends State<ChatBlockUsers> {
  late final ChatCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    getChats();
  }

  getChats() async {
    await _bloc.getBlockedUsersChatCubit(context: context, mounted: mounted);
  }

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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          left: AppDimensions.rootPadding + 8,
          right: AppDimensions.rootPadding + 8,
          bottom: AppDimensions.rootPadding + 8,
        ),
        child: CustomMaterialButton(
            onPressed: () {}, borderRadius: 16, name: AppStrings.unblockAll),
      ),
      body: BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
        return state.chatBlockedUsersLoading
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
                          _bloc.searchBlockedChatList(value: search);
                        }),
                  ),
                  const ChatBlockUsersList(),
                  height(0.03.sw),
                ],
              );
      }),
    );
  }
}
