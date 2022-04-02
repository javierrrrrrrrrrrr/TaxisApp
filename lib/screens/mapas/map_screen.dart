import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/views/views.dart';

import 'package:maps_app/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnownLocation == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              Map<String, Polyline> polylines = Map.from(mapState.polylines);
              if (!mapState.showMyRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }

              return Stack(
                children: [
                  MapView(
                    initialLocation: locationState.lastKnownLocation!,
                    polylines: polylines.values.toSet(),
                    markers: mapState.markers.values.toSet(),
                  ),
                  const SearchBar(),
                  const ManualMarker(),
                  const BottonModalShet(),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnownLocation != null) {
            return const BtnCurrentLocation();
          }
          return Container();
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

      // BtnToggleUserRoute(),
      // BtnFollowUser(),
    );
  }
}

class BottonModalShet extends StatelessWidget {
  const BottonModalShet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.08,
      minChildSize: 0.08,
      maxChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFf8ac00),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: BottonModalShetBody(scrollController: scrollController),
        );
      },
    );
  }
}

class BottonModalShetBody extends StatelessWidget {
  const BottonModalShetBody({
    Key? key,
    required this.scrollController,
  }) : super(key: key);
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: SizedBox(
        height: Get.height * 0.3,
        child: const LogicaBien(),
      ),
    );
  }
}

class LogicaBien extends StatelessWidget {
  const LogicaBien({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  width: 60,
                  height: 3,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Elija un Taxi",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            )
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                SelecionarTipoTaxi(texto: "Economico"),
                SelecionarTipoTaxi(texto: "Econmico"),
                SelecionarTipoTaxi(texto: "Econmico"),
                SelecionarTipoTaxi(texto: "Econmico"),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        const HeaderDrawer(),
        const CustomListTile(
          text: "Mapa",
          icon: Icons.person,
        ),
        const Separador(),
        const CustomListTile(
          text: "Favoritos",
          icon: Icons.favorite,
        ),
        const Separador(),
        const CustomListTile(
          text: "Historial",
          icon: Icons.history,
        ),
        const Separador(),
        const CustomListTile(
          text: "Mi monedero",
          icon: Icons.credit_card,
        ),
        const Separador(),
        const CustomListTile(
          text: "Acerca de",
          icon: Icons.info_sharp,
        ),
        const Separador(),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 30),
          child: ListTile(
            leading: const Icon(
              Icons.logout,
              size: 40,
              color: Colors.grey,
            ),
            title: const Text("Salir",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                )),
            onTap: () {},
          ),
        ),
      ]),
    );
  }
}

class Separador extends StatelessWidget {
  const Separador({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, width: Get.width * 0.70, color: Colors.grey);
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.icon,
    required this.text,
    this.color,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 35,
        color: color ?? const Color(0xFFF9AC00),
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onTap: () {},
    );
  }
}

class HeaderDrawer extends StatelessWidget {
  const HeaderDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.height * 0.26,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFF9AC00),
          ),
        ),
        Positioned(
          top: Get.height * 0.06,
          left: Get.height * 0.12,
          child: Column(
            children: const [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://blogs.publico.es/strambotic/files/2019/02/person7-1.jpeg',
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Laura Perez",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SelecionarTipoTaxi extends StatelessWidget {
  const SelecionarTipoTaxi({
    Key? key,
    required this.texto,
    this.imagen,
  }) : super(key: key);
  final String texto;
  final String? imagen;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: SvgPicture.asset(
                "assets/carro.svg",
                fit: BoxFit.cover,
              )),
          const SizedBox(height: 10),
          Text(texto,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ],
      ),
    );
  }
}
