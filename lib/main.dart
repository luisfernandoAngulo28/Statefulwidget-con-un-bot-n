import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Primera App Flutter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          bodyLarge: TextStyle(fontSize: 16, height: 1.4),
          labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLarge = false;
  int changeCount = 0;

  void changeBoxState() {
    setState(() {
      isLarge = !isLarge;
      changeCount++;
    });
  }

  void resetState() {
    setState(() {
      isLarge = false;
      changeCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final boxColor = isLarge ? Colors.indigo : Colors.amber;
    final labelText = isLarge ? 'Estado actual: Expandido' : 'Estado actual: Compacto';
    final labelColor = isLarge ? Colors.white : Colors.black87;
    final buttonLabel = isLarge ? 'Reducir contenedor' : 'Expandir contenedor';
    final buttonIcon = isLarge ? Icons.zoom_out : Icons.zoom_in;
    final canReset = isLarge || changeCount > 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7EAF8),
        title: const Text('Contenedor Dinamico'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 380;
          final baseSize = isSmallScreen ? 110.0 : 140.0;
          final expandedSize = isSmallScreen ? 180.0 : 230.0;
          final boxSize = isLarge ? expandedSize : baseSize;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Cambia el contenedor usando setState()',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Toca el botón principal para modificar tamaño, color y estado visual.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Cambios realizados: $changeCount',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 18),
                        Container(
                          width: boxSize,
                          height: boxSize,
                          decoration: BoxDecoration(
                            color: boxColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x22000000),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              labelText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: labelColor,
                                fontSize: isSmallScreen ? 16 : 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: changeBoxState,
                          icon: Icon(buttonIcon),
                          label: Text(buttonLabel),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(220, 48),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          ),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: canReset ? resetState : null,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reiniciar'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(220, 48),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
