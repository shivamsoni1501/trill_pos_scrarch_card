import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'model/rewards.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Scratch Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Scratch Demo Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<RewardModel> rewards = [];

  var sampleData = [
    ['1', 'First Reward'],
    ['2', 'Second Reward'],
    ['3', 'Third Reward'],
    ['4', 'Fourth Reward'],
    ['5', 'Fifth Reward'],
    ['6', 'Sixth Reward'],
    ['7', 'Seventh Reward'],
    ['8', 'Eighth Reward'],
    ['9', 'Ninth Reward'],
    ['10', 'Tenth Reward'],
    ['11', 'Eleventh Reward'],
    ['12', 'Twelth Reward'],
    ['13', 'Thirteenth Reward'],
    ['14', 'Fourteenth Reward'],
    ['15', 'Fifteenth Reward'],
  ];

  @override
  void initState() {
    super.initState();
    rewards = sampleData
        .map((e) => RewardModel(rewardId: e[0], description: e[1]))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.builder(
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          return ScratchCard(reward: rewards[index]);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
      ),
    );
  }
}

class ScratchCard extends StatefulWidget {
  final double width;
  final double height;
  final RewardModel reward;
  final bool isEnabled;
  const ScratchCard(
      {Key? key,
      required this.reward,
      this.isEnabled = false,
      this.width = double.maxFinite,
      this.height = double.maxFinite})
      : super(key: key);

  @override
  State<ScratchCard> createState() => _ScratchCardState();
}

class _ScratchCardState extends State<ScratchCard> {
  Widget rewardW() {
    return Container(
      color: Colors.amber,
      height: widget.height,
      width: widget.width,
      alignment: Alignment.center,
      child: Text(widget.reward.description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isEnabled) {
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  children: [
                    ScratchCard(
                      reward: widget.reward,
                      isEnabled: true,
                      width: 300,
                      height: 300,
                    ),
                  ],
                );
              }).then((value) => setState(() {}));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: (widget.reward.isCollected)
            ? rewardW()
            : Scratcher(
                child: rewardW(),
                accuracy: ScratchAccuracy.low,
                color: Colors.blue,
                enabled: widget.isEnabled,
                brushSize: 60,
                threshold: 40,
                onThreshold: () {
                  setState(() {
                    widget.reward.isCollected = true;
                  });
                },
              ),
      ),
    );
  }
}
