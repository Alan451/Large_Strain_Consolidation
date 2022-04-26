import 'dart:math';
import 'package:flutter/material.dart';
import 'package:long_strain_consolidation/screens/ErrorScreen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../screens/ErrorScreen.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ResultScreen1g extends StatefulWidget {
  const ResultScreen1g({Key? key}) : super(key: key);
  static String id = 'result_screen_1g';
  @override
  _ResultScreen1gState createState() => _ResultScreen1gState();
}

Map computeResult(Map inputs,context){
  const num spgr_w=1,g=9.81;
  num spgr_s=inputs['spgr_s'];
  num initial_vr=inputs['initial_vr'];
  num depth=inputs['depth'];
  num surcharge=inputs['surcharge'];
  num minutes=inputs['minutes'];
  num delta=inputs['delta'];
  num tau=inputs['tau'];
  num plot_interval = inputs['plot_interval'];
  num a = inputs['a'];
  num b = inputs['b'];
  num c = inputs['c'];
  num d = inputs['d'];
  num f = inputs['f'];

  List<ChartSeries> figOne = [
  ];
  List <ChartSeries> figTwoData = [
    // Renders spline chart

  ];
  List<ChartSeries> figThree = [
  ];
  List<ChartSeries> figFour = [
  ];

  print('$spgr_s,$initial_vr,$depth,$surcharge,$minutes,$delta,$tau,$plot_interval,$a,$b,$c,$d,$f');
  num gamma_w = spgr_w*g, gamma_s=spgr_s*g;
  num temp = depth/delta/(1+initial_vr);
  int rows;

  try{
    rows = temp.round() + 2;
  }
  catch(e){
    rows = 2;
  }
  print('rows: $rows');
  num time_factor=60/tau;
  num z = 0.0;
  var e_prev = List.filled(rows+1, z, growable: false);
  var e_next = List.filled(rows+1, z, growable: false);

  var heights = List.filled(rows+1, z, growable: false);
  var tot_str = List.filled(rows+1, z, growable: false);
  int q;
  try{
    q = (minutes/plot_interval).round();
  }
  catch(e){
    q=0;
  }
  var settle = List.filled(q+1, z, growable: false);
  var tot_pore_pr = List.generate(q+1, (i) => List.filled(rows+1, z, growable: false), growable: false);
  var ex_pore_pr = List.generate(q+1, (i) => List.filled(rows+1, z, growable: false), growable: false);

  for(int i=2;i<=rows;++i) {
    e_prev[i]=initial_vr;
  }
  e_next[rows] = initial_vr;
  for(int j=1;j<=minutes*time_factor;++j) {
    num p = j / plot_interval / time_factor;
    int PF = p.round();
    num lambda, term1, phi1, phi2, phi3;
    for (int i = 2; i <= rows - 1; ++i) {
      if (i == 2) {
        num deds = c * d * pow((e_prev[2] / c), ((d - 1) / d));
        e_prev[1] = e_prev[3] + 2 * delta * deds * (gamma_s - gamma_w);
      }
      phi1 = pow((e_prev[i - 1] / a), (1 / b)) / (1 + e_prev[i - 1]) / c / d /
          pow((e_prev[i - 1] / c), ((d - 1) / d));
      phi2 = pow((e_prev[i] / a), (1 / b)) / (1 + e_prev[i]) / c / d /
          pow((e_prev[i] / c), ((d - 1) / d));
      phi3 = pow((e_prev[i + 1] / a), (1 / b)) / (1 + e_prev[i + 1]) / c / d /
          pow((e_prev[i + 1] / c), ((d - 1) / d));
      lambda = ((1 + e_prev[i]) * pow((e_prev[i] / a), (1 / b - 1)) / a / b -
          pow((e_prev[i] / a), (1 / b))) / pow((1 + e_prev[i]), 2);
      if (i == 2) {
        term1 = (tau / gamma_w) *
            ((e_prev[i + 1] - e_prev[i - 1]) / 2 / delta) *
            ((gamma_s - gamma_w) * lambda + (phi3 - phi2) / delta);
      }
      else {
        term1 = (tau / gamma_w) *
            ((e_prev[i + 1] - e_prev[i - 1]) / 2 / delta) *
            ((gamma_s - gamma_w) * lambda + (phi3 - phi1) / 2 / delta);
      }
      num term2 = (tau / gamma_w) * phi2 *
          ((e_prev[i + 1] - 2 * e_prev[i] + e_prev[i - 1]) / (pow(delta, 2)));
      e_next[i] = e_prev[i] - term1 - term2;
      if (i > 3) {
        phi1 = pow((e_next[i - 2] / a), (1 / b)) / (1 + e_next[i - 2]) / c / d /
            pow((e_next[i - 2] / c), ((d - 1) / d));
        phi2 = pow((e_next[i - 1] / a), (1 / b)) / (1 + e_next[i - 1]) / c / d /
            pow((e_next[i - 1] / c), ((d - 1) / d));
        phi3 = pow((e_next[i] / a), (1 / b)) / (1 + e_next[i]) / c / d /
            pow((e_next[i] / c), ((d - 1) / d));
        lambda =
            ((1 + e_next[i - 1]) * pow((e_next[i - 1] / a), (1 / b - 1)) / a /
                b - pow((e_next[i - 1] / a), (1 / b))) /
                pow((1 + e_next[i - 1]), 2);
        num deltaMax = (-2 * phi2 /
            ((gamma_s - gamma_w) * lambda + (phi3 - phi1) / 2 / delta)).abs();
        if (delta > deltaMax) {
          // Error Page
          Navigator.pushNamed(
            context,
            ErrorScreen.id,
            arguments: <String, String>{
              'message':'Delta Check Failed',
            },
          );
        }
      }
      num phi = pow((e_next[i] / a), (1 / b)) / (1 + e_next[i]) / c / d /
          pow((e_next[i] / c), ((d - 1) / d));
      num tauMax = (-(pow(delta, 2)) * gamma_w / 2 / phi).abs();
      if (tau > tauMax) {
        //  Error Page
        Navigator.pushNamed(
          context,
          ErrorScreen.id,
          arguments: <String, String>{
            'message':'Tau Check Failed',
          },
        );
      }
    }
    if(j%(plot_interval*time_factor) == 0){
      num s=(1+e_next[2])+(1+e_next[rows]);
      for (int k = 3;k<=rows-1;++k) {
        if (k % 2 == 1) {
          s = s + 4 * (1 + e_next[k]);
        }
        else{
          s = s + 2 * (1 + e_next[k]);
        }

      }
      settle[PF]=(1+initial_vr)*(rows-2)*delta-s*delta/3;
      for(int k=2;k<=rows-1;++k){
        heights[k+1]=heights[k]+(1+(e_next[k]+e_next[k+1])/2)*delta;
      }
      List<Point> figOneData = [
      ];
      for(int k=2;k<=rows-1;++k){
        figOneData.add(
            Point(e_next[k],heights[k])
        );
      }
      figOne.add(
          LineSeries<Point, num>(
            dataSource: figOneData,
            xValueMapper: (Point data, _) => data.x,
            yValueMapper: (Point data, _) => data.y,
          )
      );
      for(int k=2;k<=rows-1;++k){
        num str1 = gamma_w*settle[PF];
        num str2 = 0;
        for(int l=k;l<=rows-1;++l){
          str2=str2+gamma_w*(e_next[k]+e_next[l+1])/2*delta;
        }
        num str3 = gamma_s*(rows-1-(k-1))*delta;
        tot_str[k]=str1+str2+str3+surcharge;
        num eff_str=pow((e_next[k]/c),(1/d)) -f;
        tot_pore_pr[PF][k]=tot_str[k]-eff_str;
        ex_pore_pr[PF][k]=tot_pore_pr[PF][k]-gamma_w*(depth-heights[k]);
      }
      List<Point> figThreeData = [
      ];
      List<Point> figTwo = [];
      for(int k=2;k<=rows-1;++k){
        figTwo.add(
          Point(tot_str[k],heights[k])
        );
        figThreeData.add(
          Point(tot_pore_pr[PF][k],heights[k])
        );
      }
      figTwoData.add(
          LineSeries<Point, num>(
            dataSource: figTwo,
            xValueMapper: (Point data, _) => data.x,
            yValueMapper: (Point data, _) => data.y,
          )
      );
      figThree.add(
          LineSeries<Point, num>(
            dataSource: figThreeData,
            xValueMapper: (Point data, _) => data.x,
            yValueMapper: (Point data, _) => data.y,
          )
      );
    }

    e_prev = e_next;


  }

  List<Point> figFourData = [
  ];

  for(num k=plot_interval;k<=minutes;k+=plot_interval){

    figFourData.add(
        Point(k,settle[(k/plot_interval).round()]*1000)
    );
    print(Point(k,settle[(k/plot_interval).round()]*1000));
  }
  figFour.add(
      LineSeries<Point, num>(
        dataSource: figFourData,
        xValueMapper: (Point data, _) => data.x,
        yValueMapper: (Point data, _) => data.y,
      )
  );
  num finalSettlement = 0;
  try{
    finalSettlement = settle[(minutes/plot_interval).round()]*100;
  }
  catch(e){
    print(e);
  }

  print('Final Settlement = $finalSettlement');
  Map output = {};
  output['finalSettlement'] = finalSettlement;
  output['figOneData'] = figOne;
  output['figTwoData'] = figTwoData;
  output['figThreeData'] = figThree;
  output['figFourData'] = figFour;
  return output;

}

class _ResultScreen1gState extends State<ResultScreen1g> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, num>{}) as Map;
    final output = computeResult(arguments,context);
    final finalSettlement = output['finalSettlement'];
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          title: const Text('Results Page, 1g'),
          backgroundColor: const Color(0xff3F80FA),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text('Final Settlement = $finalSettlement'),
              SfCartesianChart(
                  primaryXAxis: NumericAxis(
                      title: AxisTitle(
                        text: 'Void Ratio',
                      ),
                      isInversed: false
                  ),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(
                        text: 'Height(m)',
                      ),
                      isInversed: false
                  ),
                  series: output['figOneData']
              ),
              SfCartesianChart(
                  series: output['figTwoData']
              ),
              SfCartesianChart(
                  series: output['figThreeData']
              ),
              SfCartesianChart(
                  primaryXAxis: LogarithmicAxis(
                      title: AxisTitle(
                        text: 'Time(minutes)',
                      ),
                      isInversed: false
                  ),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(
                        text: 'Settlement',
                      ),
                      isInversed: true
                  ),
                  series: output['figFourData']
              ),
            ],



          ),
        ),
      ),
    );
  }
}
