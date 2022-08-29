import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController = RefreshController();
  List<Usuario> usuarios = [
    Usuario(online: true, email: 'test1@email.com', nombre: 'Maria', uid: '1'),
    Usuario(online: true, email: 'test2@email.com', nombre: 'Juan', uid: '2'),
    Usuario(
        online: false, email: 'test3@email.com', nombre: 'Fernando', uid: '3'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Mi nombre',
            style: TextStyle(color: Colors.black54),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black54,
              )),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle,
                color: Colors.green[700],
              ),
              //     Icon(
              //   Icons.offline_bolt,
              //   color: Colors.red[700],
              // ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          header: WaterDropHeader(
            waterDropColor: Colors.green,
            complete: Icon(
              Icons.check,
              color: Colors.green[700],
              size: 30,
            ),
          ),
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      trailing: Icon(
        Icons.offline_bolt_outlined,
        color: usuario.online ? Colors.green[600] : Colors.red[600],
      ),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
