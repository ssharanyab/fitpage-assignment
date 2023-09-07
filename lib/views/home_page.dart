import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/stock_provider.dart';
import 'details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<StockProvider>(context, listen: false).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<StockProvider>(
        builder: (context, stockProvider, child) {
          if (stockProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: stockProvider.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(stockProvider.data[index]['name']),
                    subtitle: Text(
                      stockProvider.data[index]['tag'],
                      style:
                          stockProvider.data[index]['color'].contains('green')
                              ? const TextStyle(color: Colors.green)
                              : const TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                    data: stockProvider.data[index],
                                  )));
                    });
              },
            );
          }
        },
      ),
    );
  }
}
