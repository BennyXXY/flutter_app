import 'package:flutter/material.dart';
import 'package:flutterapp/work/RadioButton.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'custom_stepper.dart';
import 'custom_stepper2.dart';

void main() {
  runApp(MaterialApp(
    home: StepperPage(),
  ));
}

class StepperPage extends StatefulWidget {
  @override
  _StepperPageState createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StepperPage'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 100,
            child: _buildCustomStepper2(),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 100,
            child: _buildCustomStepper(),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 100,
            child: _buildStepper(),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 80,
            child:  timeline(),
          )
        ],
      ),
    );
  }

  Widget _buildCustomStepper() {
    return CustomStepper(
      currentStep: 2,
      type: CustomStepperType.horizontal,
      steps: ['提交任务', '本金返款', '评价返佣金', '追评返佣金']
          .map(
            (s) => CustomStep(
                title: Text(s), content: Container(), isActive: true),
          )
          .toList(),
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Container();
      },
    );
  }

  Widget _buildCustomStepper2() {
    return CustomStepper2(
      currentStep: 0,
      type: CustomStepperType2.horizontal,
      steps: ['提交任务', '本金返款', '评价返佣金', '追评返佣金', '任务完结']
          .map(
            (s) => CustomStep2(
                title: Text(s), content: Container(), isActive: true),
          )
          .toList(),
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Container();
      },
    );
  }

  Widget _buildStepper() {
    return Stepper(
      currentStep: 2,
      type: StepperType.horizontal,
      steps: ['提交任务', '本金返款', '任务完结']
          .map(
            (s) => Step(title: Text(s), content: Container(), isActive: true),
          )
          .toList(),
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Container();
      },
    );
  }

  Widget timeline() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimelineTile(
          axis: TimelineAxis.horizontal,
          alignment: TimelineAlign.center,
          indicatorStyle: IndicatorStyle(
            indicator: Image.asset('assets/images/head.png')
          ),
          beforeLineStyle:LineStyle(
            color: Colors.blue,
          ),
          endChild: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Text('扬声器'),
          ),
          isFirst: true,
        ),
        TimelineTile(
          axis: TimelineAxis.horizontal,
          alignment: TimelineAlign.center,
          beforeLineStyle: LineStyle(
            color: Colors.blue
          ),
          afterLineStyle: LineStyle(
            color: Colors.grey
          ),
        ),
        TimelineTile(
          axis: TimelineAxis.horizontal,
          alignment: TimelineAlign.center,
        ),
        TimelineTile(
          axis: TimelineAxis.horizontal,
          alignment: TimelineAlign.center,
          isLast: true,
        )
      ],
    );
  }
}
