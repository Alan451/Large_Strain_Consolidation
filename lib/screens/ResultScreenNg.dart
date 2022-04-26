
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../screens/ErrorScreen.dart';


Map computeResult(Map inputs,context) {
  const num spgr_w = 1,
      g = 9.81;
  num spgr_s = inputs['spgr_s'];
  num initial_vr = inputs['initial_vr'];
  num radius = inputs['radius'];
  num omega = inputs['omega'];
  num depth = inputs['depth'];
  num hours = inputs['hours'];
  num delta = inputs['delta'];
  num tau = inputs['tau'];
  num plot_interval = inputs['plot_interval'];
  num Au = inputs['Au'];
  num Bu = inputs['Bu'];
  num Bu1 = inputs['Bu1'];
  num Cu = inputs['Cu'];
  num Du = inputs['Du'];


  List<ChartSeries> figOne = [
  ];
  List <ChartSeries> figTwo = [
    // Renders spline chart

  ];


  print('$spgr_s,$initial_vr,$radius,$omega,$depth,$hours,$delta,$tau,$plot_interval,$Au,$Bu,$Bu1,$Cu,$Du');
  num gamma_w = spgr_w*g, gamma_s=spgr_s*g, n0=(radius*pow(omega,2))/g;
  num temp = depth/delta/(1+initial_vr);
  int rows;

  try{
    rows = temp.round() + 2;
  }
  catch(e){
    rows = 2;
  }
  print('rows: $rows');
  num time_factor=3600/tau;
  num z = 0.0;
  var e_prev = List.filled(rows+1, z, growable: false);
  var e_next = List.filled(rows+1, z, growable: false);

  var heights = List.filled(rows+1, z, growable: false);

  int q;
  try{
    q = (hours/plot_interval).round();
  }
  catch(e){
    q=0;
  }
  var settle = List.filled(q+1, z, growable: false);
  for(int i=2;i<=rows;++i) {
    e_prev[i]=initial_vr;
  }
  e_next[rows] = initial_vr;
  num n;
  for(int j=1;j<=hours*time_factor;++j) {
    // print(j);
    num p = j / plot_interval / time_factor;
    int PF = p.round();
    num lambda, term1,perm,term2,term3, phi1, phi2, phi3;
    n=n0;
    for (int i = 2; i <= rows - 1; ++i) {
      if (i == 2) {
        num dsed = (pow((e_prev[2] / Au), (1 / Bu1 - 1))) / (Au * Bu1);
        num deds = 1 / dsed;
        e_prev[1] = e_prev[3] + 2 * deds * (gamma_s - gamma_w) * n0 * delta;
      }
      lambda =
          Cu * (pow(e_prev[i], (Du - 1))) * (Du * (1 + e_prev[i]) - e_prev[i]) /
              (pow((1 + e_prev[i]), 2));
      phi1 = ((pow((e_prev[i - 1] / Au), (1 / Bu1 - 1))) * Cu *
          (pow(e_prev[i - 1], Du))) / ((1 + e_prev[i - 1]) * Au * Bu1);
      phi2 =
          ((pow((e_prev[i] / Au), (1 / Bu1 - 1))) * Cu * (pow(e_prev[i], Du))) /
              ((1 + e_prev[i]) * Au * Bu1);
      phi3 = ((pow((e_prev[i + 1] / Au), (1 / Bu1 - 1))) * Cu *
          (pow(e_prev[i + 1], Du))) / ((1 + e_prev[i + 1]) * Au * Bu1);
      perm = Cu * (pow(e_prev[i], Du));

      if (i == 2) {
        term1 =
            (tau / gamma_w) * ((e_prev[i + 1] - e_prev[i - 1]) / 2 / delta) *
                ((gamma_s - gamma_w) * n * lambda + (phi3 - phi2) / delta);
      }
      else {
        term1 =
            (tau / gamma_w) * ((e_prev[i + 1] - e_prev[i - 1]) / 2 / delta) *
                ((gamma_s - gamma_w) * n * lambda + (phi3 - phi1) / 2 / delta);
      }
      term2 = (tau / gamma_w) * phi2 *
          ((e_prev[i + 1] - 2 * e_prev[i] + e_prev[i - 1]) / (pow(delta, 2)));
      term3 = (tau / gamma_w) * (pow(omega, 2) / g) *
          (2 * (gamma_s - gamma_w) * perm +
              (1 + e_prev[i]) * phi2 * (e_prev[i + 1] - e_prev[i - 1]) / 2 /
                  delta / n);
      e_next[i] = e_prev[i] - term1 - term2 + term3;
      n = n - (pow(omega, 2) / g) * (1 + e_prev[i]) * delta;

      if (i > 3) {
        phi1 = ((pow((e_next[i - 2] / Au), (1 / Bu1 - 1))) *
            Cu *
            pow(e_next[i - 2], Du)) /
            ((1 + e_next[i - 2]) * Au * Bu1);
        phi2 = ((pow((e_next[i - 1] / Au), (1 / Bu1 - 1))) *
            Cu *
            pow(e_next[i - 1], Du)) /
            ((1 + e_next[i - 1]) * Au * Bu1);
        phi3 =
            ((pow((e_next[i] / Au), (1 / Bu1 - 1))) * Cu * pow(e_next[i], Du)) /
                ((1 + e_next[i]) * Au * Bu1);
        lambda = Cu *
            pow(e_next[i], (Du - 1)) *
            (Du * (1 + e_next[i]) - e_next[i]) /
            pow((1 + e_next[i]), 2);
        num newn = n0;
        for (int k = 2; k <= i - 1; ++k) {
          newn = newn - (pow(omega, 2) / g) * (1 + e_next[k]) * delta;
        }
        num deltaMax = (-2 * phi2 /
            ((gamma_s - gamma_w) * newn * lambda + (phi3 - phi1) / 2 / delta -
                (pow(omega, 2) / g) * phi2 * (1 + e_next[i - 1]) / newn)).abs();
        if (delta > deltaMax) {
          //  Error Page
          Navigator.pushNamed(
            context,
            ErrorScreen.id,
            arguments: <String, String>{
              'message':'Delta Check Failed',
            },
          );
        }
      }

      num phi = ((pow((e_next[i - 1] / Au), (1 / Bu1 - 1))) * Cu *
          pow(e_next[i - 1], Du)) / ((1 + e_next[i - 1]) * Au * Bu1);
      num tau_max = (-pow(delta, 2) * gamma_w / 2 / phi).abs();
      if (tau > tau_max) {
        Navigator.pushNamed(
          context,
          ErrorScreen.id,
          arguments: <String, String>{
            'message':'Tau Check Failed',
          },
        );
      }
    }
    if(j%(plot_interval*time_factor) == 0) {
      num s = (1 + e_next[2]) + (1 + e_next[rows]);
      for (int k = 3; k <= rows - 1; ++k) {
        if (k % 2 == 1) {
          s = s + 4 * (1 + e_next[k]);
        }
        else {
          s = s + 2 * (1 + e_next[k]);
        }
      }
      settle[PF] = (1 + initial_vr) * (rows - 2) * delta - s * delta / 3;
      for (int k = 2; k <= rows - 1; ++k) {
        heights[k + 1] =
            heights[k] + (1 + (e_next[k] + e_next[k + 1]) / 2) * delta;
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


    }
    e_prev = e_next;
  }
  num finalSettlement = 0;
  try{
    finalSettlement = settle[(hours/plot_interval).round()]*100;
  }
  catch(e){
    print(e);
  }
  List<Point> figTwoData = [
  ];
  for(num k=plot_interval;k<=hours;k+=plot_interval){

    figTwoData.add(
        Point(k,settle[(k/plot_interval).round()]*1000)
    );
    print(Point(k,settle[(k/plot_interval).round()]*1000));
  }
  figTwo.add(
      LineSeries<Point, num>(
        dataSource: figTwoData,
        xValueMapper: (Point data, _) => data.x,
        yValueMapper: (Point data, _) => data.y,
      )
  );
  print('Final Settlement = $finalSettlement');
  Map output = {};
  output['finalSettlement'] = finalSettlement;
  output['figOneData'] = figOne;
  output['figTwoData'] = figTwo;
  return output;

}

class ResultScreenNg extends StatefulWidget {

  static String id = 'result_screen_Ng';
  const ResultScreenNg({Key? key}) : super(key: key);

  @override
  State<ResultScreenNg> createState() => _ResultScreenNgState();
}


class _ResultScreenNgState extends State<ResultScreenNg> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, num>{}) as Map;
    final output = computeResult(arguments,context);
    final finalSettlement = output['finalSettlement'];
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          title: const Text('Results Page , Ng'),
          backgroundColor: const Color(0xff3F80FA),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text('Final Settlement: $finalSettlement'),
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
                  primaryXAxis: LogarithmicAxis(
                      title: AxisTitle(
                        text: 'Time(hours)',
                      ),
                      isInversed: false
                  ),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(
                        text: 'Settlement(mm)',
                      ),
                      isInversed: true
                  ),
                  series: output['figTwoData']
              ),
              // SfCartesianChart(
              //     series: output['figThreeData']
              // ),
            ],



          ),
        ),
      ),
    );
  }
}
