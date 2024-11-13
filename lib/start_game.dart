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
                width: 350,
                'assets/images/logo-menu.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 + 15,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8A9C8E), Color(0xFF545967)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    value,
                                    style: GoogleFonts.lilitaOne(
                                      fontSize: 35,
                                      letterSpacing: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 80),
                                ],
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
                  ),
                  const SizedBox(
                    height: 25,
                  ),
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
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 100,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFC49758),
                              Color(0xFF944F4A),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            "Start",
                            style: GoogleFonts.lilitaOne(
                              fontSize: 50,
                              letterSpacing: 2,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
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
                                const SizedBox(height: 10),
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
                                constraints:
                                    const BoxConstraints(maxHeight: 300),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      'Easy Mood: Time 80',
                                      style:
                                          GoogleFonts.lilitaOne(fontSize: 18),
                                    ),
                                    Text(
                                      'Medium Mood: Time 50',
                                      style:
                                          GoogleFonts.lilitaOne(fontSize: 18),
                                    ),
                                    Text(
                                      'Hard Mood: Time 30',
                                      style:
                                          GoogleFonts.lilitaOne(fontSize: 18),
                                    ),
                                    const SizedBox(height: 20),
                                    ..._buildImageRows([
                                      [
                                        'assets/images/target1.png',
                                        'Score +1',
                                        'assets/images/target2.png',
                                        'Score +2'
                                      ],
                                      [
                                        'assets/images/target3.png',
                                        'Score +3',
                                        'assets/images/nontarget1.png',
                                        'Score -1'
                                      ],
                                      [
                                        'assets/images/nontarget2.png',
                                        'Score -2',
                                        'assets/images/nontarget3.png',
                                        'Score -3'
                                      ],
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF8A9C8E),
                                        Color(0xFF545967)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "Close",
                                    style: GoogleFonts.lilitaOne(
                                      fontSize: 20,
                                      letterSpacing: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 5),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8A9C8E), Color(0xFF545967)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.info,
                          color: Colors.white,
                          size: 50,
                        ),
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
          Expanded(
            child: _buildImage(data[0], data[1]),
          ),
          const SizedBox(width: 3),
          Expanded(
            child: _buildImage(data[2], data[3]),
          ),
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
