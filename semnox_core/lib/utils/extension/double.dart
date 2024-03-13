extension DoubleFormat on num{
  num toFixedDigits({int fractionDigits = 2} ){
       return num.parse((toStringAsFixed(fractionDigits)));
  } 

  String toCurrency({String symbol = "\$", int fractionDigits = 2 }){
    return "$symbol ${toFixedDigits(fractionDigits: fractionDigits)}";
  }
}