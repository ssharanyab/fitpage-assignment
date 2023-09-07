import 'package:fitpage_assignment/views/more_details.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class DetailsScreen extends StatefulWidget {
  final data;
  const DetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(widget.data['name']),
              tileColor: const Color.fromRGBO(37, 150, 190, 1),
              subtitle: Text(
                widget.data['tag'],
                style: widget.data['color'].contains('green')
                    ? const TextStyle(color: Colors.green)
                    : const TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            getDisplayTextWidget(widget.data['criteria']),
            //Text(getString(widget.data['criteria'])),
          ],
        ),
      ),
    );
  }

  Widget getDisplayTextWidget(data) {
    String str = '';
    String originalStr = '';
    List<String> replaced = [];
    List<String> original = [];

    bool isVariable = false;
    for (var i = 0; i < data.length; i++) {
      str = str + data[i]['text'];
      originalStr = originalStr + data[i]['text'];
      if (data[i]['type'] == 'variable') {
        isVariable = true;
        for (var e = 0; e < str.length; e++) {
          if (str[e] == '\$') {
            str = str.replaceRange(
                e, e + 2, Utils().getVariable(data[i], str[e + 1]));
          }
        }
      }
      if (i != data.length - 1) {
        str = '$str\n\nand\n\n';
        originalStr = '$originalStr\n\nand\n\n';
      }
    }

    replaced = str.split(' ');
    original = originalStr.split(' ');

    return isVariable
        ? RichText(
            text: TextSpan(
            children: [
              for (var i = 0; i < replaced.length; i++)
                if (original[i] == replaced[i])
                  TextSpan(
                    text: '${original[i]} ',
                    style: const TextStyle(),
                  )
                else
                  TextSpan(
                    text: '${replaced[i]} ',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoreDetails(
                                      data: data,
                                      original: original[i],
                                    )));
                      },
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
            ],
          ))
        : Text(str);
  }
}
