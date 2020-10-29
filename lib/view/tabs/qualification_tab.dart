import 'package:flutter/material.dart';
import 'package:portfolio/components/responsive_widget.dart';
import 'package:portfolio/data/tech_stack.dart';

class QualificationTab extends StatefulWidget {
  @override
  _QualificationTabState createState() => _QualificationTabState();
}

class _QualificationTabState extends State<QualificationTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPart(),
    );
  }

  Widget _buildPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMyExperiencesHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[_techStackList(), _qualificationList()],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMyExperiencesHeader() {
    return new Padding(
        padding: new EdgeInsets.only(left: 64.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              'Qualification',
              style: new TextStyle(fontSize: 24.0),
            ),
            new Text(
                'Student at University of Engineering and Management, 2018-2022\n\n',
                style: new TextStyle(color: Colors.grey, fontSize: 18.0))
          ],
        ));
  }

  Widget _techStackList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ResponsiveWidget(
        largeScreen: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            // padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
            crossAxisCount: 3,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 2),
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

  Widget _qualificationList() {
    return Padding(
      padding: new EdgeInsets.only(left: 64.0),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 25,
          ),
          Text(
            "Bachelor of Technology (B.Tech), Computer Science",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("University Of Engineering And Management"),
                Text("2018 - 2022"),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Senior Secondary (XII), Science",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Purwanchal Vidhyamandir"),
                Text("(ISC board)"),
                Text("Year of completion: 2018"),
                Text("Percentage: 83.30%"),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Secondary (X)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("St. Joan's School"),
                Text("(ICSE board)"),
                Text("Year of completion: 2016"),
                Text("Percentage: 87.20%")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
