import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/images/view/image_layout.dart';
import 'package:parafait_maintainence/app/parafait_home/route/module.dart';
import 'package:parafait_maintainence/app/service_request/view_model/service_request_detail_viewmodel.dart';
import 'package:parafait_maintainence/app/tasks/view_model/taskdetails_viewmodel.dart';
import 'package:parafait_maintainence/app/widget/layout/maint_service_resolution_widget.dart';
import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';
import 'package:semnox_core/widgets/elements/uihelper.dart';
import 'package:semnox_core/widgets/input_fields/date_field/date_field.dart';

class ServiceRequestDetailsScreen extends ConsumerWidget {
  final TaskDetailData? data;

  const ServiceRequestDetailsScreen({Key? key, required this.data})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(ServiceRequestDetailViewmodel.provider(
        TaskDetailData(
            checkListDetailDTO: data?.checkListDetailDTO,
            menuClick: data?.menuClick)));
    viewmodel.context = context;
    return WillPopScope(
      onWillPop: () {
        // Modular.to.pushNamed(HomeModule.srtab, arguments: "Recent");
        Modular.to.pop(context);
        return Future.value(false);
      },
      child: SemnoxScaffold(
        bodyPadding: EdgeInsets.zero,
        appBar: SemnoxAppBar(
          title: SemnoxText.subtitle(
            text: viewmodel.menuClick != "Draft"
                ? 'Service Request'
                : 'My Draft Requests',
            style: const TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () async {
              // Modular.to.pushNamed(HomeModule.srtab, arguments: "Recent");
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
              return Stack(children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: SemnoxText.bodyMed1(
                            text:
                                "${Messages.requestId}${viewmodel.checkListDetailDTO?.maintChklstdetId}${viewmodel.checkListDetailDTO?.maintJobName ?? ""}",
                          ),
                        ),
                      ),
                      const Divider(
                        height: 5,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            UIHelper.verticalSpaceSmall(),
                            SemnoxTextFormField(
                                border: false,
                                enabled: viewmodel.setEnabled!,
                                position: LabelPosition.inside,
                                properties: viewmodel.requestNoField),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxDropdownField<LookupValuesContainerDtoList>(
                              border: false,
                              properties: viewmodel.statusField,
                              enabled: viewmodel.setEnabled!,
                              // enabled: viewmodel.statusField.enabled,
                              position: LabelPosition.inside,
                            ),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxDateFormField(
                              enabled: viewmodel.setEnabled!,
                              border: false,
                              properties: viewmodel.requestDateField,
                              position: LabelPosition.inside,
                            ),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxDropdownField<GenericAssetDTO>(
                              border: false,
                              properties: viewmodel.assetField,
                              enabled: viewmodel.setEnabled!,
                              position: LabelPosition.inside,
                            ),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxTextFormField(
                                border: false,
                                enabled: false,
                                position: LabelPosition.inside,
                                properties: viewmodel.gamenameField),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxDateFormField(
                              border: false,
                              properties: viewmodel.scheduledatetimeField,
                              enabled: viewmodel.setEnabled!,
                              position: LabelPosition.inside,
                            ),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxDropdownField<LookupValuesContainerDtoList>(
                              border: false,
                              properties: viewmodel.requestField,
                              enabled: viewmodel.setEnabled!,
                              position: LabelPosition.inside,
                            ),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxTextFormField(
                                maxLength: 500,
                                border: false,
                                position: LabelPosition.inside,
                                enabled: viewmodel.setEnabled!,
                                properties: viewmodel.requestTitleField),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxTextFormField(
                                maxLength: 500,
                                border: false,
                                maxLines: 6,
                                position: LabelPosition.inside,
                                enabled: viewmodel.setEnabled!,
                                properties: viewmodel.requestDetailsField),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxDropdownField<LookupValuesContainerDtoList>(
                              border: false,
                              enabled: viewmodel.setEnabled!,
                              properties: viewmodel.priorityField,
                              position: LabelPosition.inside,
                            ),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxTextFormField(
                                maxLength: 200,
                                border: false,
                                position: LabelPosition.inside,
                                enabled: viewmodel.setEnabled!,
                                properties: viewmodel.contactPersonField),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxTextFormField(
                                maxLength: 50,
                                border: false,
                                enabled: viewmodel.setEnabled!,
                                position: LabelPosition.inside,
                                properties: viewmodel.phoneField),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxTextFormField(
                                maxLength: 200,
                                border: false,
                                position: LabelPosition.inside,
                                enabled: viewmodel.setEnabled!,
                                properties: viewmodel.emailField),
                            UIHelper.verticalSpaceMedium(),
                            ImageLayout(
                                serviceRequestImage:
                                    Messages.serviceRequestImage,
                                checkListDetailDTO:
                                    viewmodel.checkListDetailDTO),
                            UIHelper.verticalSpaceMedium(),
                            Column(
                              children: [
                                viewmodel.statusField.value?.lookupValue ==
                                            "DRAFT" ||
                                        viewmodel.statusField.value
                                                ?.lookupValue ==
                                            "ABANDONED"
                                    ? Container()
                                    : SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Expanded(
                                          child: SemnoxFlatButton(
                                            child: const SemnoxText.subtitle(
                                              text: "Resolution Details",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              viewmodel.statusField.value
                                                              ?.lookupValue
                                                              .toString() ==
                                                          "DRAFT" ||
                                                      viewmodel
                                                              .statusField
                                                              .value
                                                              ?.lookupValue
                                                              .toString() ==
                                                          "ABANDONED"
                                                  ? null
                                                  : viewmodel
                                                      .updateresolutionview();
                                            },
                                          ),
                                        ),
                                      ),
                                SizedBox(height: 20.mapToIdealWidth(context)),
                                viewmodel.statusField.value?.lookupValue !=
                                            "DRAFT" &&
                                        viewmodel.statusField.value
                                                ?.lookupValue !=
                                            "ABANDONED"
                                    ? Visibility(
                                        visible: viewmodel.isVisible,
                                        child: ResolutionWidget(
                                          resolvemodulevisible: false,
                                          onresolve: () {
                                            return viewmodel.resolvesr();
                                          },
                                          viewModel: viewmodel,
                                        ),
                                      )
                                    : Container(),
                                UIHelper.verticalSpaceMedium(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: SemnoxFlatButton(
                                        child: SemnoxText.subtitle(
                                            style: const TextStyle(
                                                color: Colors.white),
                                            text: viewmodel.statusField.value
                                                        ?.lookupValue ==
                                                    "DRAFT"
                                                ? Messages.saveAndFinalizeButton
                                                : Messages.saveButton),
                                        onPressed: () {
                                          viewmodel.saveServiceRequestDetails(
                                              context);
                                        },
                                      )),
                                      SizedBox(
                                          width: 20.mapToIdealWidth(context)),
                                      Expanded(
                                          child: SemnoxFlatButton(
                                        child: const SemnoxText.subtitle(
                                            style:
                                                TextStyle(color: Colors.white),
                                            text: Messages.cancelButton),
                                        onPressed: () {
                                          Modular.to.pop(context);
                                        },
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]);
            }),
      ),
    );
  }
}
