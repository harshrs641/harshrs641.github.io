import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/data/assets.dart';
import 'package:portfolio/data/constants.dart';

// import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import 'package:transparent_image/transparent_image.dart';


class AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 250,
                width: 250,
                child: ClipOval(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned.fill(
                          child: Container(color: Colors.grey[100])),
                      Positioned.fill(
                        child: FadeInImage.memoryNetwork(
                          image: Assets.avatar,
                          fit: BoxFit.cover,
                          placeholder: kTransparentImage,
                        ),
                      ),
                    ],
                  ),
                ),
                // decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     image: DecorationImage(
                //       image: Image.asset(Assets.avatar, fit: BoxFit.cover,).image,fit: BoxFit.cover
                //     )),
                // radius: 100,
                // backgroundImage:
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Harsh Raj Singh',
                textScaleFactor: 4,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Senior Developer @Spring Edge Technologies \n Flutter | Android Developer | iOS Developer',
                style: Theme.of(context).textTheme.caption,
                textScaleFactor: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: new InkWell(
                    child: new Text(
                      'Checkout my Curriculum Vitae',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                      textScaleFactor: 2,
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => launch(
                        'https://drive.google.com/file/d/1kt7_C4TAigTgRNXgBJvZi4fwvDDPETcU/view?usp=sharing')),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(Assets.github)),
                    label: Text('Github'),
                    onPressed: () =>
                        html.window.open(Constants.PROFILE_GITHUB, 'harsh'),
                  ),
                  FlatButton.icon(
                    icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(Assets.gitlab)),
                    label: Text('GitLab'),
                    onPressed: () =>
                        html.window.open(Constants.PROFILE_GITLAB, 'harsh'),
                  ),
                  FlatButton.icon(
                    icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(Assets.linkedin)),
                    label: Text('Linkedin'),
                    onPressed: () =>
                        html.window.open(Constants.PROFILE_LINKEDIN, 'harsh'),
                  )
                ],
              ),
              SizedBox(height: 120),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("Made with Flutter"))
            ],
          ),
        ),
      ),
    );
  }
}
