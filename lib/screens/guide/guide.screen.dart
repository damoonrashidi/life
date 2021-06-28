import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life/widgets/sign-in.widget.dart';

class GuideScreen extends StatefulWidget {
  static const route = '/guide';

  const GuideScreen({Key? key}) : super(key: key);

  @override
  createState() => GuideScreenState();
}

class GuideScreenState extends State<GuideScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      children: [
        const GuidePageViewPage(
            header:
                'Link your calendar to automatically track your recurring activities.',
            description:
                'Any events recognized by Life will be automatically tracked, the rest will be ignored.',
            imageUrl: 'assets/images/calendar.png'),
        const GuidePageViewPage(
            header: 'Report activities via the Google Assistant',
            description: '“Hey Google, I just sent a 7A today”',
            imageUrl: 'assets/images/google-home.png'),
        const GuidePageViewPage(
            header: 'Get breakdowns on the activities that matter to you.',
            description:
                'Plots and charts! Get details over time for all of your tracked activities.',
            imageUrl: 'assets/images/chart-demo-2.png'),
        Center(child: SignInWithGoogle()),
      ],
    ));
  }
}

class GuidePageViewPage extends StatelessWidget {
  final String header;
  final String description;
  final String imageUrl;

  const GuidePageViewPage(
      {Key? key,
      required this.header,
      required this.description,
      required this.imageUrl})
      : super(key: key);

  @override
  build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(64),
              child: Text(header,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w300,
                      textStyle: Theme.of(context).textTheme.headline5))),
          Image.asset(
            imageUrl,
          ),
          Padding(
              padding: const EdgeInsets.all(64),
              child: Text(description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      textStyle: Theme.of(context).textTheme.bodyText1))),
        ],
      );
}
