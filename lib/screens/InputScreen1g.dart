import 'package:flutter/material.dart';
import '../screens/ResultScreen1g.dart';
import 'package:math_expressions/math_expressions.dart';


class InputScreen1g extends StatefulWidget {
  static String id = 'input_screen_1g';

  const InputScreen1g({Key? key}) : super(key: key);
  @override
  _InputScreen1gState createState() => _InputScreen1gState();
}

class _InputScreen1gState extends State<InputScreen1g> {

  // a= ((10^11)/1.41)^(1/4.11);%90.436;
  // b=1/4.11;%0.303;
  // %e=c(S+f)^d%% e=c*s^d
  // c=12.19;%1.03;
  // d=-0.29; %-0.047;
  // f=0.00; %for barthelomuseen et al
  num spgr_s = 2.71;
  num initial_vr=18.8;
  num depth=6.33;
  num surcharge=0.224;
  num minutes=400*24*60;
  num delta=0.01;
  num tau=1000;
  num plot_interval = 1000;
  Parser p = Parser();
  ContextModel cm = ContextModel();
  num a=436.609,b=0.243,c=12.19,d=-0.29,f=0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          title: const Text('Input Screen 1g'),
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
                      'Depth'
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
                      'Surcharge'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: surcharge.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            surcharge = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('surcharge $surcharge');
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
                      'Minutes'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: minutes.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            minutes = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('Minutes $minutes');
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
                      'a if (e = a*k^b)'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: a.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            a = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('a $a');
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
                      'b if (e = a*k^b)'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: b.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            b = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('b $b');
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
                      'c'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: c.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            c = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('c $c');
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
                      'd'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: d.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            d = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('d $d');
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
                      'f'
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: f.toString(),
                      ),
                      onChanged: (val){
                        setState(() {
                          try{
                            f = p.parse(val).evaluate(EvaluationType.REAL,cm) ;
                            print('f $f');
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
                    ResultScreen1g.id,
                    arguments: <String, num>{
                      'spgr_s':spgr_s,
                      'initial_vr':initial_vr,
                      'depth':depth,
                      'surcharge':surcharge,
                      'minutes':minutes,
                      'delta':delta,
                      'tau':tau,
                      'plot_interval':plot_interval,
                      'a':a,
                      'b':b,
                      'c':c,
                      'd':d,
                      'f':f,
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
