import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/delegates/delegates.dart';
import 'package:maps_app/models/models.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const SizedBox()
            : FadeInDown(
                duration: const Duration(milliseconds: 300),
                child: const _SearchBarBody());
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({Key? key}) : super(key: key);

  void onSearchResults(BuildContext context, SearchResult result) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    if (result.manual == true) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }

    if (result.position != null) {
      final destination = await searchBloc.getCoorsStartToEnd(
          locationBloc.state.lastKnownLocation!, result.position!);
      await mapBloc.drawRoutePolyline(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
              left: 10,
            ),
            child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(
                Icons.menu,
                size: 30,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            child: GestureDetector(
                onTap: () async {
                  final result = await showSearch(
                      context: context, delegate: SearchDestinationDelegate());
                  if (result == null) return;

                  onSearchResults(context, result);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.local_fire_department_outlined),
                          SizedBox(width: 10),
                          Text('¿Dónde quieres ir?',
                              style: TextStyle(color: Colors.black87)),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 1,
                        width: 300,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: const [
                          Icon(Icons.location_on),
                          SizedBox(width: 10),
                          Text('Elija un destino',
                              style: TextStyle(color: Colors.black87)),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF9AC00),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 5))
                      ]),
                )),
          ),
        ],
      ),
    );
  }
}
