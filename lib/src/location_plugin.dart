import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_map/flutter_map.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_map/plugin_api.dart';

import 'location_layer.dart';
import 'location_options.dart';

class LocationPlugin extends MapPlugin {
  @override
  Widget createLayer(
      LayerOptions? options, MapState? mapState, Stream<void>? stream) {
    if (options is LocationOptions) {
      return LocationLayer(options: options, map: mapState, stream: stream);
    }
    throw ArgumentError('options is not of type LocationOptions');
  }

  @override
  bool supportsLayer(LayerOptions? options) {
    return options is LocationOptions;
  }
}
