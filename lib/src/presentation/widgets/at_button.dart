
import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/utils/at_responsive_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_styles.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_responsive_text.dart';

class ATButton extends StatelessWidget{

  Function(BuildContext context) onTap;
  ButtonStyle? buttonStyle;
  String label;
  double height;
  double? width;
  bool widthVariable;
  TextStyle? labelStyle;
  int? maxLines;
  Widget? iconLabel;
  bool toUppercase;

  ATButton( {this.toUppercase=true, required this.label, required this.onTap, this.buttonStyle, this.height=40,  this.labelStyle,this.widthVariable=false,this.width, this.maxLines, this.iconLabel } );

  @override
  Widget build(BuildContext context) {

    double responsiveHeight = height* ATResponsiveUtils().getButtonHeightScale(context);

    String txtLabel = (this.toUppercase?label.toUpperCase():label);

    return Container(
        height: responsiveHeight,
        width: width?? MediaQuery.of(context).size.width,
       // width: widthVariable == false ?  MediaQuery.of(context).size.width :width ,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
          style:buttonStyle,
          child: this.iconLabel != null ? Row(
            children: [
              Spacer(),
              Padding(padding: EdgeInsets.only(right: 10,left: 10),
              child: this.iconLabel,
              ),

              ATResponsiveText(txtLabel,
              style: labelStyle,
              maxLines: maxLines??1,
              textAlign: TextAlign.center,
            ),
            Spacer(),],
          ) :  ATResponsiveText(txtLabel,
            style: labelStyle,
            maxLines: maxLines??1,
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            onTap(context);
          },
        ));
  }
}


class ATPrimaryButton extends ATButton{

  ATPrimaryButton({double? fontSize, required super.label, required super.onTap, super.height, super.labelStyle,super.width,super.widthVariable, super.maxLines, super.iconLabel}){
    super.buttonStyle = ATButtonStyles.getPrimaryBtn(fontSize: fontSize);
  }
}


class ATSecondaryButton extends ATButton{

  ATSecondaryButton({required super.label, required super.onTap, super.width, super.height, super.labelStyle, super.iconLabel}){
    super.buttonStyle  = ATButtonStyles.secondaryBtn;
  }
}

class ATTertiaryButton extends ATButton{

  ATTertiaryButton({double? fontSize, required super.label, required super.onTap, super.height,super.widthVariable,super.width, super.iconLabel}){
    super.buttonStyle  = ATButtonStyles.getTertiaryBtn(fontSize: fontSize);
    super.labelStyle = TextStyle(color:Environment().config.appTheme.getSecondaryBackgroundColor());
  }

}

class ATPrimartBorderedButton extends ATButton{

  ATPrimartBorderedButton({double? fontSize, required super.label, required super.onTap, super.height,super.widthVariable,super.width}){
    super.buttonStyle  = ATButtonStyles.getSecondaryBtnBordered(fontSize: fontSize);
    super.labelStyle = TextStyle(color: Environment().config.appTheme.getSecondaryForegroundColor());
  }
}


class ATSecondaryBorderedButton extends ATButton{

  ATSecondaryBorderedButton({double? fontSize, required super.label, required super.onTap, super.height,super.widthVariable,super.width}){
    super.buttonStyle  = ATButtonStyles.getSecondaryBtnBordered(fontSize: fontSize);
    super.labelStyle = TextStyle(color: Environment().config.appTheme.getSecondaryForegroundColor());
  }
}

class ATGradientButton extends StatelessWidget{

  Function(BuildContext context) onTap;
  ButtonStyle? buttonStyle;
  String label;
  double height;
  TextStyle? labelStyle;

  ATGradientButton( {required this.label, required this.onTap, this.buttonStyle, this.height=50, this.labelStyle} );

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: MediaQuery.of(context).size.width ,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.pink, Colors.green])),
        //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
          //style:buttonStyle,
          style: ElevatedButton.styleFrom(foregroundColor: Colors.transparent, shadowColor: Colors.transparent),
          //style: ElevatedButton.styleFrom( shadowColor: Colors.transparent),
          child: Text(label, style: labelStyle),
          onPressed: () {
            onTap(context);
          },
        ));
  }
}