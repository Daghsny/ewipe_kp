// ignore: avoid_web_libraries_in_flutter

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewipe/page/sound_page.dart';
import 'package:ewipe/provider/google_sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LoggedInWidget extends StatefulWidget {
  const LoggedInWidget({Key? key}) : super(key: key);

  @override
  State<LoggedInWidget> createState() => _LoggedInWidgetState();
}

class _LoggedInWidgetState extends State<LoggedInWidget> {
  final Stream<QuerySnapshot> defi =
      FirebaseFirestore.instance.collection('defit').snapshots();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade300,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      //key: _key, // Assign the key to Scaffold.

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                //_key.currentState!.openDrawer();
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ));
        }),
        title: const Text(
          "Menu",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      drawer: NavigationDrawer(),
      bottomNavigationBar: Container(
        height: 80.0,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
          color: Colors.pink,
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.face,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SoudPage()),
                  );
                },
                icon: const Icon(
                  Icons.book,
                  color: Colors.white,
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {}),
        tooltip: 'اقتراح تحدي',
        child: const Icon(Icons.add),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: defi,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return const Text("erroe!!");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.pink,
              ),
            );
          }
          //var items = snapshot.data?.docs ?? [];

          final data = snapshot.requireData;

          return Stack(
            children: [
              PageView.builder(
                controller: pageController,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.docs.length,
                //itemCount: data.size,
                itemBuilder: (context, index) {
                  //DocumentSnapshot defit = snapshot.data.documents[index];
                  //var colorData = data.docs[index]['color'];
                  return Column(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          color: Colors.pink.shade300,
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(40),
                                    bottomRight: Radius.circular(40))),
                            child: InkWell(
                              onTap: (() {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder:
                                            ((context, animation,
                                                    secondaryAnimation) =>
                                                Scaffold(
                                                  body: SafeArea(
                                                    child: Stack(children: [
                                                      Positioned(
                                                        right: -60,
                                                        child: Image(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1.5,
                                                            image: NetworkImage(
                                                                data.docs[index]
                                                                    [
                                                                    'imgurl'])),
                                                      ),
                                                      SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      32.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 200,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          const snackBar =
                                                                              SnackBar(content: Text('تمت الاضافة الى المفضلة'));
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(snackBar);
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .favorite_border,
                                                                        ),
                                                                        iconSize:
                                                                            30,
                                                                        color: Colors
                                                                            .pink,
                                                                      ),
                                                                      Text(
                                                                        data.docs[index]
                                                                            [
                                                                            'title'],
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .pink,
                                                                            fontFamily:
                                                                                'Taj',
                                                                            fontSize:
                                                                                42.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    data.docs[
                                                                            index]
                                                                        [
                                                                        'eleve'],
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'Taj',
                                                                        fontSize:
                                                                            13.0,
                                                                        fontWeight:
                                                                            FontWeight.w300),
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .black38,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 32,
                                                                  ),
                                                                  SingleChildScrollView(
                                                                    child: Text(
                                                                      data.docs[
                                                                              index]
                                                                          [
                                                                          'subtitle'],
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'TajReg',
                                                                          fontSize:
                                                                              13.0,
                                                                          fontWeight:
                                                                              FontWeight.w300),
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 12,
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .black38,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const Text(
                                                                'معرض الصور'),
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Row(
                                                                children: [
                                                                  Image(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2,
                                                                      image: NetworkImage(
                                                                          data.docs[index]
                                                                              [
                                                                              'imgurl'])),
                                                                  Image(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2,
                                                                      image: NetworkImage(
                                                                          data.docs[index]
                                                                              [
                                                                              'imgurl'])),
                                                                  Image(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          2,
                                                                      image: NetworkImage(
                                                                          data.docs[index]
                                                                              [
                                                                              'imgurl'])),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(Icons
                                                            .arrow_back_ios_new),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ]),
                                                  ),
                                                ))));
                              }),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(32.0),
                                    child: Text(
                                      data.docs[index]['title'],
                                      style: const TextStyle(
                                          fontFamily: 'taj', fontSize: 30),
                                    ),
                                  ),
                                  Center(
                                    child: Image(
                                        //height: MediaQuery.of(context).size.height / 2,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        image: NetworkImage(
                                            data.docs[index]['imgurl'])),
                                  ),
                                  Expanded(child: Container()),
                                  ListTile(
                                    title: Text(
                                      data.docs[index]['eleve'],
                                    ),
                                    subtitle: Text(
                                      data.docs[index]['classe'],
                                    ),
                                    leading: const CircleAvatar(
                                        backgroundColor: Colors.pink,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          color: Colors.pink.shade300,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                              data.docs[index]['subtitle'],
                              style: const TextStyle(color: Colors.white),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                right: 12,
                top: MediaQuery.of(context).size.height / 3.5,
                child: SmoothPageIndicator(
                  effect: WormEffect(activeDotColor: Colors.pink.shade300),
                  axisDirection: Axis.vertical,
                  controller: pageController,
                  count: data.size,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      )),
    );
  }
}

Widget buildHeader(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser!;

  return Container(
    // decoration: const BoxDecoration(
    //   borderRadius: BorderRadius.vertical(
    //     top: Radius.circular(40.0),
    //   ),
    //   color: Colors.pink,
    // ),
    color: Colors.pink,
    padding: EdgeInsets.only(
      top: 24 + MediaQuery.of(context).padding.top,
      bottom: 24,
    ),
    child: Column(
      children: [
        CircleAvatar(
          radius: 42,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.photoURL!),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          user.displayName!.toUpperCase(),
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
        Text(
          user.email!,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ),
      ],
    ),
  );
}

Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const FaIcon(
              Icons.home,
              color: Colors.pink,
            ),
            title: const Text("Home"),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(
              Icons.favorite,
              color: Colors.pink,
            ),
            title: const Text("Favorite"),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(
              Icons.notifications,
              color: Colors.pink,
            ),
            title: const Text("Notifications"),
            onTap: () {},
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            leading: const FaIcon(
              Icons.logout,
              color: Colors.pink,
            ),
            title: const Text("Logout"),
            onTap: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          ),
        ],
      ),
    );
