import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/tasks/view_model/tasks_viewmodel.dart';
import 'package:parafait_maintainence/app/widget/layout/maint_task_listview_widget.dart';
import 'package:parafait_maintainence/routes.dart';
import 'package:parafait_maintainence/themes.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/screen_utils/uihelper.dart';
import 'package:semnox_core/utils/text_style.dart';

class TaskTabWidget extends ConsumerWidget {
  final String menuclick;

  const TaskTabWidget({Key? key, required this.menuclick}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final viewmodel =
        ref.watch(TasksViewModel.provider(TabData(menuclick: menuclick)));
    viewmodel.context = context;
    return WillPopScope(
      onWillPop: () {
        Modular.to.pushNamedAndRemoveUntil(AppRoutes.home, (p0) => false);
        return Future.value(false);
      },
      child: SemnoxScaffold(
        bodyPadding: EdgeInsets.zero,
        appBar: SemnoxAppBar(
          title: const SemnoxText.subtitle(
            text: "Task",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Modular.to.pushNamedAndRemoveUntil(AppRoutes.home, (p0) => false);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SemnoxTabView(
            index: viewmodel.tabIndex,
            onTabChange: (value) => viewmodel.updatetabindex(value),
            title: [
              for (var item in viewmodel.menulist)
                SemnoxText.subtitle(textScaleFactor: 0.4, text: item)
            ],
            tabs: [
              for (int i = 0; i < viewmodel.menulist.length; i++)
                Flexible(
                    child: Column(
                  children: [
                    UIHelper.verticalSpaceMedium(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 3,
                          child: TextField(
                            onChanged: (value) {
                              viewmodel.search(value);
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Search",
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              isDense: true,
                            ),
                            style: SemnoxTextStyle.subtitle(context),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: InkWell(
                            child: SemnoxText.subtitle(
                                textScaleFactor: 0.9,
                                text: "FILTER",
                                style: AppThemes.names[DynamicTheme.of(context)
                                            ?.themeId] !=
                                        "Light"
                                    ? const TextStyle(
                                        fontSize: 18, color: Colors.white)
                                    : TextStyle(
                                        fontSize: 18, color: Colors.red[900])),
                            onTap: () async {
                              await viewmodel.showFilter(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceMedium(),
                    TaskListView(viewModel: viewmodel),
                  ],
                ))
            ]),
      ),
    );
  }
}
