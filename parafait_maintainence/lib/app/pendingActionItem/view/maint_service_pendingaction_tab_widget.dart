import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/parafait_home/view_model/pendingActionTab_viewmodel.dart';
import 'package:parafait_maintainence/app/widget/layout/maint_service_tab_Widget.dart';
import 'package:parafait_maintainence/app/widget/layout/maint_taskdue_widget.dart';
import 'package:parafait_maintainence/routes.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/bl/maintainence_bl.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/screen_utils/uihelper.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';

class PendingActionItems extends StatefulWidget {
  final int? taskgroupid;

  const PendingActionItems({Key? key, required this.taskgroupid})
      : super(key: key);

  @override
  State<PendingActionItems> createState() => _nameState();
}

class _nameState extends State<PendingActionItems>
    with SingleTickerProviderStateMixin {
  int changeContents = 1;
  int? tabindex = 0;
  DateTime? date = DateTime.now();
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SemnoxScaffold(
      bodyPadding: EdgeInsets.zero,
      appBar: SemnoxAppBar(
        title: SemnoxText.subtitle(
          text: widget.taskgroupid != null
              ? Messages.taskgroup
              : Messages.pendingAction,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Modular.to.pushNamedAndRemoveUntil(AppRoutes.home, (p0) => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                setState(() {
                  if (changeContents == 1) {
                    changeContents = 2;
                  } else {
                    changeContents = 1;
                  }
                });
              },
              child: tabindex != 0
                  ? changeContents == 1
                      ? Image.asset('assets/icons/shrinkicon.png')
                      : Image.asset('assets/icons/hamberger_menu.png')
                  : Container())
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: DatePicker(
              DateTime.now().subtract(const Duration(days: 3)),
              initialSelectedDate: DateTime.now(),
              // activeDates: [
              //   DateTime.now().subtract(Duration(days: 3)),
              //   DateTime.now().add(Duration(days: 3))
              // ],
              daysCount: 7,
              selectionColor: SemnoxTheme.maintprimaryColor,
              selectedTextColor: Colors.white,
              monthTextStyle: const TextStyle(fontSize: 16),
              dayTextStyle: const TextStyle(fontSize: 16),
              dateTextStyle: const TextStyle(fontSize: 16),
              onDateChange: (datevalue) {
                setState(() {
                  date = datevalue;
                });
              },
            ),
          ),
          Flexible(
            child: Consumer(builder: (context, ref, child) {
              final viewmodel = ref.watch(PendingActionTabViewModel.provider(
                  PendingAction(
                      dateTime: date,
                      taskgroupid: widget.taskgroupid,
                      tabindex: tabindex)));
              return StreamBuilder<ActionCount?>(
                  stream: viewmodel.pendingController,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                          child: SemnoxCircleLoader(
                        color: Colors.red,
                      ));
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          height: 5,
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SemnoxText.subtitle(
                                    text: 'ACTION ITEMS',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SemnoxText(
                                    text:
                                        "${snapshot.data?.pendingcount.round()} / ${snapshot.data?.totalcount.round()}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpaceMedium(),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: snapshot.data?.percent,
                                  minHeight: 6,
                                  backgroundColor:
                                      const Color.fromRGBO(243, 245, 245, 1),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          SemnoxTheme.maintprimaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TabBar(
                            isScrollable: true,
                            indicatorColor: SemnoxTheme.maintprimaryColor,
                            indicatorWeight: 4,
                            unselectedLabelColor: Colors.black,
                            labelColor: Colors.red,
                            onTap: (int index) {
                              setState(() {
                                tabindex = index;
                              });
                            },
                            tabs: [
                              const Tab(
                                child: SemnoxText.bodyMed1(
                                  text: Messages.taskDue,
                                  style: TextStyle(
                                      color: Color.fromRGBO(34, 34, 34, 1),
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              widget.taskgroupid == null
                                  ? const Tab(
                                      child: SemnoxText.bodyMed1(
                                        text: Messages.serviceRequest,
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(34, 34, 34, 1),
                                            fontWeight: FontWeight.normal),
                                      ),
                                    )
                                  : Container()
                            ],
                            controller: _tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                          ),
                        ),
                        Flexible(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              TaskDueWidget(
                                  taskgroupid: widget.taskgroupid,
                                  dateTime: date ?? DateTime.now(),
                                  changeContents: changeContents),
                              widget.taskgroupid == null
                                  ? MaintainenceRequestWidget(
                                      dateTime: date ?? DateTime.now(),
                                      changeContents: changeContents)
                                  : Container()
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }
}
