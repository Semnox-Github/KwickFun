import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:parafait_maintainence/app/service_request/view_model/service_request_viewmodel.dart';
import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/screen_utils/uihelper.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';

class MaintServiceRequestExpandableView extends StatefulWidget {
  final ServiceRequestViewModel viewModel;

  const MaintServiceRequestExpandableView({Key? key, required this.viewModel})
      : super(key: key);

  @override
  State<MaintServiceRequestExpandableView> createState() => _AppTabState();
}

class _AppTabState extends State<MaintServiceRequestExpandableView> {
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
                                  .viewModel.maintainenceservicedto?.length,
                              itemBuilder: (context, index) {
                                final dto = widget
                                    .viewModel.maintainenceservicedto?[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 8.0),
                                  child: Slidable(
                                    key: Key(dto!.Id.toString()),
                                    controller:
                                        widget.viewModel.slidableController,
                                    direction: Axis.horizontal,
                                    actionPane:
                                        const SlidableBehindActionPane(),
                                    dismissal: SlidableDismissal(
                                      dismissThresholds: const <SlideActionType,
                                          double>{
                                        SlideActionType.secondary: 1.0
                                      },
                                      onDismissed: (actionType) {
                                        if (actionType ==
                                            SlideActionType.secondary) {}
                                      },
                                      child: const SlidableDrawerDismissal(),
                                    ),
                                    actionExtentRatio: widget.viewModel
                                                .getStatusName(dto.status)
                                                .toString() !=
                                            'CLOSED'
                                        ? 0.34
                                        : 0,
                                    secondaryActions: <Widget>[
                                      // Commented by Gaurav Duth Baliga on 22-04-2022 to est
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        child: IconSlideAction(
                                          icon: Icons.check,
                                          color: Colors.red,
                                          caption: "MARK AS\nRESOLVED",
                                          onTap: () async {
                                            await widget.viewModel
                                                .showMarkasResolvedModalsheet(
                                                    dto);
                                          },
                                        ),
                                      ),
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
                                                        text: dto.maintJobName
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              238, 134, 100, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                        flex: 1,
                                                        child:
                                                            SemnoxText.bodyReg1(
                                                          text: widget.viewModel
                                                              .maintainanceLookupsAndRulesRepository
                                                              ?.changeDateAndTimeForCommentsCard(dto
                                                                  .chklstScheduleTime
                                                                  .toString()),
                                                        )),
                                                  ],
                                                ),
                                                const SizedBox(height: 10.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SemnoxText.bodyReg1(
                                                      text: dto.assetName
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
                                                const SizedBox(height: 20.0),
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
                                                          textScaleFactor: 0.7,
                                                          text: "Priority",
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    102,
                                                                    102,
                                                                    102,
                                                                    1),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10.0),
                                                        SemnoxText.bodyReg1(
                                                          textScaleFactor: 0.7,
                                                          text: widget.viewModel
                                                              .getPriorityName(
                                                                  dto.priority!)
                                                              .toString(),
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
                                                      ],
                                                    ),
                                                    const SizedBox(width: 5.0),
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
                                                            SemnoxText.bodyReg1(
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
                                                            SemnoxText.bodyReg1(
                                                              textScaleFactor:
                                                                  0.7,
                                                              text: widget
                                                                  .viewModel
                                                                  .getStatusName(
                                                                      dto.status)
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
                                                const SizedBox(height: 20.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SemnoxText.bodyMed2(
                                                      text: dto.requestDetail
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
                                                UIHelper.verticalSpaceMedium(),
                                                Row(children: [
                                                  SizedBox(
                                                      width: 20.mapToIdealWidth(
                                                          context)),
                                                  Expanded(
                                                    child: SemnoxFlatButton(
                                                        child: const SemnoxText
                                                            .subtitle(
                                                          text: 'RESOLVE',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        onPressed: () async {
                                                          await widget.viewModel
                                                              .showMarkasResolvedModalsheet(
                                                                  dto);
                                                        }),
                                                  ),
                                                  SizedBox(
                                                      width: 20.mapToIdealWidth(
                                                          context)),
                                                  Expanded(
                                                    child: SemnoxFlatButton(
                                                      child: const SemnoxText
                                                          .subtitle(
                                                        text: 'VIEW DETAILS',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onPressed: () {
                                                        widget.viewModel
                                                            .navigateToServicedetailScreen(
                                                                dto,
                                                                widget.viewModel
                                                                    .menuclick);
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: 20.mapToIdealWidth(
                                                          context)),
                                                ]),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
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
