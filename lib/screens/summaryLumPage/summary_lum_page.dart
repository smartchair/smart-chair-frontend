import 'package:flutter/material.dart';
import 'package:smart_chair_frontend/barGraphWidget/barGraphWidget.dart';
import 'package:smart_chair_frontend/stores/graph_data_store.dart';

class SummaryLumPage extends StatelessWidget {
  final GraphStore graphStore;
  SummaryLumPage(this.graphStore);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Hero(
                tag: 'lum',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BarGraph(
                      graphStore, 'Luminosidade (Lux)', 'averageLum', 320),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
