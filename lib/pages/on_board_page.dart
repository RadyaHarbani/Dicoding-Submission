import 'package:flutter/material.dart';
import 'package:flutter_exercise/pages/landing_page.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

int currentIndex = 0;
late PageController pageController;

class _OnBoardingPageState extends State<OnBoardingPage> {
  figmaFontSize(int fontSize) {
    return fontSize * 0.95;
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 30),
              child: Image.asset("assets/logos/logo_hug_horizontal.png"),
            ),
            SizedBox(
              height: 45,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (value) => setState(() {
                    currentIndex = value;
                  }),
                  itemCount: OnBoardingContentList().contentList.length,
                  itemBuilder: (context, index) => OnBoardingContent(
                    image: OnBoardingContentList().contentList[index].image,
                    title: OnBoardingContentList().contentList[index].title,
                    subtitle:
                        OnBoardingContentList().contentList[index].subtitle,
                    description:
                        OnBoardingContentList().contentList[index].description,
                  ),
                ),
              ),
            ),
            currentIndex == OnBoardingContentList().contentList.length - 1
                ? InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LandingPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Center(
                          child: Text(
                            "Get Started",
                            style: GoogleFonts.poppins(
                              fontSize: figmaFontSize(16),
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFAFAFA),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFF375A5A),
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  OnBoardingContentList().contentList.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: DotIndicator(
                      isActive: index == currentIndex,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingContentList {
  final List<OnBoardingContent> contentList = [
    OnBoardingContent(
      image: "assets/images/on_board1.png",
      title: "Sometimes",
      subtitle: "Our life is less organized",
      description:
          "Maintaining a lifestyle includes the discipline to take care of ourselves.",
    ),
    OnBoardingContent(
      image: "assets/images/on_board2.png",
      title: "Pick your path",
      subtitle: "HuG is here for you now :)!",
      description: "Live a happier and more fulfilling life with HuG.",
    ),
    OnBoardingContent(
      image: "assets/images/on_board3.png",
      title: "Feel better and find",
      subtitle: "The help you need is right here",
      description: "Ready to train yourself for happiness?",
    ),
  ];
}

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  final String image, title, subtitle, description;

  @override
  Widget build(BuildContext context) {
    figmaFontSize(int fontSize) {
      return fontSize * 0.95;
    }

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: figmaFontSize(18),
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0F110E),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: figmaFontSize(26),
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F110E),
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Image.asset(
              image,
              width: 200,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
              width: 260,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: figmaFontSize(18),
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0F110E),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 10,
        width: isActive ? 35 : 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color:
              isActive ? Color(0xFF375A5A) : Color(0xFF375A5A).withOpacity(0.5),
        ),
      ),
    );
  }
}
