import 'dart:math';

import 'package:flutter/material.dart';
import '../screens/ResultScreenNg.dart';
import 'package:math_expressions/math_expressions.dart';


class InputScreenNg extends StatefulWidget {
  static String id = 'input_screen_Ng';
  const InputScreenNg({Key? key}) : super(key: key);

  @override
  State<InputScreenNg> createState() => _InputScreenNgState();
}

class _InputScreenNgState extends State<InputScreenNg> {
  num spgr_s = 2.65;
  num initial_vr = 3.26;
  num radius=1.8;
  num omega=23.87;
  num depth=0.26;
  num hours=2000;
  num delta=0.001;
  num tau=1;
  num plot_interval = 0.01;
  num Au = 3.187;
  num Bu = 0.6921;
  num Bu1=-0.1785;
  num Cu = 8.832*pow(10,-12);
  num Du = 5.966;
  Parser p = Parser();
  ContextModel cm = ContextModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          title: const Text('Input Screen Ng'),
          backgroundColor: const Color(0xff3F80FA),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                      'Specific Gravity'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: spgr_s.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            spgr_s = p.parse(val).evaluate(EvaluationType.REAL,cm);
                            print(p.parse(val));
                            print('spgr $spgr_s');
                          }catch(e){
                            print(e);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                      'Initial Void Ratio'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: initial_vr.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            initial_vr = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('initial_vr $initial_vr');
                          }catch(e){
                            print(e);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                      'Radius'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: radius.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            radius = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('radius $radius');
                          }catch(e){
                            print(e);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                      'Omega'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: omega.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            omega = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('omega $omega');
                          }catch(e){
                            print(e);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                      'depth'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: depth.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            depth = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('depth $depth');
                          }catch(e){
                            print(e);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                      'hours'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: hours.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            hours = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('hours $hours');
                          }catch(e){
                            print(e);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                      'Delta'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: delta.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            delta = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('delta $delta');
                          }catch(e){
                            print(e);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                      'tau'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: tau.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            tau = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('tau $tau');
                          }catch(e){
                            print(e);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                      'plot_interval'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: plot_interval.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            plot_interval = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('plot_interval $plot_interval');
                          }catch(e){
                            print(e);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                      'Au'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: Au.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            Au = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('Au $Au');
                          }catch(e){
                            print(e);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                      'Bu'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: Bu.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            Bu = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('Bu $Bu');
                          }catch(e){
                            print(e);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                      'Bu1'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: Bu1.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            Bu1 = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('Bu1 $Bu1');
                          }catch(e){
                            print(e);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                      'Cu'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: Cu.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            Cu = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('Cu $Cu');
                          }catch(e){
                            print(e);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                      'Du'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: Du.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            Du = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('Du $Du');
                          }catch(e){
                            print(e);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              ElevatedButton( //                         <--- Button
                child: const Text('View Results'),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ResultScreenNg.id,
                    arguments: <String, num>{
                      'spgr_s':spgr_s,
                      'initial_vr':initial_vr,
                      'radius':radius,
                      'omega':omega,
                      'depth':depth,
                      'hours':hours,
                      'delta':delta,
                      'tau':tau,
                      'plot_interval':plot_interval,
                      'Au':Au,
                      'Bu':Bu,
                      'Bu1':Bu1,
                      'Cu':Cu,
                      'Du':Du,
                    },
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
