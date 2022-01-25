
import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'round_matchs_model.dart';

class BracketWidget<T> extends StatefulWidget {
  final int bracketSize;
  final List<List<T>> teamList;
  final Widget Function(T t) playerWidgetBuilder;

  const BracketWidget(this.teamList,this.bracketSize,this.playerWidgetBuilder, {Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _BracketWidget<T>();
}

class _BracketWidget<T> extends State<BracketWidget<T>> {
  List<GlobalKey> matchKeys = [];
  List<Widget> childrenList = [];
  List<RoundMatches<T>> list = [];
  List<List<RoundMatches>> roundMatches=[];
  @override
  void initState() {
    widget.teamList.forEach((e) {
      list.add(RoundMatches(e,GlobalKey()));
    });
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      getRoundMatches(context);
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: false,
      child: SizedBox(
        width: (MediaQuery.of(context).size.width * 0.8) * roundMatches.length,
        height: (112*widget.bracketSize).toDouble(),
        child: Stack(
          children: childrenList,
        ),
      ),
      boundaryMargin: const EdgeInsets.all(20),
    );
  }

  Future<void> getRoundMatches(BuildContext context) async {
    List<int> round = [];
    List<int> roundIndex = [];
    int numRound = 0;
    double result = widget.bracketSize.toDouble();

    while (result != 1) {
      result = result / 2;
      round.add(result.toInt());
      numRound++;
    }
    int temp = 0;
    for (int i = 0; i < round.length; i++) {
      temp = temp + round[i];
      roundIndex.add(temp);
    }
    for (int i = 0; i < roundIndex.length; i++) {
      final roundList =
      list.sublist(i == 0 ? 0 : roundIndex[i - 1], roundIndex[i]);
      List<RoundMatches> tempMatch=[];
      for (int j = 0; j < roundList.length; j++) {
        tempMatch.add(roundList[j]);
        childrenList.add(matchWidget(
          key: roundList[j].key!,
          matchData: roundList[j].teams,
          context: context,
          round: i + 1,
          match: j + 1,
          parent1: i==0?null:roundMatches[i-1][j+j].key,
          parent2: i==0?null:roundMatches[i-1][j+j+1].key,
          // playerWidgetBuilder:widget.playerWidgetBuilder,

        ));
      }
      roundMatches.add(tempMatch);
      setState(() {});
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Widget matchWidget(
      {required GlobalKey key,
        required BuildContext context,
        required List<T> matchData,
        required int round,
        required int match,
        double? margin,
        GlobalKey? parent1,
        GlobalKey? parent2}) {
    double top = round == 1 ? (132.0 * match) : getPositions(parent1!, parent2!);
    double left =
    round == 1 ? 0 : (MediaQuery.of(context).size.width * 0.7) * (round - 1);
    return Positioned(
      key: key,
      top: top,
      left: left,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          children: [
            widget.playerWidgetBuilder(matchData.first),
            const SizedBox(
              height: 2,
            ),
            widget.playerWidgetBuilder(matchData.last),
            SizedBox(
              height: 40 + (margin ?? 0),
            ),
          ],
        ),
      ),
    );
  }
}

Widget get roundSpace => const SizedBox(height: 60);

double getPositions(GlobalKey parent1, GlobalKey parent2) {
  final box = parent1.currentContext?.findRenderObject() as RenderBox?;
  Offset? position = box?.localToGlobal(Offset.zero); //this is global position
  double? y1 = position?.dy; //this is y - I think
  final box2 = parent2.currentContext?.findRenderObject() as RenderBox?;
  Offset? position2 =
  box2?.localToGlobal(Offset.zero); //this  is global position
  double? y2 = position2?.dy; //this is y - I think
  double pos = 0;
  if (y1 != null && y2 != null) {
    pos = ((y2 + y1) / 2) - ((132 / 2) + 20);
  }
  return pos;
}
