import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class NetworkPage extends StatefulWidget {
  @override
  _NetworkPageState createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  String _connectionStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult result =
        ConnectivityResult.none; // Initialize with default value
    try {
      result = await Connectivity().checkConnectivity();
    } on Exception catch (e) {
      print(e.toString());
    }

    if (!mounted) return;

    _updateConnectionStatus(result);
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        _connectionStatus = 'Connected';
      } else if (result == ConnectivityResult.none) {
        _connectionStatus = 'No connection';
      } else {
        _connectionStatus = 'Unknown';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Status'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Connection Status:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10),
            Text(
              _connectionStatus,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
