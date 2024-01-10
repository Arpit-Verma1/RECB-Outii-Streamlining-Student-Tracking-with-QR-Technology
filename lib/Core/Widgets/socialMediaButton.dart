import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Utils/constant.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () async {
              if (await canLaunchUrl(faceboook_url)) {
                await launchUrl(faceboook_url);
              }
            },
            icon: Icon(
              FontAwesomeIcons.facebook,
              size: 40.0,
              color: Colors.blue,
            )),
        IconButton(
            onPressed: () async {
              if (await canLaunchUrl(twitter_url)) {
                await launchUrl(twitter_url);
              }
            },
            icon: Icon(
              FontAwesomeIcons.twitter,
              size: 40.0,
              color: Colors.blue,
            )),
        IconButton(
          onPressed: () async {
            if (await canLaunchUrl(linkedin_url)) {
              await launchUrl(linkedin_url);
            }
          },
          icon: Icon(
            FontAwesomeIcons.linkedin,
            size: 40.0,
            color: Colors.blue,
          ),
        ),
        IconButton(
            onPressed: () async {
              if (await canLaunchUrl(instagram_url)) {
                await launchUrl(instagram_url);
              }
            },
            icon: Icon(
              FontAwesomeIcons.instagram,
              size: 40.0,
              color: Colors.purpleAccent,
            ))
      ],
    );
  }
}
