// String priceFormated(double value) {
//   String stringValue = value.toStringAsFixed(2); // ensures 2 decimal places
//   List<String> parts = stringValue.split('.'); // [integerPart, decimalPart]

//   String integerPart = parts[0];
//   String decimalPart = parts[1];

//   StringBuffer formattedInt = StringBuffer();

//   int count = 0;
//   for (int i = integerPart.length - 1; i >= 0; i--) {
//     formattedInt.write(integerPart[i]);
//     count++;
//     if (count % 2 == 0 && i != 0) {
//       formattedInt.write(',');
//     }
//   }

//   // Reverse back to original order
//   String finalInt = formattedInt.toString().split('').reversed.join('');
//   return '$finalInt.$decimalPart';
// }
String priceFormated(double value) {
  String stringValue = value.toStringAsFixed(2); // ensures 2 decimal places
  List<String> parts = stringValue.split('.');
  String integerPart = parts[0];
  String decimalPart = parts[1];

  final buffer = StringBuffer();
  int offset = integerPart.length % 3;
  if (offset > 0) {
    buffer.write(integerPart.substring(0, offset));
    if (integerPart.length > 3) buffer.write(',');
  }

  for (int i = offset; i < integerPart.length; i += 3) {
    buffer.write(integerPart.substring(i, i + 3));
    if (i + 3 < integerPart.length) buffer.write(',');
  }

  return '${buffer.toString()}.$decimalPart';
}
