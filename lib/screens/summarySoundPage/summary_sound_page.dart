import 'package:flutter/material.dart';
import 'package:smart_chair_frontend/barGraphWidget/barGraphWidget.dart';
import 'package:smart_chair_frontend/stores/graph_data_store.dart';

class SummarySoundPage extends StatelessWidget {
  final GraphStore graphStore;
  SummarySoundPage(this.graphStore);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Hero(
                tag: 'sound',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      BarGraph(graphStore, 'Ruído (dBs)', 'averageNoise', 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
