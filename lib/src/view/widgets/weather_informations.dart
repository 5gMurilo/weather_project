import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_wheater/src/model/wheater_model.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:flutter_svg/flutter_svg.dart';
class WeatherInformation extends StatelessWidget {
  const WeatherInformation({Key? key,required this.weather, required this.max, required this.min}) : super(key: key);

  final Weather weather;
  final double max;
  final double min;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(findSystemLocale().toString());
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(64, 0, 0, 0),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
                  Color.fromARGB(255, 197, 240, 238),
                  Color.fromARGB(255, 118, 232, 225)
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bom-dia!',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    '${weather.cityName} - ${weather.parentCity}',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),
                  ),
                  Text(
                    '${DateFormat('EEEE', 'pt_br').format(DateTime(weather.date.weekday))}, ${weather.date.day} de ${DateFormat("MMMM", "pt_br").format(DateTime(0, weather.date.month))} ',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        child: SvgPicture.asset(
                          'assets/images/sol.svg',
                          width: 177,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          '${weather.currentForecast}°C',
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          weather.phrase,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          'máx. $max°C | min. $min°C',
                          style: TextStyle(
                            fontFamily: 'Switzer',
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
