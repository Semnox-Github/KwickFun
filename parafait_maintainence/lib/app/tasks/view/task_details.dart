import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/comments/view/comments_layout.dart';
import 'package:parafait_maintainence/app/images/view/image_layout.dart';
import 'package:parafait_maintainence/app/service_request/view/service_request_create.dart';
import 'package:parafait_maintainence/app/tasks/view_model/taskdetails_viewmodel.dart';
import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_dto.dart';
import 'package:semnox_core/modules/maintenance/task/model/task_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/screen_utils/uihelper.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';

class TaskDetails extends ConsumerWidget {
  final TaskDetailData? data;

  const TaskDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(TaskDetailViewmodel.provider(TaskDetailData(
        checkListDetailDTO: data?.checkListDetailDTO,
        menuClick: data?.menuClick)));
    viewmodel.context = context;
    return WillPopScope(
      onWillPop: () {
        Modular.to.pop(context);
        return Future.value(false);
      },
      child: SemnoxScaffold(
        bodyPadding: EdgeInsets.zero,
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: const Color.fromRGBO(238, 134, 100, 1),
          title: const SemnoxText.subtitle(
            text: "Task Details",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Modular.to.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: DataProviderBuilder<bool>(
            enableAnimation: false,
            dataProvider: viewmodel.loadstates,
            loader: (context) {
              return const Center(
                child: SemnoxCircleLoader(
                  color: Colors.red,
                ),
              );
            },
            builder: (context, snapshot) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: SemnoxText.bodyMed1(
                              text:
                                  "${Messages.jobId}${viewmodel.checkListDetailDTO?.maintChklstdetId}${viewmodel.checkListDetailDTO?.taskName!}",
                            ),
                          ),
                        ),
                        const Divider(
                          height: 5,
                          thickness: 2,
                        ),
                        UIHelper.verticalSpaceMedium(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SemnoxDropdownField<TaskDto>(
                                border: false,
                                properties: viewmodel.taskField,
                                enabled: false,
                                position: LabelPosition.inside,
                              ),
                              UIHelper.verticalSpaceMedium(),
                              SemnoxDropdownField<GenericAssetDTO>(
                                border: false,
                                properties: viewmodel.assetField,
                                enabled: false,
                                position: LabelPosition.inside,
                              ),
                              UIHelper.verticalSpaceMedium(),
                              SemnoxTextFormField(
                                border: false,
                                properties: viewmodel.cardNoField,
                                enabled: false,
                                position: LabelPosition.inside,
                              ),
                              UIHelper.verticalSpaceMedium(),
                              SemnoxTextFormField(
                                  maxLength: 800,
                                  border: false,
                                  position: LabelPosition.inside,
                                  properties: viewmodel.remarksField),
                              UIHelper.verticalSpaceMedium(),
                              SemnoxDropdownField<LookupValuesContainerDtoList>(
                                border: false,
                                properties: viewmodel.statusField,
                                enabled: true,
                                position: LabelPosition.inside,
                              ),
                              UIHelper.verticalSpaceMedium(),
                              SemnoxDropdownField<UserContainerDto>(
                                border: false,
                                properties: viewmodel.assigneduserField,
                                enabled: viewmodel.assigneduserField.enabled,
                                position: LabelPosition.inside,
                              ),
                              ImageLayout(
                                  serviceRequestImage: Messages.taskImage,
                                  checkListDetailDTO:
                                      viewmodel.checkListDetailDTO),
                              UIHelper.verticalSpaceMedium(),
                              CommentsLayout(
                                checkListDetailDTO:
                                    viewmodel.checkListDetailDTO,
                                srAssigneduserlist: viewmodel.userList,
                              ),
                              UIHelper.verticalSpaceMedium(),
                              Row(
                                children: [
                                  SizedBox(width: 20.mapToIdealWidth(context)),
                                  Expanded(
                                    child: SemnoxFlatButton(
                                      child: const SemnoxText.subtitle(
                                        text: Messages.saveButton,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        await viewmodel
                                            .updateTaskDetails(context);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20.mapToIdealWidth(context)),
                                  viewmodel.statusField.value?.lookupValue !=
                                          "Closed"
                                      ? Expanded(
                                          child: SemnoxFlatButton(
                                            child: const SemnoxText.subtitle(
                                              text: Messages.raiseSRButton,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CreateServiceRequest(
                                                              checkListDetailDTO:
                                                                  viewmodel
                                                                      .checkListDetailDTO)));
                                            },
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(width: 20.mapToIdealWidth(context)),
                                  Expanded(
                                    child: SemnoxFlatButton(
                                      child: const SemnoxText.subtitle(
                                        text: Messages.cancelButton,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Modular.to.pop(context);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20.mapToIdealWidth(context)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
