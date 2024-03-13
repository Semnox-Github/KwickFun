import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/tasks/view_model/tasks_filterviewmodel.dart';
import 'package:semnox_core/modules/hr/model/user_container_dto.dart';
import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/modules/maintenance/assets/model/asset_dto.dart';
import 'package:semnox_core/modules/maintenance/task/model/task_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/screen_utils/uihelper.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';
import 'package:semnox_core/widgets/input_fields/date_field/date_field.dart';

class TaskModalSheet extends ConsumerWidget {
  final Function callback;
  final String? menuclick;

  const TaskModalSheet({Key? key, required this.callback, this.menuclick})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(TaskFilterViewmodel.provider(menuclick!));
    return DataProviderBuilder<bool>(
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
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: const SemnoxText.subtitle(
                      text: 'Search Filter',
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
                      SemnoxDropdownField<GenericAssetDTO>(
                        border: false,
                        properties: viewmodel.assetField,
                        enabled: viewmodel.assetField.enabled,
                        position: LabelPosition.inside,
                      ),
                      UIHelper.verticalSpaceMedium(),
                      SemnoxDropdownField<TaskDto>(
                        border: false,
                        properties: viewmodel.taskField,
                        enabled: viewmodel.taskField.enabled,
                        position: LabelPosition.inside,
                      ),
                      viewmodel.assignedUserFielddropdown == true
                          ? UIHelper.verticalSpaceMedium()
                          : Container(),
                      viewmodel.assignedUserFielddropdown == true
                          ? SemnoxDropdownField<UserContainerDto>(
                              border: false,
                              properties: viewmodel.assigneduserField,
                              enabled: viewmodel.assignedUserFielddropdown,
                              position: LabelPosition.inside,
                            )
                          : Container(),
                      UIHelper.verticalSpaceMedium(),
                      SemnoxDropdownField<LookupValuesContainerDtoList>(
                        border: false,
                        properties: viewmodel.statusField,
                        enabled: false,
                        position: LabelPosition.inside,
                      ),
                      UIHelper.verticalSpaceMedium(),
                      SemnoxDateFormField(
                        enabled: viewmodel.scheduleFromFieldenabled,
                        border: false,
                        properties: viewmodel.scheduleFromField,
                        position: LabelPosition.inside,
                      ),
                      UIHelper.verticalSpaceMedium(),
                      SemnoxDateFormField(
                        enabled: viewmodel.scheduleToFieldenabled,
                        border: false,
                        properties: viewmodel.scheduleToField,
                        position: LabelPosition.inside,
                      ),
                      Row(
                        children: [
                          SemnoxCheckBox(properties: viewmodel.jobpastDueDate)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SemnoxPopUpTwoButtons(
                              outlineButtonText: Messages.cancelButton,
                              filledButtonText: Messages.applyButton,
                              onFilledButtonPressed: () {
                                callback(viewmodel);
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
        });
  }
}
