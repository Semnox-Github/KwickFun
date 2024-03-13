import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/service_request/view_model/service_request_viewmodel.dart';
import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/screen_utils/uihelper.dart';
import 'package:semnox_core/widgets/input_fields/date_field/date_field.dart';

class ServiceRequestModalSheet extends ConsumerWidget {
  // final Function callback;
  final String? menuclick;
  final ServiceRequestViewModel? srViewModel;

  const ServiceRequestModalSheet({Key? key, this.menuclick, this.srViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: const SemnoxText.subtitle(
                text: "Search Filter",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const Divider(
            height: 5,
            thickness: 2,
          ),
          UIHelper.verticalSpaceSmall(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SemnoxDropdownField<LookupValuesContainerDtoList>(
                  border: false,
                  properties: srViewModel!.statusField,
                  enabled: srViewModel!.statusField.enabled,
                  position: LabelPosition.inside,
                ),
                UIHelper.verticalSpaceMedium(),
                SemnoxDropdownField<LookupValuesContainerDtoList>(
                  border: false,
                  properties: srViewModel!.requestField,
                  enabled: srViewModel!.requestField.enabled,
                  position: LabelPosition.inside,
                ),
                UIHelper.verticalSpaceMedium(),
                SemnoxDropdownField<LookupValuesContainerDtoList>(
                  border: false,
                  properties: srViewModel!.priorityField,
                  enabled: srViewModel!.priorityField.enabled,
                  position: LabelPosition.inside,
                ),
                UIHelper.verticalSpaceMedium(),
                SemnoxDateFormField(
                  border: false,
                  properties: srViewModel!.scheduleFromDateField,
                  position: LabelPosition.inside,
                ),
                UIHelper.verticalSpaceMedium(),
                SemnoxDateFormField(
                  border: false,
                  properties: srViewModel!.scheduleToDateField,
                  position: LabelPosition.inside,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SemnoxPopUpTwoButtons(
                        outlineButtonText: Messages.cancelButton,
                        filledButtonText: Messages.applyButton,
                        onFilledButtonPressed: () {
                          srViewModel?.getServiceSearchFilter();
                        },
                        onOutlineButtonPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
