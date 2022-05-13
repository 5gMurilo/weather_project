import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../model/wheater_model.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({Key? key, required this.weather}) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            SvgPicture.asset('assets/images/sol.svg'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'qua. 20/04',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    letterSpacing: -0.1,
                  ),
                ),
                Text(
                  'ensolarado',
                  style: TextStyle(
                      fontFamily: 'Switzer',
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            Expanded(
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Text(
                            'máx.\n${weather.maxTemp}°',
                            style: TextStyle(
                                fontFamily: 'Switzer',
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        width: 20,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.black,
                      ),
                      Column(
                        children: [
                          Text(
                            'min.\n${weather.maxTemp}°',
                            style: TextStyle(
                              fontFamily: 'Switzer',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 7,
    );
  }
}
