import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:parafait_maintainence/app/tasks/view_model/tasks_viewmodel.dart';
import 'package:parafait_maintainence/themes.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';

class TaskListView extends StatefulWidget {
  final TasksViewModel viewModel;

  const TaskListView({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<TaskListView> createState() => _AppTabState();
}

class _AppTabState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DataProviderBuilder<bool>(
          enableAnimation: false,
          dataProvider: widget.viewModel.loadstates,
          loader: (context) {
            return const Center(
              child: SemnoxCircleLoader(
                color: Colors.red,
              ),
            );
          },
          builder: (context, snapshot) {
            if (widget.viewModel.maintainenceservicedto != null &&
                widget.viewModel.maintainenceservicedto!.isNotEmpty) {
              return Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.viewModel.maintainenceservicedto!
                        .where((t) => t.taskName!.toLowerCase().contains(
                            widget.viewModel.searchQuery!.toLowerCase()))
                        .toList()
                        .length,
                    itemBuilder: (context, index) {
                      var maintainenceservicedto = widget
                          .viewModel.maintainenceservicedto!
                          .where((t) => t.taskName!.toLowerCase().contains(
                              widget.viewModel.searchQuery!.toLowerCase()))
                          .toList();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            widget.viewModel.navigatetotaskdetail(
                                maintainenceservicedto[index],
                                widget.viewModel.menuclick);
                          },
                          child: Slidable(
                            key: Key(
                                maintainenceservicedto[index].Id.toString()),
                            controller: widget.viewModel.slidableController,
                            direction: Axis.horizontal,
                            actionPane: const SlidableBehindActionPane(),
                            dismissal: SlidableDismissal(
                              dismissThresholds: const <SlideActionType,
                                  double>{SlideActionType.secondary: 1.0},
                              onDismissed: (actionType) {
                                if (actionType == SlideActionType.secondary) {}
                              },
                              child: const SlidableDrawerDismissal(),
                            ),
                            actionExtentRatio: widget.viewModel.swipeenabled(
                                    widget.viewModel.getJobStatusName(
                                        maintainenceservicedto[index].status))!
                                ? 0.34
                                : 0,
                            secondaryActions: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: IconSlideAction(
                                  iconWidget: const SemnoxText.button(
                                    text: "MARK AS\n CHECKED",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  icon: Icons.check,
                                  color: Colors.red,
                                  onTap: () async {
                                    await widget.viewModel
                                        .showMarkasCheckedModalsheet(
                                            maintainenceservicedto[index]);
                                  },
                                ),
                              ),
                            ],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: SemnoxText.subtitle(
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                text: maintainenceservicedto[
                                                        index]
                                                    .taskName
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      238, 134, 100, 1),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: SemnoxText.button(
                                                text: widget.viewModel
                                                    .maintainanceLookupsAndRulesRepository
                                                    ?.changeDateAndTimeForCommentsCard(
                                                        maintainenceservicedto[
                                                                index]
                                                            .creationDate
                                                            .toString()),
                                                style: AppThemes.names[
                                                            DynamicTheme.of(
                                                                    context)
                                                                ?.themeId] !=
                                                        "Light"
                                                    ? const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white)
                                                    : const TextStyle(
                                                        fontSize: 18,
                                                        color: Color.fromRGBO(
                                                            102, 102, 102, 1)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SemnoxText.button(
                                              textScaleFactor: 0.7,
                                              text:
                                                  maintainenceservicedto[index]
                                                      .assetName
                                                      .toString(),
                                              style: AppThemes.names[
                                                          DynamicTheme.of(
                                                                  context)
                                                              ?.themeId] !=
                                                      "Light"
                                                  ? const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white)
                                                  : const TextStyle(
                                                      fontSize: 18,
                                                      color: Color.fromRGBO(
                                                          102, 102, 102, 1)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                              color: Color.fromRGBO(
                                                  102, 102, 102, 1),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SemnoxText.bodyReg1(
                                                    textScaleFactor: 0.7,
                                                    text: "Assign to",
                                                    style: AppThemes.names[
                                                                DynamicTheme.of(
                                                                        context)
                                                                    ?.themeId] !=
                                                            "Light"
                                                        ? const TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white)
                                                        : const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Color.fromRGBO(
                                                                    102,
                                                                    102,
                                                                    102,
                                                                    1))),
                                                const SizedBox(height: 10.0),
                                                SemnoxText.bodyReg1(
                                                  textScaleFactor: 0.7,
                                                  text: widget.viewModel
                                                      .getUserNamebyId(
                                                          maintainenceservicedto[
                                                                  index]
                                                              .assignedUserId!)
                                                      .toString(),
                                                  style: AppThemes.names[
                                                              DynamicTheme.of(
                                                                      context)
                                                                  ?.themeId] !=
                                                          "Light"
                                                      ? const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white)
                                                      : const TextStyle(
                                                          fontSize: 18,
                                                          color: Color.fromRGBO(
                                                              102,
                                                              102,
                                                              102,
                                                              1)),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 5.0),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SemnoxText.bodyReg1(
                                                      textScaleFactor: 0.7,
                                                      text: "Status".toString(),
                                                      style: AppThemes.names[
                                                                  DynamicTheme.of(
                                                                          context)
                                                                      ?.themeId] !=
                                                              "Light"
                                                          ? const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white)
                                                          : const TextStyle(
                                                              fontSize: 18,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      102,
                                                                      102,
                                                                      102,
                                                                      1)),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SemnoxText.bodyReg1(
                                                      textScaleFactor: 0.7,
                                                      text: widget.viewModel
                                                          .getJobStatusName(
                                                              maintainenceservicedto[
                                                                      index]
                                                                  .status)
                                                          .toString(),
                                                      style: AppThemes.names[
                                                                  DynamicTheme.of(
                                                                          context)
                                                                      ?.themeId] !=
                                                              "Light"
                                                          ? const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white)
                                                          : const TextStyle(
                                                              fontSize: 18,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      102,
                                                                      102,
                                                                      102,
                                                                      1)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return const Center(
                child: SemnoxText.bodyMed1(
                  text: Messages.noTaskFound,
                ),
              );
            }
          }),
    );
  }
}
