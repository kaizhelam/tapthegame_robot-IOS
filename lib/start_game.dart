import 'package:flutter/material.dart';
import 'package:tapthetarget_robot/mobile_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class StartGame extends StatefulWidget {
  const StartGame({super.key});

  @override
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  String _selectedDifficulty = 'Easy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/menu-bg.jpg'),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/logo-menu.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 + 50,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize
                    .min,
                children: [
                  // Game Info Button
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                Center(
                                  child: Text(
                                    'Game Info',
                                    style: GoogleFonts.lilitaOne(fontSize: 40),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    'Tap targets to score! Each target has different points—be quick, but watch out for targets that lower your score. Can you get the highest score before time up?',
                                    style: GoogleFonts.lilitaOne(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            content: SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxHeight: 300),
                                child: Column(
                                  children: [
                                    // New Text widget above the images
                                    const SizedBox(height: 10),
                                    Text(
                                      'Easy Mood: Time 80',
                                      style: GoogleFonts.lilitaOne(fontSize: 18),
                                    ),
                                    Text(
                                      'Medium Mood: Time 50',
                                      style: GoogleFonts.lilitaOne(fontSize: 18),
                                    ),
                                    Text(
                                      'Hard Mood: Time 30',
                                      style: GoogleFonts.lilitaOne(fontSize: 18),
                                    ),
                                    const SizedBox(height: 20),
                                    ..._buildImageRows([
                                      ['assets/images/target1.png', 'Score +1', 'assets/images/target2.png', 'Score +2'],
                                      ['assets/images/target3.png', 'Score +3', 'assets/images/nontarget1.png', 'Score -1'],
                                      ['assets/images/nontarget2.png', 'Score -2', 'assets/images/nontarget3.png', 'Score -3'],
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Close",
                                  style: GoogleFonts.lilitaOne(
                                    fontSize: 20,
                                    letterSpacing: 2,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF8A9C8E),
                            Color(0xFF545967),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Game Info",
                            style: GoogleFonts.lilitaOne(
                              fontSize: 35,
                              letterSpacing: 2,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.info,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16), // Space between buttons
                  GestureDetector(
                    onTap: () {
                      // Handle dropdown menu action
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF8A9C8E),
                            Color(0xFF545967),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedDifficulty,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedDifficulty = newValue!;
                          });
                        },
                        items: <String>['Easy', 'Medium', 'Hard']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: GoogleFonts.lilitaOne(
                                fontSize: 35,
                                letterSpacing: 2,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }).toList(),
                        dropdownColor: Colors.black,
                        iconEnabledColor: Colors.white,
                        underline: const SizedBox.shrink(),
                        iconSize: 35,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16), // Space between buttons
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MobileViewScreen(difficulty: _selectedDifficulty),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF8A9C8E),
                            Color(0xFF545967),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius:
                            BorderRadius.circular(25), // Rounded corners
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Start",
                            style: GoogleFonts.lilitaOne(
                              fontSize: 35,
                              letterSpacing: 2,
                              color: Colors.white, // Text color
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildImageRows(List<List<String>> imageData) {
    return imageData.map((data) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildImage(data[0], data[1]),
          const SizedBox(width: 3),
          _buildImage(data[2], data[3]),
        ],
      );
    }).toList();
  }

  Widget _buildImage(String image, String text) {
    return Row(
      children: [
        Image.asset(image, width: 60, height: 60),
        const SizedBox(width: 3),
        Text(text, style: GoogleFonts.lilitaOne(fontSize: 18)),
      ],
    );
  }
}
