//import 'dart:html';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:taxawu/theme/app_colors.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage>
    with SingleTickerProviderStateMixin {
  Uint8List? _capturedImageBytes;
  final ImagePicker _picker = ImagePicker();

  CameraController? _cameraController;
  bool _cameraReady = false;
  bool _cameraError = false;
  bool flash_on = false;

  late AnimationController _animController;
  late Animation<double> _scanAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _scanAnim = Tween<double>(begin: -0.2, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        if (mounted) setState(() => _cameraError = true);
        return;
      }
      final camera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      _cameraController = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _cameraController!.initialize();
      if (mounted) setState(() => _cameraReady = true);
    } catch (e) {
      // Permission refusée, pas de caméra disponible, etc.
      if (mounted) setState(() => _cameraError = true);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _takePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    try {
      final XFile photo = await _cameraController!.takePicture();
      final bytes = await photo.readAsBytes();
      setState(() => _capturedImageBytes = bytes);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la capture : $e')),
      );
    }
  }

  Future<void> _pickGallery() async {
    final XFile? img =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
    if (img != null) {
      final bytes = await img.readAsBytes();
      setState(() => _capturedImageBytes = bytes);
    }
  }

  Future<void> toggleFlash() async {
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized ||
        !_cameraReady) {
      return;
    }

    try {
      final newFlashState = !flash_on;

      await _cameraController!.setFlashMode(
        newFlashState ? FlashMode.torch : FlashMode.off,
      );

      if (!mounted) return;

      setState(() {
        flash_on = newFlashState;
      });
    } on CameraException catch (e) {
      debugPrint('Erreur flash : ${e.description}');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Impossible d'activer le flash sur cet appareil."),
        ),
      );
    }
  }

  void _reset() => setState(() {
        _capturedImageBytes = null;
        _initCamera();
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final frameW = constraints.maxWidth;
                final frameH = constraints.maxHeight;

                return Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    // Aperçu caméra ou photo capturée
                    Positioned.fill(
                      child: Container(
                        color: AppColors.gris.withValues(alpha: 0.08),
                        child: _buildPreviewContent(),
                      ),
                    ),

                    // Animation de scan
                    if (_capturedImageBytes == null && _cameraReady) ...[
                      _buildAnimatedScanVFX(frameW, frameH),
                      _buildScanCorners(frameW, frameH),
                    ],

                    // Bouton réessayer
                    if (_capturedImageBytes != null) _buildRetryButton(),
                  ],
                );
              },
            ),
          ),

          // 2. EN-TÊTE : RETOUR, TITRE ET FLASH
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    _buildCircleButton(
                      icon: Icons.chevron_left_rounded,
                      size: 20,
                      onTap: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        'Scannez Pour Rechercher',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.blanc,
                            ),
                      ),
                    ),
                    _buildCircleButton(
                      icon: Icons.flash_on,
                      size: 20,
                      onTap: toggleFlash,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 24,
                  bottom: 15,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0),
                      Colors.black.withValues(alpha: 0.65),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Galerie
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: _pickGallery,
                          child: Container(
                            width: 68,
                            height: 68,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.blanc),
                            child: const Icon(
                              Icons.photo_library_rounded,
                              color: AppColors.blanc,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Scanner',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blanc,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 68,
                            height: 68,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.vertClair,
                                  AppColors.vertFonce,
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.scanner,
                              color: AppColors.blanc,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(width: 40),

                    // Scanner
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: _cameraReady ? _takePhoto : null,
                          child: Container(
                            width: 68,
                            height: 68,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: _cameraReady
                                    ? [
                                        AppColors.vertOlive,
                                        AppColors.vertFonce,
                                      ]
                                    : [
                                        AppColors.gris.withValues(alpha: 0.4),
                                        AppColors.gris.withValues(alpha: 0.6),
                                      ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.vertFonce
                                      .withValues(alpha: 0.25),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: AppColors.blanc,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Scanner',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blanc,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewContent() {
    if (_capturedImageBytes != null) {
      return Image.memory(_capturedImageBytes!, fit: BoxFit.cover);
    }
    if (_cameraError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Caméra indisponible.\nVérifiez les permissions du navigateur/de l'appareil.",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(color: AppColors.gris, fontSize: 14),
          ),
        ),
      );
    }
    if (_cameraReady && _cameraController != null) {
      return ClipRect(
        child: OverflowBox(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _cameraController!.value.previewSize?.height ?? 1,
              height: _cameraController!.value.previewSize?.width ?? 1,
              child: CameraPreview(_cameraController!),
            ),
          ),
        ),
      );
    }
    return const Center(
      child: CircularProgressIndicator(color: AppColors.vertOlive),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required double size,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          border: Border.all(
              color: AppColors.blanc.withValues(alpha: 0.15), width: 1),
        ),
        child: Icon(icon, color: AppColors.blanc, size: size),
      ),
    );
  }

  Widget _buildAnimatedScanVFX(double width, double height) {
    return AnimatedBuilder(
      animation: _scanAnim,
      builder: (context, child) {
        final double currentTop = (height * _scanAnim.value);

        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Positioned(
                top: currentTop,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 5,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blanc.withValues(alpha: 0.8),
                            blurRadius: 4,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 90,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.vertClair.withValues(alpha: 0.45),
                            AppColors.vertClair.withValues(alpha: 0.2),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScanCorners(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: const Stack(
        children: [
          Positioned(
              top: 10,
              left: 10,
              child: _CornerWidget(corner: _CornerType.topLeft)),
          Positioned(
              top: 10,
              right: 10,
              child: _CornerWidget(corner: _CornerType.topRight)),
          Positioned(
              bottom: 10,
              left: 10,
              child: _CornerWidget(corner: _CornerType.bottomLeft)),
          Positioned(
              bottom: 10,
              right: 10,
              child: _CornerWidget(corner: _CornerType.bottomRight)),
        ],
      ),
    );
  }

  Widget _buildRetryButton() {
    return Positioned(
      top: 80,
      right: 20,
      child: GestureDetector(
        onTap: _reset,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.noir.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              const Icon(Icons.refresh_rounded,
                  color: AppColors.blanc, size: 18),
              const SizedBox(width: 8),
              Text('Réessayer',
                  style: GoogleFonts.montserrat(
                      color: AppColors.blanc,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Gestion des angles du cadre de scan (Custom Paint) ──────────────────────
enum _CornerType { topLeft, topRight, bottomLeft, bottomRight }

class _CornerWidget extends StatelessWidget {
  final _CornerType corner;
  const _CornerWidget({required this.corner});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(60, 60),
      painter: _CornerPainter(corner: corner),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final _CornerType corner;
  _CornerPainter({required this.corner});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.vertClair
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const radius = 24.0;
    const armLen = 42.0;
    final w = size.width;
    final h = size.height;
    final path = Path();

    switch (corner) {
      case _CornerType.topLeft:
        path.moveTo(0, armLen);
        path.lineTo(0, radius);
        path.arcToPoint(const Offset(radius, 0),
            radius: const Radius.circular(radius), clockwise: true);
        path.lineTo(armLen, 0);
        break;
      case _CornerType.topRight:
        path.moveTo(w - armLen, 0);
        path.lineTo(w - radius, 0);
        path.arcToPoint(Offset(w, radius),
            radius: const Radius.circular(radius), clockwise: true);
        path.lineTo(w, armLen);
        break;
      case _CornerType.bottomLeft:
        path.moveTo(0, h - armLen);
        path.lineTo(0, h - radius);
        path.arcToPoint(Offset(radius, h),
            radius: const Radius.circular(radius), clockwise: false);
        path.lineTo(armLen, h);
        break;
      case _CornerType.bottomRight:
        path.moveTo(w - armLen, h);
        path.lineTo(w - radius, h);
        path.arcToPoint(Offset(w, h - radius),
            radius: const Radius.circular(radius), clockwise: false);
        path.lineTo(w, h - armLen);
        break;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CornerPainter old) => false;
}
