import 'package:intl/intl.dart';

class ATDateUtils{

  String getCurrentDate(){
    return DateFormat('MM/dd/yyyy').format(DateTime.now());
  }

  String formatStrDate( String dt, {String inputPattern="yyyy-MM-dd HH:mm:ss", String outputPattern="yyyy-MM-dd HH:mm:ss"} ){
    return DateFormat(outputPattern).format(DateFormat(inputPattern).parse(dt));
  }


  String format( DateTime dt, {String pattern="yyyy-MM-dd HH:mm:ss"} ){
    return DateFormat(pattern).format(dt);
  }

  String formatDate(String dt){
    final f = new DateFormat('MM/dd/yyyy hh:mm a');
    return f.format(DateTime.parse(dt));
  }

  DateTime parse( String dt, {String pattern="yyyy-MM-dd HH:mm:ss"} ){
    return DateFormat(pattern).parse(dt);
  }

  String Format( String dt, {String pattern="yyyy-MM-dd HH:mm:ss"} ){

    String strDate =   format(pattern:"MMM d, yyyy", parse(dt)  );
    String strTime =   format(pattern:"hh:mm a", parse(dt)  );

    return "$strDate at $strTime";
  }


}