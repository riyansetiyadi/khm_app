import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorRefresh extends StatelessWidget {
  const ErrorRefresh({
    super.key,
    this.errorTitle,
    this.refreshTitle,
    this.onPressed,
  });

  final String? errorTitle;
  final String? refreshTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    print(onPressed);
    return Center(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorTitle ?? "Gagal mendapatkan data!",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              if (refreshTitle != null)
                Text(
                  refreshTitle!,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              if (onPressed != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Warna latar belakang
                    shape: BoxShape.circle, // Bentuk lingkaran
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      defaultTargetPlatform == TargetPlatform.iOS
                          ? CupertinoIcons.refresh
                          : Icons.refresh,
                      color: Colors.green,
                      size: 20,
                    ),
                    style: ButtonStyle(
                      iconSize: WidgetStateProperty.all<double>(35),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
