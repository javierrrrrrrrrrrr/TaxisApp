import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../blocs/map/map_bloc.dart';
import '../../widgets/Principales/vertical_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: SearchInput(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 10),
                child: _popularesTittle(context),
              ),
              SizedBox(
                height: 210,
                width: Get.width,
                child: const CardHorizontalSwiper(),
              ),
              _ultimosServiciosTittle(context),
              SizedBox(
                width: Get.width,
                height: Get.height * 0.55,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    HorizontalCard(
                      imagen: "assets/software.png",
                      title: "Software Dev",
                      content:
                          "Desarrollo de software a la medida para cubrir la necesidad del negocio",
                    ),
                    HorizontalCard(
                      imagen: "assets/payaso.png",
                      title: "Payaso para cumpleaños",
                      content:
                          "Servicio de payaso para cumpleaños, contactenos y le atenderemos 24 H",
                    ),
                    HorizontalCard(
                      imagen: "assets/cuarto.png",
                      title: "Rent Room",
                      content:
                          "Renta de habitaciones en la ciudad de Pinar del río",
                    ),
                    HorizontalCard(
                      imagen: "assets/cuarto.png",
                      title: "Rent Room",
                      content:
                          "Renta de habitaciones en la ciudad de Pinar del río",
                    ),
                    HorizontalCard(
                      imagen: "assets/cuarto.png",
                      title: "Rent Room",
                      content:
                          "Renta de habitaciones en la ciudad de Pinar del río",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.home, size: 35, color: Colors.white),
              onPressed: () {},
            ),
            const SizedBox(
              width: 180,
            ),
            IconButton(
              icon: const Icon(Icons.logout_outlined,
                  size: 35, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        color: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      extendBody: true,
    );
  }

  Padding _ultimosServiciosTittle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Últimos servicios",
            style: Theme.of(context).textTheme.headline2,
          ),
          const Text('Ver todos', style: TextStyle(color: Colors.blue)),
        ],
      ),
    );
  }

  Text _popularesTittle(BuildContext context) {
    return Text(
      "Populares",
      style: Theme.of(context).textTheme.headline2,
    );
  }

  AppBar _appBar() {
    return AppBar(
      toolbarHeight: 80,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text("Hola",
                    style: TextStyle(
                      color: Colors.black54,
                    )),
                SizedBox(
                  width: 5,
                ),
                Text("Roger",
                    style: TextStyle(
                      color: Colors.blue,
                    )),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Encuentra los servicios cercanos",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    spreadRadius: 1)
              ],
            ),
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.red,
              backgroundImage: AssetImage('assets/barberia.png'),
            ),
          ),
        )
      ],
    );
  }
}

class HorizontalCard extends StatelessWidget {
  const HorizontalCard({
    Key? key,
    required this.imagen,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String imagen, title, content;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(5),
          ),
          child: Image(
            image: AssetImage(imagen),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                Text(content,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w300)),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.laptop,
                        size: 30,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.support_agent,
                        size: 30,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.settings_suggest,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class CardHorizontalSwiper extends StatelessWidget {
  const CardHorizontalSwiper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: [
        GestureDetector(
          child: const VerticalCard(
            imagen: "assets/barberia.png",
            content: 'La única barbería de Cuba con servicio gratis',
            title: 'Barber Shop',
          ),
          onTap: () async {
            var locationBloc = BlocProvider.of<MapBloc>(context);
            await locationBloc.ActualizarUrl();
            Navigator.pushNamed(context, 'fondo');
          },
        ),
        GestureDetector(
          child: const VerticalCard(
            imagen: "assets/coffe.png",
            content: 'La casa del café que está  al doblar la esquina.',
            title: 'Cofee Bar',
          ),
          onTap: () {},
        ),
        GestureDetector(
          child: const VerticalCard(
            imagen: "assets/cake.png",
            content: 'Tenemos dulces, por encargo hasta su casa...',
            title: 'Sweet Dreams',
          ),
          onTap: () {},
        ),
        GestureDetector(
          child: const VerticalCard(
            imagen: "assets/barberia.png",
            content: 'La única barbería de Cuba con servicio gratis',
            title: 'Barber Shop',
          ),
          onTap: () {},
        ),
      ],
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 0),
                color: Color.fromRGBO(0, 0, 0, 0.25))
          ]),
      child: TextFormField(
          //queda poner el cursor un poco mas grande.
          cursorHeight: 28,
          style: const TextStyle(fontSize: 20, color: Colors.black54),
          decoration: const InputDecoration(
            hintText: "Buscar Servicio",
            hintStyle: TextStyle(color: Colors.black54, fontSize: 20),
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(Icons.search, size: 35, color: Colors.black54),
          )),
    );
  }
}
