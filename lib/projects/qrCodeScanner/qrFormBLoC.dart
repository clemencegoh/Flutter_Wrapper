import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/projects/qrCodeScanner/qrGeneratorRepository.dart';
import 'package:form_bloc/form_bloc.dart';

class QRFormBloc extends FormBloc<String, String> {
  final messageField = TextFieldBloc();

  final QRGeneratorRepository _repository;
  BuildContext context;

  QRFormBloc(this._repository, this.context);

  @override
  List<FieldBloc> get fieldBlocs => [messageField];

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {
    try {
      Widget builtImage = _repository.GenerateQRImageFrom(messageField.value);

      Dialog toShow = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
            height: 300.0,
            width: 300.0,
            child: builtImage,
        ),
      );

      showDialog(
        context: this.context,
        builder: (BuildContext context) => toShow,
      );

      // todo: verify if flushbar works
      Flushbar(
        message: "Image saved to recent",
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue[300],
        ),
        margin: EdgeInsets.all(8),
        borderRadius: 16.0,
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue[300],
      )..show(this.context);

      // todo: actually save this into recents tab

      yield currentState.toSuccess();
    } catch (e) {
      yield currentState.toFailure("$e");
    }
  }
}