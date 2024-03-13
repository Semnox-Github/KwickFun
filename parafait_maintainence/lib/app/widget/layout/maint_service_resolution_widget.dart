import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:parafait_maintainence/app/comments/view/comments_layout.dart';
import 'package:parafait_maintainence/app/images/view/image_layout.dart';
import 'package:parafait_maintainence/app/service_request/view_model/service_request_detail_viewmodel.dart';
import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/screen_utils/uihelper.dart';

class ResolutionWidget extends StatefulWidget {
  const ResolutionWidget(
      {Key? key,
      required this.viewModel,
      required this.onresolve,
      required this.resolvemodulevisible})
      : super(key: key);

  final ServiceRequestDetailViewmodel viewModel;
  final bool resolvemodulevisible;
  final ValueGetter<void> onresolve;

  @override
  State<ResolutionWidget> createState() => _nameState();
}

class _nameState extends State<ResolutionWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              UIHelper.verticalSpaceMedium(),
              SemnoxDropdownField<UserContainerDto>(
                border: false,
                enabled: widget.viewModel.setEnabled!,
                properties: widget.viewModel.assigneduserField,
                position: LabelPosition.inside,
              ),
            ],
          ),
          UIHelper.verticalSpaceMedium(),
          SemnoxTextFormField(
              maxLength: 9,
              border: false,
              position: LabelPosition.inside,
              enabled: widget.viewModel.setEnabled!,
              properties: widget.viewModel.repaircostField),
          UIHelper.verticalSpaceMedium(),
          SemnoxTextFormField(
              maxLength: 500,
              maxLines: 6,
              border: false,
              position: LabelPosition.inside,
              enabled: widget.viewModel.setEnabled!,
              properties: widget.viewModel.resolutionField),
          UIHelper.verticalSpaceMedium(),
          widget.resolvemodulevisible == false
              ? Column(
                  children: [
                    ImageLayout(
                        serviceRequestImage: Messages.resolutionImage,
                        checkListDetailDTO:
                            widget.viewModel.checkListDetailDTO),
                    UIHelper.verticalSpaceMedium(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CommentsLayout(
                          checkListDetailDTO:
                              widget.viewModel.checkListDetailDTO!,
                          srAssigneduserlist: widget.viewModel.userList),
                    ),
                  ],
                )
              : Container(),
          UIHelper.verticalSpaceMedium(),
          widget.resolvemodulevisible == true
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Expanded(
                        child: SemnoxPopUpTwoButtons(
                          disableShadow: true,
                          outlineButtonText: Messages.cancelButton,
                          filledButtonText: Messages.resolveButton,
                          onFilledButtonPressed: () {
                            Modular.to.pop(context);
                            widget.onresolve();
                          },
                          onOutlineButtonPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),

                        //   SemnoxFlatButton(
                        //     child: const SemnoxText.button(
                        //       text: 'RESOLVE',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     onPressed: () {
                        //       Modular.to.pop(context);
                        //       widget.onresolve();
                        //     },
                        //     // () =>
                        //     //     Navigator.pushNamed(context, "/semnoxHomeScreen"),
                        //   ),
                        // ),

                        // SizedBox(width: 20.mapToIdealWidth(context)),
                        // Expanded(
                        //   child: SemnoxFlatButton(
                        //     child: const SemnoxText.button(
                        //       text: 'CLOSE',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     onPressed: () {
                        //       Navigator.pop(context, false);
                        //     },
                        //     // () =>
                        //     //     Navigator.pushNamed(context, "/semnoxHomeScreen"),
                        //   ),
                      ),

                      // SizedBox(width: 20.mapToIdealWidth(context)),

                      // const SizedBox(
                      //   width: 0,
                      // ),
                      // Container(
                      //   margin: const EdgeInsets.only(bottom: 20),
                      //   height: 50,
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       Modular.to.pop(context);
                      //       widget.onresolve();
                      //     },
                      //     // color: const Color.fromRGBO(238, 134, 100, 1),
                      //     // shape: RoundedRectangleBorder(
                      //     //     borderRadius: BorderRadius.circular(10)),
                      //     child: const SemnoxText(
                      //       text: "RESOLVE",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      // UIHelper.horizontalSpaceMedium(),
                      // Container(
                      //   margin: const EdgeInsets.only(bottom: 20),
                      //   height: 50,
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       Navigator.pop(context, false);
                      //     },
                      //     // color: const Color.fromRGBO(238, 134, 100, 1),
                      //     // shape: RoundedRectangleBorder(
                      //     //     borderRadius: BorderRadius.circular(10)),
                      //     child: const SemnoxText(
                      //       text: "CLOSE",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
