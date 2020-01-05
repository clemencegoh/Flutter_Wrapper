
import 'package:flutter/material.dart';
import 'package:flutter_app/projects/qrCodeScanner/qrGeneratorRepository.dart';
import 'package:form_bloc/form_bloc.dart';

class QRFormBloc extends FormBloc<String, String> {
  final messageField = TextFieldBloc();

  BuildContext context;

  QRFormBloc(this.context);

  @override
  List<FieldBloc> get fieldBlocs => [messageField];

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {

    // Generate new instance on every submit
    QRGeneratorRepository _repository = new QRGeneratorRepository();

    try {
      Widget builtImage = await _repository.GenerateQRImageFrom(messageField.value);

      Dialog toShow = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
            height: 300.0,
            width: 300.0,
            padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0
            ),
            child: builtImage,
        ),
      );

      showDialog(
        context: this.context,
        builder: (BuildContext context) => toShow,
      );

      // todo: actually save this into recents tab

      yield currentState.toSuccess();
    } catch (e) {
      yield currentState.toFailure("$e");
    }
  }
}