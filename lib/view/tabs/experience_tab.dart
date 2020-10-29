import 'package:flutter/material.dart';
import 'package:portfolio/components/project_card.dart';
import 'package:portfolio/components/responsive_widget.dart';
import 'package:portfolio/data/projects.dart';
import 'package:portfolio/data/tech_stack.dart';
// import 'package:portfolio/models/experience_main_page.dart';

import 'dart:math';



// import 'experience_row.dart';

import 'qualification_tab.dart';

class ExperienceTab extends StatefulWidget {
  @override
  _ExperienceTabState createState() => _ExperienceTabState();
}

class _ExperienceTabState extends State<ExperienceTab> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildPart(),
    );
  }

  Widget _buildPart() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildMyExperiencesHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [     Padding(
                  padding: new EdgeInsets.only(left: 64.0, top: 40),
                  child: Text(
                    "ONGOING",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                OngoingProjects(),
                Padding(
                  padding: new EdgeInsets.only(left: 64.0),
                  child: Text(
                    "COMPLETED",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                // _buildExperiencesList(),
                CompletedProjects(),
           
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExperiencesList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ResponsiveWidget(
        largeScreen: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
            crossAxisCount: 3,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1),
            children:
                List.generate(techStack.length, (index) => techStack[index])),
        smallScreen: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: techStack.length,
          itemBuilder: (context, index) => techStack[index],
        ),
      ),
    );
  }

  Widget _buildMyExperiencesHeader() {
    return new Padding(
        padding: new EdgeInsets.only(left: 64.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              'Experiences',
              style: new TextStyle(fontSize: 24.0),
            ),
            new Text(
                'Senior Developer @Spring Edge Technologies',
                style: new TextStyle(color: Colors.grey, fontSize: 18.0))
          ],
        ));
  }

  // Widget _buildTimeline() {
  //   return new Positioned(
  //     top: 0.0,
  //     bottom: 0.0,
  //     left: 32.0,
  //     child: new Container(width: 1.0, color: Colors.grey[300]),
  //   );
  // }
}


class CompletedProjects extends StatelessWidget {
  Random random = new Random();
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        // padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
        crossAxisCount: 3,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.3),
        children: List.generate(
          completedProjects.length,
          (index) =>
              ProjectWidget(completedProjects[index], 0, random.nextInt(5000)),
        ),
      ),
      smallScreen: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: completedProjects.length,
          itemBuilder: (context, index) => ProjectWidget(
              completedProjects[index],
              (index == completedProjects.length - 1 ? 16.0 : 0),
              random.nextInt(5000))),
    );
  }
}

class OngoingProjects extends StatelessWidget {
  Random random = new Random();
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        // padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
        crossAxisCount: 3,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.3),
        children: List.generate(
          ongoingProjects.length,
          (index) =>
              ProjectWidget(ongoingProjects[index], 0, random.nextInt(5000)),
        ),
      ),
      smallScreen: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: ongoingProjects.length,
          itemBuilder: (context, index) => ProjectWidget(
              ongoingProjects[index],
              (index == ongoingProjects.length - 1 ? 16.0 : 0),
              random.nextInt(5000))),
    );
  }
}
