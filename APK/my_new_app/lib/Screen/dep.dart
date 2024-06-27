import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DepEditar extends StatefulWidget {
  const DepEditar({super.key});

  @override
  _DepEditarState createState() => _DepEditarState();
}

class _DepEditarState extends State<DepEditar> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _nomdepController = TextEditingController();
  final TextEditingController _pais = TextEditingController();
  bool _loading = false;
  bool _isSearchFieldReadOnly = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _isSearchFieldReadOnly = false; // Inicialmente el campo es editable

    _nomdepController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the TextEditingController
    _nomdepController.dispose();
    _pais.dispose();
    super.dispose();
  }

  void _search() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
      _isSearchFieldReadOnly = true;
    });

    final id = _controller.text;
    final url = Uri.parse('http://10.0.2.2:4000/app/dep/$id');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (mounted) {
          setState(() {
            _nomdepController.text = data[0]['nomdepto'];
            _pais.text = data[0]['pais'];
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = 'Error: ${response.statusCode}';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  void update() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
      _isSearchFieldReadOnly = true;
    });

    final id = _controller.text;
    final url = Uri.parse('http://10.0.2.2:4000/app/dep/$id');
    final nomdep = _nomdepController.text;

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nomdepto': nomdep, // Usar un valor vacío si _nomdep es nulo
        }),
      );

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            _errorMessage = 'Actualización exitosa';
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = 'Error: ${response.statusCode}';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
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
                labelText: 'Buscar un Departamento',
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
              controller: _nomdepController,
              decoration: const InputDecoration(
                labelText: 'Nombre del Departamento',
              ),
            ),
            TextField(
              controller: _pais,
              decoration: const InputDecoration(
                labelText: 'Nombre del Pais',
              ),
              readOnly: true,
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

class DepCrear extends StatefulWidget {
  const DepCrear({super.key});

  @override
  DepCrearScreen createState() => DepCrearScreen();
}

class DepCrearScreen extends State<DepCrear> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _pais = TextEditingController();
  bool _loading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void create() async {
    final dep = _controller.text;
    final pais = _pais.text;
    final url = Uri.parse('http://10.0.2.2:4000/app/dep');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'nomdepto': dep, 'pais': pais}),
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
                labelText: 'Nombre Departamento',
              ),
            ),
            TextField(
              controller: _pais,
              decoration: const InputDecoration(
                labelText: 'Codigo Pais',
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
