import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_ride/app/game_ride/provider/selected_game_machines.dart';
import 'package:game_ride/app/settings/view_model/setting_view_model.dart';
import 'package:game_ride/routes.dart';
import 'package:game_ride/themes.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import '../../provider/app_version_provider.dart';

class SemnoxAppSettingsScreen extends StatelessWidget {
  const SemnoxAppSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Modular.to.pushReplacementNamed("${AppRoutes.home}/");
        return false;
      },
      child: SemnoxScaffold(
        bodyPadding: SemnoxPadding.zero,
        appBar: SemnoxAppBar(
          automaticallyImplyLeading: true,
          leading: InkWell(
            onTap: () => Modular.to.pushReplacementNamed("${AppRoutes.home}/"),
            child:
                SemnoxIcons.arrowLeft.toIcon(size: 40.mapToIdealWidth(context)),
          ),
          title: SemnoxText.h4(
            text: Messages.settings,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: SemnoxTabView(title: [
          SemnoxText.h5(text: Messages.app),
          SemnoxText.h5(text: Messages.games),
        ], tabs: const [
          _AppTab(),
          _GamesTab(),
        ]),
      ),
    );
  }
}

class _AppTab extends ConsumerStatefulWidget {
  const _AppTab({Key? key}) : super(key: key);

  @override
  ConsumerState<_AppTab> createState() => _AppTabState();
}

