import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../blocs/map/map_bloc.dart';

class FondoNegocio extends StatelessWidget {
  const FondoNegocio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locationBloc = BlocProvider.of<MapBloc>(context);
    const CameraPosition initialCameraPosition =
        CameraPosition(target: LatLng(22.423422, -83.699770), zoom: 16.5);

    List<Marker> markers = [];
    markers.add(Marker(
      /*--(1) poner cartel al tocar marcador*/
      // infoWindow: InfoWindow(title: 'Hellloooo'),
      icon: locationBloc.prueba,

      markerId: const MarkerId('1'),
      position: const LatLng(22.423787, -83.699073),
    ));

    //final Map<MarkerId, Marker> _markers = {};
    //  Set<Marker> markers = marke.values.toSet();

    return Scaffold(
      body: Stack(children: [
        SizedBox(
          height: Get.height * 0.8,
          width: Get.width,
          child: GoogleMap(
            initialCameraPosition: initialCameraPosition,
            compassEnabled: false,
            /*--(3)  para desabilitar interaccion con el mapa--*/
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: false,
            tiltGesturesEnabled: false,
            /*--(1) mostrar la ubicacion del usuario */
            // myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            // polylines: polylines,
            markers: Set.from(markers),
            //  onMapCreated: ( controller ) => mapBloc.add( OnMapInitialzedEvent(controller) ),
            //  onCameraMove: ( position ) => mapBloc.mapCenter = position.target
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: Get.height * 0.53),
          height: Get.height * 0.5,
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(children: [
            SizedBox(
              height: Get.height * 0.015,
            ),
            const CircleAvatar(
              maxRadius: 60,
              backgroundImage: AssetImage('assets/barber2.png'),
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            const Text(
              "Barber Shop",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: Get.height * 0.005,
            ),
            RatingBar.builder(
              ignoreGestures: true,
              itemSize: 25,
              initialRating: 4,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Color.fromRGBO(24, 205, 202, 1),
              ),
              onRatingUpdate: (rating) {},
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            SizedBox(
              width: Get.width * 0.9,
              child: const Text(
                'La única barbería de Cuba con servicio wifi gratis, llevamos 8 años en el sector de la moda y la barbería.',
                style: TextStyle(fontSize: 18, fontFamily: 'Inter'),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  color: const Color.fromRGBO(24, 205, 202, 1),
                  iconSize: 45,
                  onPressed: () {},
                  icon: const Icon(Icons.message),
                ),
                IconButton(
                  color: const Color.fromRGBO(24, 205, 202, 1),
                  iconSize: 45,
                  onPressed: () {},
                  icon: const Icon(Icons.phone),
                ),
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
