import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin panel'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Back to mail',
          onPressed: () => context.go('/inbox'),
        ),
      ),
      body: ListView(
        children: const [
          _AdminTile(
            icon: Icons.dns_outlined,
            title: 'Email providers',
            subtitle: 'Manage SMTP/API sending providers',
            route: '/admin/providers',
          ),
          _AdminTile(
            icon: Icons.language,
            title: 'Domains',
            subtitle: 'Domains and DNS verification checklist',
            route: '/admin/domains',
          ),
          _AdminTile(
            icon: Icons.inbox_outlined,
            title: 'Mailboxes',
            subtitle: 'Create and manage all mailboxes',
            route: '/admin/mailboxes',
          ),
          _AdminTile(
            icon: Icons.people_outline,
            title: 'Users',
            subtitle: 'User accounts and staff access',
            route: '/admin/users',
          ),
          _AdminTile(
            icon: Icons.key_outlined,
            title: 'Access grants',
            subtitle: 'Grant mailbox/domain access to users',
            route: '/admin/access',
          ),
          _AdminTile(
            icon: Icons.track_changes,
            title: 'Delivery events',
            subtitle: 'Per-message delivery tracking',
            route: '/admin/delivery',
          ),
        ],
      ),
    );
  }
}

class _AdminTile extends StatelessWidget {
  const _AdminTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push(route),
    );
  }
}
