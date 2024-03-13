import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/parafait_home/view_model/sync_details_view_model.dart';
import 'package:parafait_maintainence/app/parafait_home/view_model/sync_view_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/screen_utils/uihelper.dart';
import 'package:semnox_core/utils/utils.dart';
import 'package:semnox_core/widgets/elements/text.dart';
import 'package:semnox_core/widgets/layout/appbar.dart';
import 'package:semnox_core/widgets/layout/scaffold.dart';

class SyncScreenWidget extends ConsumerWidget {
  SyncViewmodel? syncviewmodel;
  SyncScreenWidget(this.syncviewmodel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(SyncDetailViewmodel.provider(syncviewmodel));
    return WillPopScope(
      onWillPop: () {
        Modular.to.pop(context);
        return Future.value(false);
      },
      child: StreamBuilder<SyncData?>(
          stream: viewmodel.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return SemnoxScaffold(
                    bodyPadding: EdgeInsets.zero,
                    appBar: SemnoxAppBar(
                      title: SemnoxText.subtitle(
                        text: snapshot.data!.percent! < 100
                            ? 'Syncing'
                            : 'Syncing Completed',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      leading: IconButton(
                        onPressed: () {
                          Modular.to.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                    body: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: CircularPercentIndicator(
                                          radius: 60.0,
                                          lineWidth: 5.0,
                                          animation: false,
                                          percent:
                                              snapshot.data!.percent! / 100,
                                          center: SemnoxText.subtitle(
                                            text:
                                                "${snapshot.data!.percent!.toInt()}%",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                          backgroundColor: const Color.fromRGBO(
                                              238, 240, 240, 1),
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          progressColor:
                                              snapshot.data!.percent! < 100
                                                  ? const Color.fromRGBO(
                                                      238, 134, 100, 1)
                                                  : const Color.fromRGBO(
                                                      103, 190, 122, 1),
                                        ),
                                      ),
                                      // UIHelper.verticalSpaceSmall(),
                                      // SemnoxText.subtitle(
                                      //   text: snapshot.data!.percent! < 100
                                      //       ? 'STOP SYNC'
                                      //       : 'Sync Again'.toUpperCase(),
                                      //   style: const TextStyle(
                                      //       color:
                                      //           Color.fromRGBO(164, 66, 54, 1),
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SemnoxText.subtitle(
                                        text: 'Connected To',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const SemnoxText.subtitle(
                                        text: 'SEMNOX',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontWeight: FontWeight.normal),
                                      ),
                                      UIHelper.verticalSpaceMedium(),
                                      const SemnoxText.subtitle(
                                        text: 'Last Sync Date',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SemnoxText.subtitle(
                                        textScaleFactor: 0.6,
                                        text: viewmodel.lastsyncdateTime(),
                                        style: const TextStyle(
                                            color: Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontWeight: FontWeight.normal),
                                      ),
                                      UIHelper.verticalSpaceMedium(),
                                      const SemnoxText.subtitle(
                                        text: 'Status',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const SemnoxText.subtitle(
                                        textScaleFactor: 0.6,
                                        text: 'Connected',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        DefaultTabController(
                            initialIndex: viewmodel.tabIndex,
                            length: viewmodel.menulist.length,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TabBar(
                                  isScrollable: true,
                                  indicatorColor: Colors.orange[900],
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicatorWeight: 2,
                                  indicatorPadding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  tabs: [
                                    for (var item in viewmodel.menulist)
                                      Tab(
                                          child: SemnoxText.subtitle(
                                        text: item,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(34, 34, 34, 1),
                                        ),
                                      )),
                                  ],
                                  labelColor: Colors.black,
                                  onTap: (value) =>
                                      viewmodel.updatetabindex(value),
                                ),
                                Container(
                                    height: MediaQuery.of(context).size.height,
                                    color: Colors.grey[200],
                                    child: TabBarView(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: snapshot
                                              .data!.syncdetails!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Flexible(
                                                              child: SemnoxText
                                                                  .subtitle(
                                                                textScaleFactor:
                                                                    0.6,
                                                                text: snapshot
                                                                    .data!
                                                                    .syncdetails![
                                                                        index]
                                                                    .type
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        // fontSize: 20,
                                                                        color: Color.fromRGBO(
                                                                            102,
                                                                            102,
                                                                            102,
                                                                            1)),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Flexible(
                                                              child: SemnoxText
                                                                  .subtitle(
                                                                textScaleFactor:
                                                                    0.6,
                                                                text:
                                                                    '${snapshot.data!.syncdetails![index].insertcount.toString()}/${snapshot.data!.syncdetails![index].totalcount.toString()}',
                                                                style:
                                                                    const TextStyle(
                                                                        // fontSize: 20,
                                                                        color: Color.fromRGBO(
                                                                            102,
                                                                            102,
                                                                            102,
                                                                            1)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Flexible(
                                                              child: SemnoxText
                                                                  .subtitle(
                                                                textScaleFactor:
                                                                    0.6,
                                                                text: snapshot
                                                                    .data!
                                                                    .syncdetails![
                                                                        index]
                                                                    .syncstatus
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        // fontSize: 20,
                                                                        color: Color.fromRGBO(
                                                                            102,
                                                                            102,
                                                                            102,
                                                                            1)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: snapshot
                                              .data!.syncdetails!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (snapshot.data!.syncdetails!
                                                .isNotEmpty) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Flexible(
                                                                child: SemnoxText
                                                                    .subtitle(
                                                                  textScaleFactor:
                                                                      0.6,
                                                                  text: snapshot
                                                                      .data!
                                                                      .syncdetails![
                                                                          index]
                                                                      .type
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                          // fontSize: 20,
                                                                          color: Color.fromRGBO(
                                                                              102,
                                                                              102,
                                                                              102,
                                                                              1)),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Flexible(
                                                                child: SemnoxText
                                                                    .subtitle(
                                                                  textScaleFactor:
                                                                      0.6,
                                                                  text:
                                                                      '${snapshot.data!.syncdetails![index].insertcount.toString()}/${snapshot.data!.syncdetails![index].totalcount.toString()}',
                                                                  style:
                                                                      const TextStyle(
                                                                          // fontSize: 20,
                                                                          color: Color.fromRGBO(
                                                                              102,
                                                                              102,
                                                                              102,
                                                                              1)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Flexible(
                                                                child: SemnoxText
                                                                    .subtitle(
                                                                  textScaleFactor:
                                                                      0.6,
                                                                  text: snapshot
                                                                      .data!
                                                                      .syncdetails![
                                                                          index]
                                                                      .syncstatus
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Color.fromRGBO(
                                                                          102,
                                                                          102,
                                                                          102,
                                                                          1)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return const Center(
                                                child: SemnoxText.bodyMed1(
                                                  text: Messages.noTaskFound,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                      ],
                    ));
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          }),
    );
  }
}
