// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/service_request/view_model/service_request_detail_viewmodel.dart';
import 'package:parafait_maintainence/app/tasks/view_model/taskdetails_viewmodel.dart';
import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/maintainence_service_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/screen_utils/uihelper.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';
import 'package:semnox_core/widgets/input_fields/date_field/date_field.dart';

class CreateServiceRequest extends ConsumerWidget {
  CheckListDetailDTO? checkListDetailDTO;
  CreateServiceRequest({this.checkListDetailDTO, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(ServiceRequestDetailViewmodel.provider(
        TaskDetailData(
            checkListDetailDTO: checkListDetailDTO, menuClick: "Draft")));
    viewmodel.context = context;
    return WillPopScope(
      onWillPop: () {
        Modular.to.pop(context);
        return Future.value(false);
      },
      child: SemnoxScaffold(
        bodyPadding: EdgeInsets.zero,
        appBar: SemnoxAppBar(
          title: const SemnoxText.subtitle(
            text: 'My Draft Requests',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () async {
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      )),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: viewmodel.formKey,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                UIHelper.verticalSpaceSmall(),
                                SemnoxTextFormField(
                                    border: false,
                                    enabled: false,
                                    position: LabelPosition.inside,
                                    properties: viewmodel.requestNoField),
                                UIHelper.verticalSpaceMedium(),
                                SemnoxDropdownField<
                                    LookupValuesContainerDtoList>(
                                  border: false,
                                  properties: viewmodel.statusField,
                                  enabled: viewmodel.statusField.enabled,
                                  position: LabelPosition.inside,
                                ),
                              ],
                            ),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxDateFormField(
                              enabled: false,
                              border: false,
                              properties: viewmodel.requestDateField,
                              position: LabelPosition.inside,
                            ),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxDropdownField<GenericAssetDTO>(
                              border: false,
                              properties: viewmodel.assetField,
                              enabled: viewmodel.assetField.enabled,
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
                              position: LabelPosition.inside,
                            ),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxDropdownField<LookupValuesContainerDtoList>(
                              border: false,
                              properties: viewmodel.requestField,
                              enabled: viewmodel.requestField.enabled,
                              position: LabelPosition.inside,
                            ),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxTextFormField(
                                maxLength: 500,
                                border: false,
                                position: LabelPosition.inside,
                                properties: viewmodel.requestTitleField),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxTextFormField(
                                maxLength: 500,
                                border: false,
                                maxLines: 6,
                                textAlign: TextAlign.start,
                                position: LabelPosition.inside,
                                properties: viewmodel.requestDetailsField),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxDropdownField<LookupValuesContainerDtoList>(
                              border: false,
                              properties: viewmodel.priorityField,
                              position: LabelPosition.inside,
                            ),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxTextFormField(
                                maxLength: 200,
                                border: false,
                                position: LabelPosition.inside,
                                properties: viewmodel.contactPersonField),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxTextFormField(
                                maxLength: 50,
                                // inputFormatters:
                                //     LengthLimitingTextInputFormatter(10),
                                border: false,
                                position: LabelPosition.inside,
                                properties: viewmodel.phoneField),
                            UIHelper.verticalSpaceMedium(),
                            SemnoxTextFormField(
                                maxLength: 200,
                                border: false,
                                position: LabelPosition.inside,
                                properties: viewmodel.emailField),
                            UIHelper.verticalSpaceMedium(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 0,
                                  ),
                                  Expanded(
                                    child: SemnoxFlatButton(
                                      child: const SemnoxText.subtitle(
                                        text: "SAVE",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        try {
                                          if ((viewmodel.formKey.currentState
                                                  ?.validate() ??
                                              true)) {
                                            viewmodel.formKey.currentState
                                                ?.save();

                                            await viewmodel
                                                .createServiceRequest(context);
                                          }
                                        } catch (e) {
                                          SemnoxSnackbar.error(context, "$e");
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]);
            }),
      ),
    );
  }
}
