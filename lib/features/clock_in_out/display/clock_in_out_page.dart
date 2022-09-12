import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as lokasi;

import '../../../common/utils/color_const.dart';
import 'take_picture_page.dart';

class ClockInOutPage extends StatefulWidget {
  const ClockInOutPage({
    Key? key,
  }) : super(key: key);

  @override
  _ClockInOutPageState createState() => _ClockInOutPageState();
}

class _ClockInOutPageState extends State<ClockInOutPage> {
  // static LatLng ptPortoIndonesia = LatLng(-6.13591, 106.77496);
  late final MapController _mapController;
  lokasi.LocationData? _currentLocation;
  final lokasi.Location _locationService = lokasi.Location();

  late final TextEditingController _description;
  final bool _liveUpdate = true;
  bool _permission = false;
  bool rotateMarkerLayerOptions = true;
  String? _serviceError = '';

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _description = TextEditingController();
    initLocationService();
  }

  void _navigateAndTakeCamera() async {
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePicturePage(
          camera: firstCamera,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _description.dispose();
    super.dispose();
  }

  void initLocationService() async {
    await _locationService.changeSettings(
      accuracy: lokasi.LocationAccuracy.high,
      interval: 10000,
    );

    lokasi.LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        var permission = await _locationService.requestPermission();
        _permission = permission == lokasi.PermissionStatus.granted;

        if (_permission) {
          location = await _locationService.getLocation();
          _currentLocation = location;
          _locationService.onLocationChanged
              .listen((lokasi.LocationData result) async {
            if (mounted) {
              setState(() {
                _currentLocation = result;

                // If Live Update is enabled, move map center
                if (_liveUpdate) {
                  _mapController.move(
                      LatLng(_currentLocation!.latitude!,
                          _currentLocation!.longitude!),
                      _mapController.zoom);
                }
              });
            }
          });
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      location = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;
    var locationAccuracy = _currentLocation?.accuracy ?? 0.0;

    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    } else {
      currentLatLng = LatLng(0, 0);
    }
    var marker = <Marker>[
      Marker(
        width: 80.w,
        height: 80.0.h,
        point: currentLatLng,
        builder: (context) => const Icon(
          // Icons.location_on,
          Icons.location_on,
          size: 40.0,
          color: Colors.red,
        ),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clock In/Out',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: ColorConst.defaultColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 28.h,
              color: const Color(0xff272B40),
              child: Center(
                child: Text(
                  "08:30-17:30 ( Office Hour 1 )",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 300.h,
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      center: LatLng(
                        currentLatLng.latitude,
                        currentLatLng.longitude,
                      ),
                      zoom: 18.0,
                      minZoom: 15,
                      maxZoom: 18.0,
                      interactiveFlags: InteractiveFlag.none,
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                        tileProvider: NetworkTileProvider(),
                      ),
                      MarkerLayerOptions(
                        rotate: rotateMarkerLayerOptions,
                        markers: marker,
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Akurasi lokasi: ${locationAccuracy.toStringAsFixed(2)} m',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 100.h,
                child: TextField(
                  maxLines: 4,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Notes',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Align(
                        alignment: Alignment.topCenter,
                        widthFactor: 1.0.w,
                        heightFactor: 10.0.h,
                        child: const Icon(
                          Icons.notes,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cara mengambil foto',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      PetunjukWidget(
                        imgPath: 'assets/images/img_benar.png',
                        caption: 'Benar',
                      ),
                      PetunjukWidget(
                        imgPath: 'assets/images/img_salah_terang.png',
                        caption: 'Terlalu Terang',
                      ),
                      PetunjukWidget(
                        imgPath: 'assets/images/img_salah_buram.png',
                        caption: 'Buram',
                      ),
                      PetunjukWidget(
                        imgPath: 'assets/images/img_salah_terpotong.png',
                        caption: 'Terpotong',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 45.h,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    // _navigateAndTakeCamera();
                    print(
                      '${currentLatLng.latitude} , ${currentLatLng.longitude}',
                    );
                  },
                  child: const Text(
                    'Ambil Foto',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: ColorConst.defaultColor,
                  borderRadius: BorderRadius.circular(6.5.r),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PetunjukWidget extends StatelessWidget {
  const PetunjukWidget({
    required this.imgPath,
    required this.caption,
    Key? key,
  }) : super(key: key);

  final String imgPath;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imgPath,
          width: 76.w,
          height: 74.h,
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          caption,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
