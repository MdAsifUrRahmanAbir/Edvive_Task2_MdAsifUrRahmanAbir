import 'package:flutter/material.dart';
import 'package:language_tool/language_tool.dart';
// import 'package:language_tool/language_tool.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  String userInput = '';
  String resultInput = '';
  var tool = LanguageTool();
  // var badSentences = [
  //   'Flutetr is Google’s UI toolkti for building beatuiful applicatoins',
  //   'what happened at 5 PM in the afternoon on Monday, 27 May 2007?'
  // ];


  ///Prints every property for every [WritingMistake] passed.
  // void printDetails(List<WritingMistake> result) {
  //   for (var mistake in result) {
  //     print('''
  //       Issue: ${mistake.message}
  //       Issue Type: ${mistake.issueDescription}
  //       positioned at: ${mistake.offset}
  //       with the length of ${mistake.length}.
  //       Possible corrections: ${mistake.replacements}
  //   ''');
  //   }
  //
  // }

  /// prints the given [sentence] with all mistakes marked red. but red mark only in console
  void markMistakes(List<WritingMistake> result, String sentence) {
    ///it gives the mistake red color but not working in widget, for check remove its comment and look in print result
    var red = '\u001b[31m';
    var reset = '\u001b[0m';

    ///for showing in app
    // var red = '[';
    // var reset = ']';

    var addedChars = 0;

    for (var mistake in result) {
      sentence = sentence.replaceRange(
        mistake.offset! + addedChars,
        mistake.offset! + mistake.length! + addedChars,
        red +
            sentence.substring(mistake.offset! + addedChars,
                mistake.offset! + mistake.length! + addedChars) +
            reset,
      );
      addedChars += 9;
    }

    print(sentence);
    setState(() {
      _textEditingController.text = sentence.toString();
    });
  }

  mistakeCheckes() async{
    // Works for spelling mistakes.
    var result = await tool.check(userInput);
    markMistakes(result, userInput);

    /// Logic check.
    // result = await tool.check(userInput);
    // printDetails(result);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edvive Task2', style: TextStyle(color: Colors.grey),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            /// TextFeild
            TextField(
              controller: _textEditingController,
              maxLines: 5,
              onChanged: (val) {
                setState(() {
                  userInput = val;
                });
              },
              decoration: const InputDecoration(
                  hintText: 'Press the button and start speaking',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            ),
            const SizedBox(height: 10,),

            /// translate button
            MaterialButton(
                height: 50,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.blue,)
                ),
                child: const Text('Check', style: TextStyle(color: Colors.white, fontSize: 20 )),
                onPressed: (){
                  mistakeCheckes();
                }
            ),
            const SizedBox(height: 10,),

            ///Result
            const Center(
              child: Text('For better result please run the code and check in console.'),
            )
          ],
        ),
      ),
    );
  }
}
