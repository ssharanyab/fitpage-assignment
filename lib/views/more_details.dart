import 'package:flutter/material.dart';

class MoreDetails extends StatefulWidget {
  final data;
  final String original;
  const MoreDetails({Key? key, required this.data, required this.original})
      : super(key: key);

  @override
  State<MoreDetails> createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  String type = '';
  int defaultValue = 0;
  List<num> values = [];

  TextEditingController periodController = TextEditingController();

  @override
  void initState() {
    for (var i = 0; i < widget.data.length; i++) {
      if (widget.data[i]['variable'][widget.original] != null) {
        setState(() {
          type = widget.data[i]['variable'][widget.original]['type'];
          if (type == 'indicator') {
            defaultValue =
                widget.data[i]['variable'][widget.original]['default_value'];
          }
          if (type == 'value') {
            values = widget.data[i]['variable'][widget.original]['values']
                .cast<num>();
            values.sort();
          }
        });
      }
    }

    periodController.text = defaultValue.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Details'),
      ),
      body: type == 'indicator'
          ? Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RSI',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Set Parameters',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 250,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Period',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              width: 250,
                              child: TextField(
                                controller: periodController,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: 'Period',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: values.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Text(values[index].toString()),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
