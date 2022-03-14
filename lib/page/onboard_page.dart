import 'package:ewipe/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            buildPage(
              color: Colors.green.shade100,
              urlImage: 'assets/images/page1.png',
              title: 'Reduce',
              subtitle: 'Hello it'
                  's me like you You need to click REQUEST first before you will get access to THIS Source Code and of all my other Flutter Videos.',
            ),
            buildPage(
                color: Colors.blue.shade100,
                urlImage: 'assets/images/page2.png',
                title: 'ReCycle',
                subtitle:
                    'Soda PDF Creator Online offers a full set of features directly in your web browser. Create, manage, convert, edit, annotate & secure PDFs on any device.'),
            buildPage(
                color: Colors.orange.shade100,
                urlImage: 'assets/images/page4.png',
                title: 'Reuse',
                subtitle:
                    'أتشعرُ أنّك مرهقٌ جداً يا فتى؟ متعبٌ من كلّ شيءٍ، وساخطٌ على كلّ شيءْ، تبدُو لِي كذلك، وعيناكَ الضيّقتانِ، تزيدانِ من حدّتكْ، كلّما اكتملتْ تلكَ العقدةُ الّتي تعلُو وجهكْ'),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  primary: Colors.white,
                  backgroundColor: Colors.teal.shade700,
                  minimumSize: const Size.fromHeight(80)),
              child: const Text(
                'Get started',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () async {
                //_bottomSheet(context);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      child: const Text('Skip'),
                      onPressed: () => controller.jumpToPage(2)),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                    ),
                  ),
                  TextButton(
                      child: const Text('Next'),
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut)),
                ],
              ),
            ),
    );
  }
}

Widget buildPage({
  required Color color,
  required String urlImage,
  required String title,
  required String subtitle,
}) =>
    Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            urlImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(
            height: 64,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.teal.shade700,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              subtitle,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
              textDirection: TextDirection.rtl,
            ),
          )
        ],
      ),
    );
