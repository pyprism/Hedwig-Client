import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hedwig_client/app/theme/theme_controller.dart';
import 'package:hedwig_client/features/auth/domain/entities/auth_state.dart';
import 'package:hedwig_client/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hedwig_client/features/settings/presentation/controllers/density_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _externalImagesPreferenceKey = 'always_show_external_images';

const _timezones = [
  'UTC',
  'America/New_York',
  'America/Chicago',
  'America/Denver',
  'America/Los_Angeles',
  'Europe/London',
  'Europe/Paris',
  'Europe/Berlin',
  'Asia/Kolkata',
  'Asia/Dhaka',
  'Asia/Tokyo',
  'Asia/Shanghai',
  'Australia/Sydney',
];

const _locales = ['en', 'fr', 'de', 'es', 'pt', 'ja', 'zh', 'bn'];

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _alwaysShowExternalImages = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _alwaysShowExternalImages =
          prefs.getBool(_externalImagesPreferenceKey) ?? false;
    });
  }

  Future<void> _setExternalImages(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_externalImagesPreferenceKey, value);
    if (!mounted) return;
    setState(() => _alwaysShowExternalImages = value);
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeControllerProvider);
    final density = ref.watch(messageDensityProvider);
    final authState = ref.watch(authControllerProvider).value;
    final user = switch (authState) {
      Authenticated(:final user) => user,
      MustChangePassword(:final user) => user,
      _ => null,
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // ── Profile ──────────────────────────────────────────────
          if (user != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Profile',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  (user.displayName ?? user.username)
                      .substring(0, 1)
                      .toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              title: Text(user.displayName ?? user.username),
              subtitle: Text(user.email),
              trailing: const Icon(Icons.edit_outlined),
              onTap: () => _showProfileDialog(
                context,
                ref,
                user.displayName,
                user.firstName,
                user.lastName,
                user.timezone,
                user.locale,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.lock_reset),
              title: const Text('Change password'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/change-password'),
            ),
            const Divider(),
          ],

          // ── Appearance ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'Appearance',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.system,
                  icon: Icon(Icons.brightness_auto),
                  label: Text('Auto'),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  icon: Icon(Icons.light_mode),
                  label: Text('Light'),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  icon: Icon(Icons.dark_mode),
                  label: Text('Dark'),
                ),
              ],
              selected: {themeMode},
              onSelectionChanged: (modes) => ref
                  .read(themeControllerProvider.notifier)
                  .setMode(modes.first),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'compact',
                  icon: Icon(Icons.density_small),
                  label: Text('Compact'),
                ),
                ButtonSegment(
                  value: 'comfortable',
                  icon: Icon(Icons.density_medium),
                  label: Text('Comfort'),
                ),
                ButtonSegment(
                  value: 'relaxed',
                  icon: Icon(Icons.density_large),
                  label: Text('Relaxed'),
                ),
              ],
              selected: {density},
              onSelectionChanged: (values) => ref
                  .read(messageDensityProvider.notifier)
                  .setDensity(values.first),
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.image_outlined),
            title: const Text('Show external images'),
            subtitle: const Text('Applies to remote images in message bodies'),
            value: _alwaysShowExternalImages,
            onChanged: _setExternalImages,
          ),
          const Divider(),

          // ── Organise ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'Organise',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.filter_alt_outlined),
            title: const Text('Mail rules'),
            subtitle: const Text('Auto-organise incoming messages'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/rules'),
          ),
          ListTile(
            leading: const Icon(Icons.label_outline),
            title: const Text('Labels'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/labels'),
          ),
          const Divider(),

          // ── Admin ─────────────────────────────────────────────────
          if (user?.isStaff == true) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                'Administration',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings_outlined),
              title: const Text('Admin panel'),
              subtitle: const Text('Providers, domains, users, access grants'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/admin'),
            ),
            const Divider(),
          ],

          // ── Account ───────────────────────────────────────────────
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () => ref.read(authControllerProvider.notifier).logout(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Future<void> _showProfileDialog(
    BuildContext context,
    WidgetRef ref,
    String? currentDisplayName,
    String? currentFirstName,
    String? currentLastName,
    String? currentTimezone,
    String? currentLocale,
  ) async {
    final displayNameCtrl = TextEditingController(
      text: currentDisplayName ?? '',
    );
    final firstNameCtrl = TextEditingController(text: currentFirstName ?? '');
    final lastNameCtrl = TextEditingController(text: currentLastName ?? '');
    String? selectedTz = currentTimezone;
    String? selectedLocale = currentLocale;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('Edit profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: displayNameCtrl,
                  decoration: const InputDecoration(labelText: 'Display name'),
                  autofocus: true,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: firstNameCtrl,
                  decoration: const InputDecoration(labelText: 'First name'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: lastNameCtrl,
                  decoration: const InputDecoration(labelText: 'Last name'),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedTz,
                  decoration: const InputDecoration(labelText: 'Timezone'),
                  items: _timezones
                      .map((tz) => DropdownMenuItem(value: tz, child: Text(tz)))
                      .toList(),
                  onChanged: (v) => setState(() => selectedTz = v),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedLocale,
                  decoration: const InputDecoration(labelText: 'Locale'),
                  items: _locales
                      .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                      .toList(),
                  onChanged: (v) => setState(() => selectedLocale = v),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                String? nullIfEmpty(String s) =>
                    s.trim().isEmpty ? null : s.trim();
                ref
                    .read(authControllerProvider.notifier)
                    .updateProfile(
                      displayName: nullIfEmpty(displayNameCtrl.text),
                      firstName: nullIfEmpty(firstNameCtrl.text),
                      lastName: nullIfEmpty(lastNameCtrl.text),
                      timezone: selectedTz,
                      locale: selectedLocale,
                    );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    displayNameCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
  }
}