class _AppTabState extends ConsumerState<_AppTab> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(SettingViewModel.provider);
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(height: 10.mapToIdealHeight(context)),
            ListTileGroup(
              children: [
                SemnoxListTileWithIcon(
                  showtrailingIcon: true,
                  title: Text(Messages.serveraddress),
                  onPressed: () {
                    viewModel.navigateTonetworkscreen();
                  },
                  trailing: SemnoxText.bodyReg1(
                      text: viewModel.getExecutionContext()?.apiUrl ?? "--",
                      style: AppThemes
                                  .names[DynamicTheme.of(context)?.themeId] !=
                              "Light"
                          ? const TextStyle(fontSize: 25, color: Colors.white)
                          : const TextStyle(fontSize: 25, color: Colors.black)),
                ),
                SemnoxListTileWithIcon(
                  title: Text(Messages.loginId),
                  trailing: SemnoxText.bodyReg1(
                      text: viewModel.getExecutionContext()?.loginId ?? "--",
                      style: AppThemes
                                  .names[DynamicTheme.of(context)?.themeId] !=
                              "Light"
                          ? const TextStyle(fontSize: 25, color: Colors.white)
                          : const TextStyle(fontSize: 25, color: Colors.black)),
                ),
                // SemnoxListTileWithIcon(
                //   title: Text("User Type"),
                //   trailing: Container(
                //     child: SemnoxText(
                //       text: "Executive",
                //       style: const TextStyle(fontSize: 18),
                //     ),
                //   ),
                // ),
                // SemnoxListTileWithIcon(
                //   title: Text("Card Reader Type"),
                //   trailing: Container(
                //     child: SemnoxText(
                //       text: "HF TAB - NFC",
                //       style: const TextStyle(fontSize: 18),
                //     ),
                //   ),
                // ),
                // SemnoxListTileWithIcon(
                //   title: Text("Function Type"),
                //   trailing: Container(
                //     child: SemnoxText(
                //       text: "Read Only",
                //       style: const TextStyle(fontSize: 18),
                //     ),
                //   ),
                // ),
                // SemnoxListTileWithIcon(
                //   title: Text("Bar Code Reader"),
                //   trailing: Container(
                //     child: Icon(
                //       CupertinoIcons.forward,
                //       size: 20,
                //     ),
                //   ),
                // ),
                // SemnoxListTileWithIcon(
                //   title: Text("Credit Card Reader Type"),
                //   trailing: Container(
                //     child: Icon(
                //       CupertinoIcons.forward,
                //       size: 20,
                //     ),
                //   ),
                // ),
                SemnoxListTileWithIcon(
                  showtrailingIcon: true,
                  onPressed: () {
                    DynamicTheme.of(context)?.setTheme(
                        DynamicTheme.of(context)?.themeId == 0 ? 1 : 0);
                    setState(() {});
                  },
                  title: const Text("App Theme"),
                  trailing: SemnoxText.bodyReg1(
                      text:
                          AppThemes.names[DynamicTheme.of(context)?.themeId] ??
                              "Light",
                      style: AppThemes
                                  .names[DynamicTheme.of(context)?.themeId] !=
                              "Light"
                          ? const TextStyle(fontSize: 25, color: Colors.white)
                          : const TextStyle(fontSize: 25, color: Colors.black)),
                ),
                SemnoxListTileWithIcon(
                  title: Text(Messages.macaddress),
                  trailing: SemnoxText.bodyReg1(
                      text: viewModel.getExecutionContext()?.posMachineName ??
                          "--",
                      style: AppThemes
                                  .names[DynamicTheme.of(context)?.themeId] !=
                              "Light"
                          ? const TextStyle(fontSize: 25, color: Colors.white)
                          : const TextStyle(fontSize: 25, color: Colors.black)),
                ),
                SemnoxListTileWithIcon(
                  title: Text(Messages.version),
                  trailing: ref.watch(appVersionProvider).when(
                        data: (value) => SemnoxText.bodyReg1(
                            text: value.version,
                            style: AppThemes.names[
                                        DynamicTheme.of(context)?.themeId] !=
                                    "Light"
                                ? const TextStyle(
                                    fontSize: 25, color: Colors.white)
                                : const TextStyle(
                                    fontSize: 25, color: Colors.black)),
                        loading: () => const SemnoxText(
                          text: "",
                          style: TextStyle(fontSize: 25),
                        ),
                        error: (a, b) => const SemnoxText(
                          text: "--",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                ),
                SemnoxListTileWithIcon(
                  title: Text(Messages.buildnumber),
                  trailing: ref.watch(appVersionProvider).when(
                        data: (value) => SemnoxText.bodyReg1(
                            text: value.buildNumber,
                            style: AppThemes.names[
                                        DynamicTheme.of(context)?.themeId] !=
                                    "Light"
                                ? const TextStyle(
                                    fontSize: 25, color: Colors.white)
                                : const TextStyle(
                                    fontSize: 25, color: Colors.black)),
                        loading: () => const SemnoxText(
                          text: "",
                          style: TextStyle(fontSize: 25),
                        ),
                        error: (a, b) => const SemnoxText(
                          text: "--",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                ),
                SemnoxListTileWithIcon(
                  title: Text(Messages.packagename),
                  trailing: ref.watch(appVersionProvider).when(
                        data: (value) => SemnoxText.bodyReg1(
                            text: value.packageName,
                            style: AppThemes.names[
                                        DynamicTheme.of(context)?.themeId] !=
                                    "Light"
                                ? const TextStyle(
                                    fontSize: 25, color: Colors.white)
                                : const TextStyle(
                                    fontSize: 25, color: Colors.black)),
                        loading: () => const SemnoxText(
                          text: "",
                          style: TextStyle(fontSize: 25),
                        ),
                        error: (a, b) => const SemnoxText(
                          text: "--",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PosTab extends StatelessWidget {
  const _PosTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: 10.mapToIdealHeight(context),
            // color: Colors.transparent,
            // color:  SemnoxConstantColor.grey(context),
          ),
          ListTileGroup(
            children: [
              const SemnoxListTileWithIcon(
                title: Text("Shift Status"),
                trailing: Icon(
                  CupertinoIcons.forward,
                  size: 20,
                ),
              ),
              SemnoxListTileWithIcon(
                title: const Text("Last Open Time"),
                trailing: Container(
                  child: const SemnoxText(
                    text: "12/Jan/2018 14:13",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SemnoxListTileWithIcon(
                title: const Text("Refund Allowed"),
                trailing: Container(
                  child: const SemnoxText(
                    text: "No",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          Container(
              height: 10.mapToIdealHeight(context), color: Colors.transparent),
          const ListTileGroup(
            children: [
              SemnoxListTileWithIcon(
                title: Text("Max Load Bonous"),
              ),
              SemnoxListTileWithIcon(
                title: Text("Max Load Tickets"),
              ),
              SemnoxListTileWithIcon(
                title: Text("Max Load Points"),
              ),
              SemnoxListTileWithIcon(
                title: Text("Load Bonous Left"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GamesTab extends ConsumerWidget {
  const _GamesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var viewmodel = ref.watch(SelectedGameMachinesNotifier.provider);
    String selectedMachine = "Not Set";
    if (viewmodel.machines!.isNotEmpty) {
      selectedMachine = viewmodel.machines!.first.gameName;
    }
    if (viewmodel.machines!.length > 1) {
      selectedMachine += " +${viewmodel.machines!.length - 1} more";
    }
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: 10.mapToIdealHeight(context),
            color: Colors.transparent,
          ),
          ListTileGroup(
            children: [
              SemnoxListTileWithIcon(
                title: const Text("Game Machine"),
                showtrailingIcon: true,
                trailing: SemnoxText.bodyReg1(
                    text: selectedMachine, //"Amutec Bull",
                    style: AppThemes.names[DynamicTheme.of(context)?.themeId] !=
                            "Light"
                        ? const TextStyle(fontSize: 25, color: Colors.white)
                        : const TextStyle(fontSize: 25, color: Colors.black)),
                onPressed: () {
                  viewmodel.checkusermanagerAccess(AppRoutes.machines);
                },
              ),
              // SemnoxListTileWithIcon(
              //   title: Text("Price"),
              //   trailing: Container(
              //     child: SemnoxText(
              //       text: "1.0",
              //     ),
              //   ),
              // ),
              // SemnoxListTileWithIcon(
              //   title: Text("VIP Price"),
              //   trailing: Container(
              //     child: SemnoxText(
              //       text: "0.0",
              //     ),
              //   ),
              // ),
            ],
          ),
          Container(
            height: 10.mapToIdealHeight(context),
            color: Colors.transparent,
          ),
          // ListTileGroup(
          //
          //   children: [
          //     SemnoxListTileWithIcon(
          //       title: Text("Credits Before Bonous"),
          //       trailing: Container(
          //         child: SemnoxText(
          //           text: "10",
          //           style: const TextStyle(fontSize: 18),
          //         ),
          //       ),
          //     ),
          //     SemnoxListTileWithIcon(
          //       title: Text("Credits Allowed"),
          //       trailing: Container(
          //         child: SemnoxText(
          //           text: "Yes",
          //           style: const TextStyle(fontSize: 18),
          //         ),
          //       ),
          //     ),
          //     SemnoxListTileWithIcon(
          //       title: Text("Bonous Allowed"),
          //       trailing: Container(
          //         child: SemnoxText(
          //           text: "No",
          //           style: const TextStyle(fontSize: 18),
          //         ),
          //       ),
          //     ),
          //     SemnoxListTileWithIcon(
          //       title: Text("Courstesy Allowed"),
          //       trailing: Container(
          //         child: SemnoxText(
          //           text: "Yes",
          //           style: const TextStyle(fontSize: 18),
          //         ),
          //       ),
          //     ),
          //     SemnoxListTileWithIcon(
          //       title: Text("Creditplus Allowed"),
          //     ),
          //     SemnoxListTileWithIcon(
          //       title: Text("Game Profile ID"),
          //       trailing: Container(
          //         child: SemnoxText(
          //           text: "255",
          //           style: const TextStyle(fontSize: 18),
          //         ),
          //       ),
          //     ),
          //     SemnoxListTileWithIcon(
          //       title: Text("Game ID"),
          //       trailing: Container(
          //         child: SemnoxText(
          //           text: "255",
          //           style: const TextStyle(fontSize: 18),
          //         ),
          //       ),
          //     ),
          //     SemnoxListTileWithIcon(
          //       title: Text("Game Allowed"),
          //     ),
          //     SemnoxListTileWithIcon(
          //       title: Text("Sync Frequency"),
          //     ),
          //     SemnoxListTileWithIcon(
          //       title: Text("Sync Number"),
          //     ),
          //     SemnoxListTileWithIcon(
          //       title: Text("Game Left to Sync"),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
