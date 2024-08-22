import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khm_app/provider/transaction_provider.dart';
import 'package:khm_app/utils/enum_app_page.dart';
import 'package:khm_app/utils/enum_state.dart';
import 'package:provider/provider.dart';

class UploadBuktiPembayaranScreen extends StatefulWidget {
  final void Function(AppPage) onTapped;

  const UploadBuktiPembayaranScreen({
    Key? key,
    required this.onTapped,
  }) : super(key: key);

  @override
  State<UploadBuktiPembayaranScreen> createState() =>
      _UploadBuktiPembayaranScreenState();
}

class _UploadBuktiPembayaranScreenState
    extends State<UploadBuktiPembayaranScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Preview'),
        actions: [
          Consumer<TransactionProvider>(builder: (context, state, _) {
            switch (state.state) {
              case ResultState.loading:
                return Center(
                  child: defaultTargetPlatform == TargetPlatform.iOS
                      ? const CupertinoActivityIndicator(
                          radius: 20.0,
                        )
                      : const CircularProgressIndicator(),
                );
              case ResultState.initial:
                return Container();
              case ResultState.error:
                return Container();
              case ResultState.loaded:
                if (state.transaction?.isEmpty ?? true) {
                  return Container();
                } else {
                  return TextButton(
                    onPressed: () async {
                      if (await state.uploadBuktiTransaksi()) {
                        Navigator.pop(context);
                      } else {}
                    },
                    child: Text('Upload'),
                  );
                }
            }
          }),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: () async {
            final transactionProvider = context.read<TransactionProvider>();
            await transactionProvider.pickImage();
          },
          child: Row(
            children: [
              Icon(Icons.image_outlined),
              Text('Pilih Ulang'),
            ],
          )),
      body: Consumer<TransactionProvider>(builder: (context, state, _) {
        switch (state.state) {
          case ResultState.loading:
            return Center(
              child: defaultTargetPlatform == TargetPlatform.iOS
                  ? const CupertinoActivityIndicator(
                      radius: 20.0,
                    )
                  : const CircularProgressIndicator(),
            );
          case ResultState.initial:
            return Container();
          case ResultState.error:
            return Container();
          case ResultState.loaded:
            if (state.transaction?.isEmpty ?? true) {
              return Container();
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state.buktiTransaksi == null
                        ? Text('No image selected.')
                        : Image.file(
                            state.buktiTransaksi!,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                  ],
                ),
              );
            }
        }
      }),
    );
  }
}
