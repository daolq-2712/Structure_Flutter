import 'package:flutter/material.dart';

import '/gen_l10n/resource_string.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  final Function retry;

  const ErrorPage({super.key, required this.message, required this.retry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          OutlinedButton(
            onPressed: () => retry,
            child: Text(
              AppLocalizations.of(context)?.retry ?? 'Retry',
            ),
          ),
        ],
      ),
    );
  }
}
