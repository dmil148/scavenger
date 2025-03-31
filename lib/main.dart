// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Proxima Nova',
        colorScheme: ColorScheme.light(primary: const Color.fromARGB(255, 70, 29, 124)),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    WelcomePage(),
    TaskPage(),
    MapPage(),
    HelpPage(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            toolbarHeight: 120,
            backgroundColor: const Color.fromARGB(255, 70, 29, 124),
            leadingWidth: 140,
            leading:  Image.asset(
                'assets/lsu_logo.png',
                fit: BoxFit.contain, // Ensure the image fits within its bounds
                height: 100, // Set a larger height for the logo
                width: 200, // Set a larger width for the logo
              ),
          ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: 'Welcome',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task), 
            label: 'Tasks',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map), 
            label: 'Map',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help), 
            label: 'Help',
            ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
        selectedItemColor: const Color.fromARGB(255, 70, 29, 124),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Welcome to the Patrick F. Taylor Hall Scavenger Hunt App!',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Proxima Nova',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'This app is designed to guide you through a fun scavenger hunt in PFT. '
                'Explore the building, answer questions, and unlock the secret prize!',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Proxima Nova',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Click on the task icon in the navigation bar below to get started. Good luck!',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Proxima Nova',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String _selectedFloor = 'First Floor';

  final Map<String, String> _floorMaps = {
    'First Floor': "assets/pft_first_floor.png",
    'Second Floor': "assets/pft_second_floor.png",
    'Third Floor': "assets/pft_third_floor.png",
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedFloor,
              items: _floorMaps.keys.map((String floor) {
                return DropdownMenuItem<String>(
                  value: floor,
                  child: Text(
                    floor,
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFloor = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: InteractiveViewer(
                panEnabled: true, // Allow panning
                boundaryMargin: const EdgeInsets.all(20), // Add margin for panning
                minScale: 1.0, // Minimum zoom scale
                maxScale: 5.0, // Maximum zoom scale
                child: Image.asset(
                  _floorMaps[_selectedFloor]!,
                  width: 800,
                  height: 500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<Map<String, dynamic>> _tasks = [
    {
      'question': 'Question 1: What brand is the car in the civil engineering sim lab?',
      'choices': ['Toyota', 'Chevrolet', 'Honda', 'Ford'],
      'answer': 'Ford',
      'selected': null,
      'snippet': 'and',
      'correct': 0,
    },
    {
      'question': 'Question 2: If you look out the window in room 1221, in what direction are you facing?',
      'choices': ['North', 'South', 'East', 'West'],
      'answer': 'North',
      'selected': null,
      'snippet': 'as',
      'correct': 0,
    },
    {
      'question': 'Question 3: What restaurant operates in PFT?',
      'choices': ['Popeyes', 'Panda Express', 'Panera', 'Sonic'],
      'answer': 'Panera',
      'selected': null,
      'snippet': 'mag',
      'correct': 0,
    },
    {
      'question': 'Question 4: On what floor are the offices?',
      'choices': ['First', 'Second', 'Third'],
      'answer': 'Third',
      'selected': null,
      'snippet': 'stat',
      'correct': 0,
    },
    {
      'question': 'Question 5: Which of these can one not buy in the vending machines on the first floor?',
      'choices': ['Cheetos', 'Orbit', 'Twix', 'Kit-Kat'],
      'answer': 'Kit-Kat',
      'selected': null,
      'snippet': 'li',
      'correct': 0,
    },
    {
      'question': 'Question 6: Which of these can one do in room 1245?',
      'choices': ['One can see straight through it', 'One can make a phone call on a pay phone', 'One can rent a scooter'],
      'answer': 'One can see straight through it',
      'selected': null,
      'snippet': 'oad',
      'correct': 0,
    },
    {
      'question': 'Question 7: What of these can one see from the third floor veranda?',
      'choices': ['UREC', 'Student Union', 'Tiger Stadium', 'Parade Grounds'],
      'answer': 'Tiger Stadium',
      'selected': null,
      'snippet': 'no',
      'correct': 0,
    },
    {
      'question': 'Question 8: In what direction from PFT is the parking lot?',
      'choices': ['North', 'South', 'East', 'West'],
      'answer': 'South',
      'selected': null,
      'snippet': 'oaks',
      'correct': 0,
    },
    {
      'question': 'Question 9: Where can you find out your class rank?',
      'choices': ['Panera', 'The Commons', 'Student Services'],
      'answer': 'Student Services',
      'selected': null,
      'snippet': 'br',
      'correct': 0,
    },
    {
      'question': 'Question 10: On what floor are career engineering expos commonly held?',
      'choices': ['First', 'Second', 'Third'],
      'answer': 'First',
      'selected': null,
      'snippet': 'ely',
      'correct': 0,
    },
  ];

  bool _allCorrect = false;

  @override
  void initState() {
    super.initState();
    _loadProgress(); // Load progress when the widget is initialized
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();

    // Save selected answers
    for (int i = 0; i < _tasks.length; i++) {
      prefs.setString('task_$i', _tasks[i]['selected'] ?? '');
      prefs.setInt('task_${i}_correct', _tasks[i]['correct'] ?? 0); 
    }

    // Save whether the secret question is unlocked
    prefs.setBool('allCorrect', _allCorrect);
  }

  Future<void> _loadProgress() async {
  final prefs = await SharedPreferences.getInstance();

  // Load selected answers
  for (int i = 0; i < _tasks.length; i++) {
    final selected = prefs.getString('task_$i');
    if (selected != null && selected.isNotEmpty) {
      _tasks[i]['selected'] = selected;
    }

    final correct = prefs.getInt('task_${i}_correct') ?? 0;
      _tasks[i]['correct'] = correct;
  }

  // Load whether the secret question is unlocked
  _allCorrect = prefs.getBool('allCorrect') ?? false;

  // If the secret question is unlocked, add it to the tasks
  if (_allCorrect && !_tasks.any((task) => task['question'] == 'Secret Question')) {
    _tasks.add({
      'question': 'Secret Question: What is the password?',
      'choices': [],
      'answer': 'statelyoaksandbroadmagnolias',
      'selected': null,
      'snippet': 'secret',
      'isFinal': true,
    });
  }

  setState(() {}); // Update the UI after loading progress
}

  @override
  Widget build(BuildContext context) {

    final unlockedSnippets = _tasks
      .where((task) => task['correct'] == 1)
      .map((task) => task['snippet'])
      .toList();

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _tasks.length + 1,
      itemBuilder: (context, index) {
        if(index < _tasks.length)
        {
          final task = _tasks[index];
          if (task['isFinal'] == true) {
          // Handle the final question with a TextField
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task['question'],
                style: const TextStyle(fontSize: 18, fontFamily: 'Proxima Nova'),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  task['selected'] = value; // Store the user's input
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Answer',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _submitFinalAnswer(context, task);
                },
                child: const Text('Try Password'),
              ),
            ],
          );
        } else {
          // Handle regular questions with multiple-choice answers
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task['question'],
                style: const TextStyle(fontSize: 18, fontFamily: 'Proxima Nova'),
              ),
              const SizedBox(height: 10),
              ...task['choices'].map<Widget>((choice) {
                return RadioListTile<String>(
                  title: Text(choice),
                  value: choice,
                  groupValue: task['selected'],
                  onChanged: (String? value) {
                    setState(() {
                      task['selected'] = value;
                    });
                  },
                );
              }).toList(),
              ElevatedButton(
                onPressed: () {
                  _submitAnswer(context, task);
                },
                child: const Text('Test Answer', style : TextStyle(fontFamily: 'Proxima Nova')),
              ),
            ],
          );
        }
        }
        else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Unlocked Snippets:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              if (unlockedSnippets.isEmpty)
                const Text(
                  'No snippets unlocked yet. Answer questions correctly to unlock snippets!',
                  style: TextStyle(fontSize: 16,),
                )
              else
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: unlockedSnippets
                      .map((snippet) => Chip(
                            label: Text(
                              snippet, 
                              style: TextStyle(color: Color.fromARGB(255, 253, 208, 35))),
                            backgroundColor: const Color.fromARGB(255, 70, 29, 124),
                          ))
                      .toList(),
                ),
              const SizedBox(height: 20),
            ],
          ); 
        }
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1,
          color: Colors.grey,
        );
      },
    );
  }

  void _submitAnswer(BuildContext context, Map<String, dynamic> task) {
    if (task['selected'] == null) {
      // Show a dialog if no answer is selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop(); // Close the dialog
          });

          return AlertDialog(
            title: const Text('No Answer Selected', textAlign: TextAlign.center,),
            content: const Text('Please select an answer before submitting.', textAlign: TextAlign.center,),
          );
        },
      );
      return;
    }

    // Check if the selected answer is correct
    final isCorrect = task['selected'] == task['answer'];

    // Show feedback dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {

        Future.delayed(const Duration(milliseconds: 2000), () {
          Navigator.of(context).pop(); // Close the dialog
        });

        return AlertDialog(
          title: Text(isCorrect ? 'Correct!' : 'Incorrect', textAlign: TextAlign.center,),
          content: Text(isCorrect ? 'Snippet unlocked: ${task['snippet']}.' : 'Try again.', textAlign: TextAlign.center,),
        );
      },
    );

    if (isCorrect) {
      setState(() {
        task['correct'] = 1;
        // Check if all tasks are answered correctly
        _allCorrect = _tasks.every((task) => task['correct'] == 1);

        // If all tasks are correct, add the secret fifth question
        if (_allCorrect && !_tasks.any((task) => task['question'] == 'Secret Question')) {
          _tasks.add({
            'question': 'Secret Question: What is the password?',
            'choices': [],
            'answer': 'statelyoaksandbroadmagnolias',
            'selected': null,
            'snippet': 'secret',
            'isFinal': true,
          });
        }
      });

      _saveProgress(); // Save progress after a correct answer
    }
  }

  void _submitFinalAnswer(BuildContext context, Map<String, dynamic> task) {
  if (task['selected'] == null || task['selected'].isEmpty) {
    // Show a dialog if no answer is entered
    showDialog(
      context: context,
      builder: (BuildContext context) {

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop(); // Close the dialog
        });

        return AlertDialog(
          title: const Text('No Answer Entered', textAlign: TextAlign.center,),
          content: const Text('Please type in an answer before submitting.', textAlign: TextAlign.center,),
        );
      },
    );
    return;
  }

  // Check if the entered answer is correct
  final isCorrect = task['selected'].toString().trim().toLowerCase() ==
      task['answer'].toString().trim().toLowerCase();

  if (isCorrect) {
    // Navigate to the Victory Screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const VictoryScreen()),
    );
  } else {
    // Show feedback dialog for incorrect answer
    showDialog(
      context: context,
      builder: (BuildContext context) {

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop(); // Close the dialog
        });

        return AlertDialog(
          title: const Text('Incorrect', textAlign: TextAlign.center,),
          content: const Text('Try again.', textAlign: TextAlign.center,),
        );
      },
    );
  }
}
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What is this app?',
              style: TextStyle(fontSize: 24, fontFamily: 'Proxima Nova'),
            ),
            const SizedBox(height: 10),
            const Text(
              'This app is a scavenger hunt designed for Patrick F. Taylor Hall. You will be given a series of questions to answer '
              'and a map to help you navigate the building.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'How to win the scavenger hunt?',
              style: TextStyle(fontSize: 24,  fontFamily: 'Proxima Nova'),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Answer all multiple-choice questions correctly.\n'
              '2. With each correct answer, you will receive a snippet of the final password. This will show up on the bottom of the page.\n'
              '3. Once all questions are answered correctly, a secret question will be unlocked.\n'
              '4. Unscramble the snippets to form the final password.\n'
              '5. Tpye the password in the secret question to win the scavenger hunt and reveal the prize!',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'What is the format of the password?',
              style: TextStyle(fontSize: 24, fontFamily: 'Proxima Nova'),
            ),
            const SizedBox(height: 10),
            const Text(
              'The password for the secret question is case-insensitive with no spaces, special characters, or numbers.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Does this app save my progress?',
              style: TextStyle(fontSize: 24, fontFamily: 'Proxima Nova'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Yes, your progress is automatically saved. If you close the app and reopen it, your answers will be restored, '
              'and you can continue from where you left off. However, if you press "Play Again" after completing the scavenger hunt, '
              'your progress will be reset.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class VictoryScreen extends StatefulWidget {
  const VictoryScreen({super.key});

  @override
  State<VictoryScreen> createState() => _VictoryScreenState();
}

class _VictoryScreenState extends State<VictoryScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play(); // Start the confetti animation
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            toolbarHeight: 120,
            backgroundColor: const Color.fromARGB(255, 70, 29, 124),
            leadingWidth: 140,
            leading:  Image.asset(
                'assets/lsu_logo.png',
                fit: BoxFit.contain, // Ensure the image fits within its bounds
                height: 100, // Set a larger height for the logo
                width: 200, // Set a larger width for the logo
              ),
          ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 70, 29, 124),  Color.fromARGB(255, 253, 208, 35)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Confetti animation
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive, // Spread in all directions
              shouldLoop: true,
              colors: const [Colors.red, Colors.blue, Colors.green, Colors.yellow],
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.emoji_events,
                  color: Colors.amber,
                  size: 100, // Trophy icon
                ),
                const SizedBox(height: 20),
                const Text(
                  'Congratulations!\n'
                  'You have successfully completed the scavenger hunt!',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your prize is the location of a "secret study" spot:\n'
                  'On the north side of the third floor by office E is a semi-private study spot with one of the best views in PFT.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.clear(); // Clear progress

                    // Navigate back to the MainScreen
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const MainScreen()),
                      (route) => false, // Remove all previous routes
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 70, 29, 124),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'Play Again',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}