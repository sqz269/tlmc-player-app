import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:spotube/collections/routes.gr.dart';
import 'package:spotube/collections/spotube_icons.dart';
import 'package:spotube/components/titlebar/titlebar.dart';
import 'package:spotube/extensions/constrains.dart';
import 'package:spotube/models/database/database.dart';
import 'package:spotube/provider/user_preferences/user_preferences_provider.dart';
import 'package:spotube/utils/platform.dart';
import 'package:spotube/modules/connect/connect_device.dart';
import 'package:spotube/extensions/context.dart';

@RoutePage()
class RadioPage extends HookConsumerWidget {
  static const name = "radio";

  const RadioPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    final controller = useScrollController();
    final mediaQuery = MediaQuery.of(context);
    final layoutMode =
        ref.watch(userPreferencesProvider.select((s) => s.layoutMode));

    return SafeArea(
      bottom: false,
      child: Scaffold(
        headers: [
          if (kTitlebarVisible) const TitleBar(height: 30),
        ],
        child: CustomScrollView(
          controller: controller,
          slivers: [
            if (mediaQuery.smAndDown || layoutMode == LayoutMode.compact)
              SliverAppBar(
                floating: true,
                title: DefaultTextStyle(
                  style: TextStyle(
                    fontFamily: "Cookie",
                    fontSize: 30,
                    letterSpacing: 1.8,
                    color: theme.colorScheme.foreground,
                  ),
                  child: const Text("Spotube"),
                ),
                backgroundColor: theme.colorScheme.background,
                foregroundColor: theme.colorScheme.foreground,
                actions: [
                  const ConnectDeviceButton(),
                  const Gap(10),
                  IconButton.ghost(
                    icon: const Icon(SpotubeIcons.settings, size: 20),
                    onPressed: () {
                      context.navigateTo(const SettingsRoute());
                    },
                  ),
                  const Gap(10),
                ],
              )
            else if (kIsMacOS)
              const SliverGap(10),
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        SpotubeIcons.radio,
                        size: 80,
                        color: theme.colorScheme.primary,
                      ),
                      const Gap(20),
                      Text(
                        "Radio",
                        style: theme.typography.large.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        "Coming Soon",
                        style: theme.typography.base.copyWith(
                          color: theme.colorScheme.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

