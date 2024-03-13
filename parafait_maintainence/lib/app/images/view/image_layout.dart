import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/images/view_model/images_view_model.dart';
import 'package:parafait_maintainence/app/tasks/view_model/tasks_viewmodel.dart';
import 'package:parafait_maintainence/app/widget/elements/textContainer.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/screen_utils/uihelper.dart';
import 'package:semnox_core/widgets/elements/data_provider_builder.dart';
import 'package:semnox_core/widgets/elements/text.dart';

class ImageLayout extends ConsumerWidget {
  final CheckListDetailDTO? checkListDetailDTO;
  final String? serviceRequestImage;

  const ImageLayout(
      {Key? key,
      required this.serviceRequestImage,
      required this.checkListDetailDTO})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(ImageViewModel.provider(CheckListData(
        checkListDetailDTO: checkListDetailDTO,
        lookupvalue: serviceRequestImage!)));
    return DataProviderBuilder<bool>(
        enableAnimation: false,
        dataProvider: viewmodel.loadstates,
        loader: (context) {
          return Center(
            child: Container(),
          );
        },
        builder: (context, snapshot) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  viewmodel.showCamera(context, viewmodel);
                },
                child: TextContainer(
                  child: Row(
                    children: [
                      Image.asset('assets/icons/camera.png'),
                      UIHelper.horizontalSpaceSmall(),
                      const SemnoxText.h5(
                        text: Messages.uploadPicture,
                        style: TextStyle(
                            color: Color.fromRGBO(164, 66, 54, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              viewmodel.getImageDTOList!.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 0,
                      ),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: viewmodel.getImageDTOList!.isNotEmpty
                          ? viewmodel.getImageDTOList!.length
                          : 0,
                      itemBuilder: (context, index) {
                        return SemnoxFlatCard(
                          color: Colors.transparent,
                          child: GestureDetector(
                              onTap: () {
                                viewmodel.showImagePreview(context,
                                    "/data/user/0/com.semnox.parafait_maintainence.dev/app_flutter/${viewmodel.getImageDTOList![index].imageFileName.toString()}");
                              },
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10.0)),
                                child: Image.file(File(
                                    "/data/user/0/com.semnox.parafait_maintainence.dev/app_flutter/${viewmodel.getImageDTOList![index].imageFileName.toString()}")),
                              )),
                        );
                      },
                    )
                  : Container()
            ],
          );
        });
  }
}
