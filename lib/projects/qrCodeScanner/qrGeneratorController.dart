import 'package:flutter/material.dart';
import 'package:flutter_app/projects/qrCodeScanner/qrFormBLoC.dart';
import 'package:flutter_app/projects/qrCodeScanner/qrGeneratorRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class QRGenerator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _QrGeneratorState();
}

class _QrGeneratorState extends State<QRGenerator> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<_QrGeneratorState>();

  QRGeneratorRepository repository = new QRGeneratorRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QRFormBloc>(
      builder: (context) =>
          QRFormBloc(this.repository, context),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<QRFormBloc>(context);

          return Scaffold(
            body: FormBlocListener<QRFormBloc, String, String>(
              onSuccess: (context, state){  },
              onFailure: (context, state){  },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  TextFieldBlocBuilder(
                    textFieldBloc: formBloc.messageField,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      labelText: 'URL or string to encode',
                      prefixIcon: Icon(Icons.format_quote),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                      onPressed: formBloc.submit,
                      child: Center(child: Text('Generate')),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}