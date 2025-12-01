# Detector de Placas

Aplicación Flutter para detectar y reconocer placas de vehículos a partir de imágenes. La aplicación permite al usuario seleccionar una imagen de la galería o tomar una foto, enviarla a un servidor backend para su procesamiento y mostrar los resultados, incluida la información del vehículo y del propietario.

## Pantalla

- Pantalla  (tomar foto o seleccionar galeria, resultados de la detección)

## Características

-   **Selección de Imagen**: Elige una imagen de la galería o toma una foto con la cámara.
-   **Detección de Placas**: Envía la imagen a un servidor para el reconocimiento de la placa.
-   **Visualización de Resultados**:
    -   Muestra el texto de la placa detectada.
    -   Muestra la imagen recortada de la placa.
    -   Muestra información detallada del vehículo (marca, modelo, año).
    -   Muestra información del propietario (nombre, teléfono, correo).
-   **Interfaz de Usuario Limpia**: Diseño moderno y fácil de usar con un tema oscuro.

## Cómo Empezar

Sigue estos pasos para tener una copia del proyecto funcionando en tu máquina local para desarrollo y pruebas.

### Prerrequisitos

-   [Flutter SDK](https://flutter.dev/docs/get-started/install) (versión 3.x o superior)
-   [Dart SDK](https://dart.dev/get-dart)
-   Un emulador de Android/iOS o un dispositivo físico.
-   Un servidor backend en funcionamiento para el reconocimiento de placas.

### Instalación

1.  **Clona el repositorio:**
    ```sh
    git clone https://github.com/CesarIsL/appdereconocimientoplacas
    cd app
    ```

2.  **Instala las dependencias:**
    ```sh
    flutter pub get
    ```

3.  **Configura la API:**
    La dirección del servidor está hardcodeada en el archivo `lib/services/api_service.dart`. Asegúrate de cambiar la IP y el puerto para que apunten a tu servidor backend.

    ```dart
    // lib/services/api_service.dart
    static const String _baseUrl = 'http://TU-DIRECCION-IP:8000/detect_plate';
    ```

4.  **Ejecuta la aplicación:**
    ```sh
    flutter run
    ```

## Construcción para Producción (APK)

Para generar un archivo APK para Android, puedes usar el siguiente comando:

```sh
flutter build apk --release
```

El APK generado se encontrará en el directorio `build/app/outputs/flutter-apk/app-release.apk`.

## Dependencias del Proyecto

-   **flutter**: Framework para construir la interfaz de usuario.
-   **http**: Para realizar peticiones HTTP al servidor backend.
-   **image_picker**: Para seleccionar imágenes de la galería o la cámara.

## Estructura del Proyecto

```
lib/
├── main.dart             # Punto de entrada de la aplicación y UI principal
├── services/
│   └── api_service.dart  # Lógica para comunicarse con el servidor backend
└── widgets/
    └── plate_result.dart # Widget para mostrar los resultados de la detección
```