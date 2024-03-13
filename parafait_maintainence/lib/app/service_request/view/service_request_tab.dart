import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/service_request/view_model/service_request_viewmodel.dart';
import 'package:parafait_maintainence/app/tasks/view_model/tasks_viewmodel.dart';
import 'package:parafait_maintainence/app/widget/layout/maint_service_listview_widget.dart';
import 'package:parafait_maintainence/routes.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/screen_utils/uihelper.dart';
import 'package:semnox_core/utils/text_style.dart';

class ServiceRequestTabWidget extends ConsumerWidget {
  final String menuclick;

  const ServiceRequestTabWidget({Key? key, required this.menuclick})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final viewmodel = ref
        .watch(ServiceRequestViewModel.provider(TabData(menuclick: menuclick)));
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
            text: "Service Request",
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
                      mainAxisSize: MainAxisSize.max,
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
                              text: "FILTER",
                              style: TextStyle(color: Colors.red[900]),
                            ),
                            onTap: () {
                              viewmodel.showFilter(context, viewmodel);
                            },
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceMedium(),
                    ServiceRequestListView(viewModel: viewmodel),
                  ],
                ))
            ]),
      ),
    );
  }
}
