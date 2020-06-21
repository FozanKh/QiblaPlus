import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qibla_plus/model/constants.dart';

// class EnglishTips extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       key: ValueKey('englishTips'),
//       height: 150,
//       width: MediaQuery.of(context).size.width,
//       alignment: Alignment.centerLeft,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(kEnTip1, textAlign: TextAlign.left, style: kEnTipsTextStyle),
//           RichText(
//             text: TextSpan(
//               children: [
//                 WidgetSpan(
//                   child: Icon(Icons.all_inclusive, size: 20),
//                 ),
//                 TextSpan(
//                   text: kEnTip2,
//                   style: kEnTipsTextStyle,
//                 ),
//               ],
//             ),
//           ),
//           // Row(
//           //   crossAxisAlignment: CrossAxisAlignment.center,
//           //   mainAxisAlignment: MainAxisAlignment.end,
//           //   children: <Widget>[
//           //     Padding(
//           //       padding: EdgeInsets.only(right: 5.0),
//           //       child: Icon(Icons.all_inclusive, size: 20),
//           //     ),
//           //     Text(
//           //       kEnTip2,
//           //       style: kEnTipsTextStyle,
//           //     ),
//           //   ],
//           // ),
//           // Text(kEnTip3, textAlign: TextAlign.left, style: kEnTipsTextStyle),
//           // Text(kEnTip4, textAlign: TextAlign.left, style: kEnTipsTextStyle),
//         ],
//       ),
//     );
//   }
// }

// class ArabicTips extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       key: ValueKey('arabicTips'),
//       height: 150,
//       width: MediaQuery.of(context).size.width,
//       alignment: Alignment.centerRight,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(kArTip1, textAlign: TextAlign.right, style: kArTipsTextStyle, textScaleFactor: 1.1),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               Text(kArTip2, textAlign: TextAlign.right, style: kArTipsTextStyle, textScaleFactor: 1.1),
//               Padding(
//                 padding: const EdgeInsets.only(left: 5.0),
//                 child: Icon(Icons.all_inclusive, size: 20),
//               ),
//             ],
//           ),
//           Text(kArTip3, textAlign: TextAlign.right, style: kArTipsTextStyle, textScaleFactor: 1.1),
//           Text(kArTip4, textAlign: TextAlign.right, style: kArTipsTextStyle, textScaleFactor: 1.1),
//         ],
//       ),
//     );
//   }
// }

class EnglishTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('englishTips'),
      height: 150,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      child: Text(kEnTips, textAlign: TextAlign.left, style: kEnTipsTextStyle),
    );
  }
}

class ArabicTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('arabicTips'),
      height: 150,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerRight,
      child: Text(kArTips, textAlign: TextAlign.right, style: kArTipsTextStyle, textScaleFactor: 1.1),
    );
  }
}
