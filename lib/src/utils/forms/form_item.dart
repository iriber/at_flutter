
abstract class FormItem{

  String? errorMessage;

  FormItem({ this.errorMessage});

  bool isEmpty();

  bool checkEmpty({String msg="Required"}){
    bool empty=false;
    if( isEmpty() ){
      empty=true;
      this.errorMessage = msg;
    }
    return empty;
  }


}
