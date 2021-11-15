import 'package:flutter/material.dart';

class DeleteCommentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Eliminación de comentario'),
          content:
              const Text('¿Está seguro que quiere eliminar esta publicación?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancelar'),
              child: const Text('Cancelar'),
            ),
            TextButton(
              //añadir Alerta de post eliminado
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: Text("Eliminar")
      /*
      icon: Icon(
        Icons.remove_circle_outline_rounded,
        color: Colors.grey[350],
      )*/
      ,
    );
  }
}
