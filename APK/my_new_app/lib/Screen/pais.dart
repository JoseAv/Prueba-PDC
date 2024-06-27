import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaisEditar extends StatefulWidget {
  const PaisEditar({super.key});

  @override
  _PaisEditarState createState() => _PaisEditarState();
}

class _PaisEditarState extends State<PaisEditar> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _nomPaisController = TextEditingController();
  bool _loading = false;
  bool _isSearchFieldReadOnly = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _isSearchFieldReadOnly = false; // Inicialmente el campo es editable
  }

  @override
  void dispose() {
    _controller
        .clear(); // Vaciar el contenido del TextField al salir de la pantalla
    _nomPaisController.clear();
    super.dispose();
  }

  void _search() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
      _isSearchFieldReadOnly =
          true; // Hacer el campo de solo lectura después de la búsqueda
    });

    final id = _controller.text;
    final url = Uri.parse('http://10.0.2.2:4000/app/pais/$id');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _nomPaisController.text = data[0]['nompais'];
        });
      } else {
        setState(() {
          _errorMessage = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void update() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
      _isSearchFieldReadOnly = true;
    });

    final id = _controller.text;
    final nompais = _nomPaisController.text; // Obtener el texto del controlador
    final url = Uri.parse('http://10.0.2.2:4000/app/pais/$id');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nompais': nompais,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _errorMessage = 'Actualización exitosa';
        });
      } else {
        setState(() {
          _errorMessage = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pais'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Buscar un pais',
              ),
              readOnly:
                  _isSearchFieldReadOnly, // Desactivar edición después de la búsqueda
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _search,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            TextField(
              controller: _nomPaisController,
              decoration: const InputDecoration(
                labelText: 'Nombre del Pais',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : update,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Editar'),
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

class PaisCrear extends StatefulWidget {
  const PaisCrear({super.key});

  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<PaisCrear> {
  final TextEditingController _controller = TextEditingController();
  bool _loading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void create() async {
    final nompais = _controller.text;
    final url = Uri.parse('http://10.0.2.2:4000/app/pais');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nompais': nompais,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _errorMessage = 'Creacion Exitosa';
          Navigator.pop(context);
        });
      } else {
        setState(() {
          _errorMessage = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Nombre Pais',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : create,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Crear'),
            ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
