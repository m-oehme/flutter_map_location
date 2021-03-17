import 'package:flutter/material.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:flutter_map_location/src/types.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_map/flutter_map.dart';

void main() {
  testWidgets('Render app', (WidgetTester tester) async {
    await tester.pumpWidget(_TestApp());
    // See https://github.com/flutter/flutter/issues/11181#issuecomment-568737491
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.byType(FlutterMap), findsOneWidget);
    expect(find.byType(LocationLayer), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}

class _TestApp extends StatelessWidget {
  final MapController mapController = MapController();
  final List<Marker> userLocationMarkers = <Marker>[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FlutterMap(
            options: MapOptions(
              plugins: <MapPlugin>[
                LocationPlugin(),
              ],
            ),
            layers: <LayerOptions>[
              TileLayerOptions(
                  urlTemplate: 'https://{s}.tile.example.org/{z}/{x}/{y}.png',
                  subdomains: <String>['a', 'b', 'c']),
              MarkerLayerOptions(markers: userLocationMarkers),
              LocationOptions(
                markers: userLocationMarkers,
                onLocationUpdate: (LatLngData ld) {},
                onLocationRequested: (LatLngData ld) {},
                buttonBuilder: (BuildContext context,
                    ValueNotifier<LocationServiceStatus> status,
                    Function onPressed) {
                  return Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
                      child: FloatingActionButton(
                          child: const Icon(
                            Icons.location_searching,
                          ),
                          onPressed: () {}),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
