import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parafait_maintainence/app/settings/view_model/setting_view_model.dart';
import 'package:parafait_maintainence/routes.dart';
import 'package:parafait_maintainence/themes.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/message.dart';
import '../../provider/app_version_provider.dart';

class SemnoxAppSettingsScreen extends StatelessWidget {
  const SemnoxAppSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SemnoxScaffold(
      bodyPadding: SemnoxPadding.zero,
      appBar: SemnoxAppBar(
        leading: InkWell(
          onTap: () => Modular.to.pushReplacementNamed("${AppRoutes.home}/"),
          child:
              SemnoxIcons.arrowLeft.toIcon(size: 40.mapToIdealWidth(context)),
        ),
        title: SemnoxText.h6(
          text: Messages.settings,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SemnoxTabView(title: [
        SemnoxText(text: Messages.app),
      ], tabs: const [
        _AppTab(),
      ]),
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
                  showtrailingIcon: false,
                  title: Text(Messages.serveraddress),
                  // onPressed: () {
                  //   viewModel.navigateTonetworkscreen();
                  // },
                  trailing: SemnoxText(
                      text: viewModel.getExecutionContext()?.apiUrl ?? "--",
                      style: AppThemes
                                  .names[DynamicTheme.of(context)?.themeId] !=
                              "Light"
                          ? const TextStyle(fontSize: 18, color: Colors.white)
                          : const TextStyle(fontSize: 18, color: Colors.black)),
                ),
                SemnoxListTileWithIcon(
                  title: Text(Messages.loginId),
                  trailing: SemnoxText(
                      text: viewModel.getExecutionContext()?.loginId ?? "--",
                      style: AppThemes
                                  .names[DynamicTheme.of(context)?.themeId] !=
                              "Light"
                          ? const TextStyle(fontSize: 18, color: Colors.white)
                          : const TextStyle(fontSize: 18, color: Colors.black)),
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
                  trailing: SemnoxText(
                      text:
                          AppThemes.names[DynamicTheme.of(context)?.themeId] ??
                              "Light",
                      style: AppThemes
                                  .names[DynamicTheme.of(context)?.themeId] !=
                              "Light"
                          ? const TextStyle(fontSize: 18, color: Colors.white)
                          : const TextStyle(fontSize: 18, color: Colors.black)),
                ),
                SemnoxListTileWithIcon(
                  title: Text(Messages.macaddress),
                  trailing: SemnoxText(
                      text: viewModel.getExecutionContext()?.posMachineName ??
                          "--",
                      style: AppThemes
                                  .names[DynamicTheme.of(context)?.themeId] !=
                              "Light"
                          ? const TextStyle(fontSize: 18, color: Colors.white)
                          : const TextStyle(fontSize: 18, color: Colors.black)),
                ),
                SemnoxListTileWithIcon(
                  title: Text(Messages.version),
                  trailing: ref.watch(appVersionProvider).when(
                        data: (value) => SemnoxText(
                            text: value.version,
                            style: AppThemes.names[
                                        DynamicTheme.of(context)?.themeId] !=
                                    "Light"
                                ? const TextStyle(
                                    fontSize: 18, color: Colors.white)
                                : const TextStyle(
                                    fontSize: 18, color: Colors.black)),
                        loading: () => const SemnoxText(
                          text: "",
                          style: TextStyle(fontSize: 18),
                        ),
                        error: (a, b) => const SemnoxText(
                          text: "--",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                ),
                SemnoxListTileWithIcon(
                  title: Text(Messages.buildnumber),
                  trailing: ref.watch(appVersionProvider).when(
                        data: (value) => SemnoxText(
                            text: value.buildNumber,
                            style: AppThemes.names[
                                        DynamicTheme.of(context)?.themeId] !=
                                    "Light"
                                ? const TextStyle(
                                    fontSize: 18, color: Colors.white)
                                : const TextStyle(
                                    fontSize: 18, color: Colors.black)),
                        loading: () => const SemnoxText(
                          text: "",
                          style: TextStyle(fontSize: 18),
                        ),
                        error: (a, b) => const SemnoxText(
                          text: "--",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                ),
                SemnoxListTileWithIcon(
                  title: Text(Messages.packagename),
                  trailing: ref.watch(appVersionProvider).when(
                        data: (value) => SemnoxText(
                            text: value.packageName,
                            style: AppThemes.names[
                                        DynamicTheme.of(context)?.themeId] !=
                                    "Light"
                                ? const TextStyle(
                                    fontSize: 18, color: Colors.white)
                                : const TextStyle(
                                    fontSize: 18, color: Colors.black)),
                        loading: () => const SemnoxText(
                          text: "",
                          style: TextStyle(fontSize: 18),
                        ),
                        error: (a, b) => const SemnoxText(
                          text: "--",
                          style: TextStyle(fontSize: 18),
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
