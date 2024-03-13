import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/parafait_home/view_model/purge_view_model.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/screen_utils/uihelper.dart';

class PurgeBottomSheetPreview extends ConsumerWidget {
  const PurgeBottomSheetPreview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final viewmodel = ref.watch(PurgeViewmodel.provider);
    viewmodel.context = context;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: SemnoxText.subtitle(
                  text: "Purge",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23.0,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 5,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: InkWell(
                      onTap: () => viewmodel.purgeJobDetails(),
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 20,
                            child: Icon(
                              Icons.business_center_outlined,
                              color: Color.fromRGBO(238, 134, 100, 1),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SemnoxText.subtitle(
                            text: Messages.purgeJobDetails,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 23.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  UIHelper.verticalSpaceSmall(),
                  const Divider(
                    height: 5,
                    thickness: 2,
                  ),
                  // UIHelper.verticalSpaceSmall(),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                  //   child: InkWell(
                  //     onTap: () => viewmodel.purgeAssets(),
                  //     child: Row(
                  //       children: [
                  //         SizedBox(
                  //           width: 20,
                  //           child: Image.asset('assets/icons/purge_assets.png'),
                  //         ),
                  //         const SizedBox(width: 10),
                  //         const SemnoxText.subtitle(
                  //           text: Messages.purgeAssets,
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //             fontSize: 23.0,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // UIHelper.verticalSpaceSmall(),
                  // const Divider(
                  //   height: 5,
                  //   thickness: 2,
                  // ),
                  // UIHelper.verticalSpaceSmall(),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                  //   child: InkWell(
                  //     onTap: () => viewmodel.purgeall(),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         SizedBox(
                  //           width: 20,
                  //           child: Image.asset('assets/icons/purge_all.png'),
                  //         ),
                  //         const SizedBox(width: 10),
                  //         const SemnoxText.subtitle(
                  //           text: Messages.purgeAll,
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //             fontSize: 23.0,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  UIHelper.verticalSpaceSmall(),
                  const Divider(
                    height: 5,
                    thickness: 2,
                  ),
                  UIHelper.verticalSpaceSmall(),
                ],
              ),
            ),
          ],
        ))
      ],
    );
  }
}
