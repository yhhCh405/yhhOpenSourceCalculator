import 'package:flutter/material.dart';

class NumberButton {
  double numFontSize = 30;

  Widget IntNumButton({@required int number,@required Function onPressed}) {
    String numString = number.toString();
    return _numpadContainer(
      child: Text(numString,style: TextStyle(fontSize: numFontSize,fontWeight: FontWeight.bold,),),
      onPressed: onPressed,
    );
  }

  Widget ImageNumButton({@required ImageIcon imageIcon,@required Function onPressed}) {
    return _numpadContainer(
      child: imageIcon,
      onPressed: onPressed,
    );
  }

  Widget IconNumButton({@required IconData icon,@required Function onPressed}) {
    return _numpadContainer(
      child: Icon(icon,color: Colors.red,),
      onPressed: onPressed,
    );
  }

  Widget StringNumButton({@required String string,Function onPressed,Color color:Colors.red,Color backgroundColor:Colors.white,disabled:false}) {
    if (disabled ==true){
      return Container();
    }else{
    return _numpadContainer(
      child: Text(string,style: TextStyle(fontSize: numFontSize,fontWeight: FontWeight.bold,color: color),),
      onPressed: onPressed ?? (){},
      backgroundColor: backgroundColor,
    );
    }
  }

  Widget InvisibleButton(){
    return _numpadContainer(child: Text(""), onPressed: (){},backgroundColor: Colors.white);
  }


  Widget _numpadContainer({@required Widget child,Color backgroundColor:Colors.white,@required Function onPressed()}) {
    return Container(
      child: FlatButton(
        child: child,
        color: backgroundColor,
        onPressed: onPressed,
      ),
    );
  }

}
