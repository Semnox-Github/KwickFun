import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/comments/view_model/comments_view_model.dart';
import 'package:parafait_maintainence/app/widget/elements/remarksContainerSection.dart';
import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/utils/screen_utils/uihelper.dart';
import 'package:semnox_core/utils/text_style.dart';
import 'package:semnox_core/widgets/elements/data_provider_builder.dart';
import 'package:semnox_core/widgets/elements/text.dart';

class CommentsLayout extends ConsumerWidget {
  final CheckListDetailDTO? checkListDetailDTO;
  final List<UserContainerDto>? srAssigneduserlist;

  const CommentsLayout(
      {Key? key,
      required this.checkListDetailDTO,
      required this.srAssigneduserlist})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel =
        ref.watch(CommentsViewModel.provider(checkListDetailDTO!));
    return DataProviderBuilder<bool>(
        enableAnimation: false,
        dataProvider: viewModel.loadstates,
        loader: (context) {
          return Center(
            child: Container(),
          );
        },
        builder: (context, snapshot) {
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(243, 245, 245, 1),
            ),
            child: Column(
              children: [
                RemarksContainerSection(
                  child: TextField(
                    style: SemnoxTextStyle.bodyTextMedium1(context),
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    controller: viewModel.commentsTextController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          viewModel.saveComments(viewModel, context);
                        },
                        color: const Color.fromRGBO(238, 134, 100, 1),
                      ),
                      hintText: "Say Something",
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: viewModel.getservicerequestcommentDTOList!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SemnoxText.subtitle(
                                  text: viewModel
                                      .getUserNameFromLoginId(
                                          srAssigneduserlist,
                                          viewModel
                                              .getservicerequestcommentDTOList![
                                                  index]
                                              .createdBy)
                                      .toUpperCase(),
                                ),
                                UIHelper.verticalSpaceMedium(),
                                SemnoxText.bodyMed1(
                                  text: viewModel
                                      .getservicerequestcommentDTOList![index]
                                      .comment
                                      .toString(),
                                ),
                                UIHelper.verticalSpaceSmall(),
                                SemnoxText.bodyMed1(
                                  text: viewModel
                                      .changeDateAndTimeForCommentsCard(
                                          viewModel
                                              .getservicerequestcommentDTOList![
                                                  index]
                                              .creationDate
                                              .toString()),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}
