import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:parafait_maintainence/app/service_request/view_model/service_request_viewmodel.dart';
import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';
import 'package:semnox_core/widgets/elements/data_provider_builder.dart';
import 'package:semnox_core/widgets/elements/text.dart';
import 'package:semnox_core/widgets/input_fields/dropdown_field.dart';
import 'package:semnox_core/widgets/input_fields/properties/input_field_properties.dart';

class ServiceRequestListView extends StatefulWidget {
  final ServiceRequestViewModel viewModel;

  const ServiceRequestListView({Key? key, required this.viewModel})
      : super(key: key);

  @override
  State<ServiceRequestListView> createState() => _AppTabState();
}

class _AppTabState extends State<ServiceRequestListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
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
            return Container(
              color: Colors.grey[200],
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  LayoutBuilder(builder: (context, constraints) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: SizedBox(
                              width: 300.0,
                              child: SemnoxDropdownField<
                                  LookupValuesContainerDtoList>(
                                fillColor: Colors.transparent,
                                border: false,
                                properties: widget.viewModel.statusField,
                                enabled: true,
                                position: LabelPosition.inside,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.4,
                            child: SizedBox(
                              width: 300.0,
                              child: SemnoxDropdownField<
                                  LookupValuesContainerDtoList>(
                                fillColor: Colors.transparent,
                                border: false,
                                properties: widget.viewModel.priorityField,
                                enabled: true,
                                position: LabelPosition.inside,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  Flexible(
                      child: widget.viewModel.maintainenceservicedto != null &&
                              widget
                                  .viewModel.maintainenceservicedto!.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: widget
                                  .viewModel.maintainenceservicedto!
                                  .where((t) => t.maintJobName!
                                      .toLowerCase()
                                      .contains(widget.viewModel.searchQuery!
                                          .toLowerCase()))
                                  .toList()
                                  .length,
                              itemBuilder: (context, index) {
                                var maintainenceservicedto = widget
                                    .viewModel.maintainenceservicedto!
                                    .where((t) => t.maintJobName!
                                        .toLowerCase()
                                        .contains(widget.viewModel.searchQuery!
                                            .toLowerCase()))
                                    .toList();
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      widget.viewModel
                                          .navigateToServicedetailScreen(
                                              maintainenceservicedto[index],
                                              widget.viewModel.menuclick);
                                    },
                                    child: Slidable(
                                      key: Key(maintainenceservicedto[index]
                                          .Id
                                          .toString()),
                                      controller:
                                          widget.viewModel.slidableController,
                                      direction: Axis.horizontal,
                                      actionPane:
                                          const SlidableBehindActionPane(),
                                      dismissal: SlidableDismissal(
                                        dismissThresholds: const <
                                            SlideActionType, double>{
                                          SlideActionType.secondary: 1.0
                                        },
                                        onDismissed: (actionType) {
                                          if (actionType ==
                                              SlideActionType.secondary) {}
                                        },
                                        child: const SlidableDrawerDismissal(),
                                      ),
                                      actionExtentRatio: widget.viewModel
                                              .swipeenabled(widget.viewModel
                                                  .getStatusName(
                                                      maintainenceservicedto[
                                                              index]
                                                          .status))!
                                          ? 0.34
                                          : 0,
                                      secondaryActions: <Widget>[
                                        IconSlideAction(
                                          iconWidget: const SemnoxText.button(
                                            text: "MARK AS\nRESOLVED",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          icon: Icons.check,
                                          color: Colors.red,
                                          onTap: () async {
                                            await widget.viewModel
                                                .showMarkasResolvedModalsheet(
                                                    maintainenceservicedto[
                                                        index]);
                                          },
                                        )
                                      ],
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Card(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: Colors.white70,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        flex: 2,
                                                        child:
                                                            SemnoxText.subtitle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: true,
                                                          text:
                                                              maintainenceservicedto[
                                                                      index]
                                                                  .maintJobName
                                                                  .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    238,
                                                                    134,
                                                                    100,
                                                                    1),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child:
                                                            SemnoxText.button(
                                                          text: widget.viewModel
                                                              .maintainanceLookupsAndRulesRepository
                                                              ?.changeDateAndTimeForCommentsCard(widget
                                                                          .viewModel
                                                                          .menuclick !=
                                                                      "Recent"
                                                                  ? maintainenceservicedto[
                                                                          index]
                                                                      .chklstScheduleTime
                                                                      .toString()
                                                                  : maintainenceservicedto[
                                                                          index]
                                                                      .appLastUpdatedTime
                                                                      .toString()),
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    102,
                                                                    102,
                                                                    102,
                                                                    1),
                                                          ),
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
                                                        text:
                                                            maintainenceservicedto[
                                                                    index]
                                                                .assetName
                                                                .toString(),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Color.fromRGBO(
                                                              102, 102, 102, 1),
                                                        ),
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
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SemnoxText
                                                              .bodyReg1(
                                                            textScaleFactor:
                                                                0.7,
                                                            text: "Priority",
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      102,
                                                                      102,
                                                                      102,
                                                                      1),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 10.0),
                                                          SemnoxText.bodyReg1(
                                                            textScaleFactor:
                                                                0.7,
                                                            text: widget
                                                                .viewModel
                                                                .getPriorityName(
                                                                    maintainenceservicedto[
                                                                            index]
                                                                        .priority!)
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      102,
                                                                      102,
                                                                      102,
                                                                      1),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          width: 5.0),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SemnoxText
                                                                  .bodyReg1(
                                                                textScaleFactor:
                                                                    0.7,
                                                                text: "Status"
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          102,
                                                                          102,
                                                                          102,
                                                                          1),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10.0),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SemnoxText
                                                                  .bodyReg1(
                                                                textScaleFactor:
                                                                    0.7,
                                                                text: widget
                                                                    .viewModel
                                                                    .getStatusName(
                                                                        maintainenceservicedto[index]
                                                                            .status)
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          102,
                                                                          102,
                                                                          102,
                                                                          1),
                                                                ),
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
                              })
                          : const Center(
                              child: SemnoxText.bodyMed1(
                                text: Messages.noSRFound,
                              ),
                            )),
                ],
              ),
            );
          }),
    );
  }
}
