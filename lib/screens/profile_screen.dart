import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

import '../components/circle_image.dart';
import '../fooderlich_pages.dart';
import '../models/models.dart';

import 'dart:io';

class ProfileScreen extends StatefulWidget {
  static MaterialPage page(User user) {
    return MaterialPage(
      name: FooderlichPages.profilePath,
      key: ValueKey(FooderlichPages.profilePath),
      child: ProfileScreen(user: user),
    );
  }

  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            _buildProfile(),
            Expanded(
              child: _buildMenu(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDarkModeRow() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Dark Mode'),
          Switch(
            value: widget.user.darkMode,
            onChanged: (value) {
              Provider.of<ProfileManager>(context, listen: false).darkMode =
                  value;
            },
          )
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Column(
      children: [
        CircleImage(
          imageProvider: AssetImage(widget.user.profileImageUrl),
          imageRadius: 60.0,
        ),
        const SizedBox(height: 16.0),
        Text(
          widget.user.firstName,
          style: const TextStyle(
            fontSize: 21,
          ),
        ),
        Text(widget.user.role),
        Text(
          '${widget.user.points} points',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildMenu() {
    return ListView(
      children: [
        _buildDarkModeRow(),
        ListTile(
          title: const Text('View raywenderlich.com'),
          onTap: () async {
            if (kIsWeb || Platform.isMacOS) {
              await launchUrl(Uri.parse('https://www.raywenderlich.com/'));
            } else {
              Provider.of<ProfileManager>(context, listen: false)
                  .tapOnRaywenderlich(true);
            }
          },
        ),
        ListTile(
          title: const Text('Log out'),
          onTap: () {
            Provider.of<ProfileManager>(context, listen: false)
                .tapOnProfile(false);
            Provider.of<AppStateManager>(context, listen: false).logout();
          },
        )
      ],
    );
  }
}
