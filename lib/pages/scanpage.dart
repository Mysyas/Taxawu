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

  void _reset() => setState(() => _capturedImageBytes = null);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final frameW = size.width * 0.82;
    final frameH = size.height * 0.45;

    return Scaffold(
      backgroundColor: AppColors.blanc,
      appBar: AppBar(
        backgroundColor: AppColors.blanc,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _buildCircleButton(
                icon: Icons.chevron_left_rounded,
                size: 28,
                onTap: () => Navigator.pop(context),
              ),
              Expanded(
                child: Text(
                  'Scannez Pour Rechercher',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.fredoka(
                    color: AppColors.vertFonce,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildCircleButton(
                icon: Icons.more_vert_rounded,
                size: 22,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // ── Zone de Scan Centrale ──────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ClipRRect(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Aperçu : image capturée > flux caméra live > état d'erreur/chargement
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: AppColors.gris.withOpacity(0.08),
                      child: _buildPreviewContent(),
                    ),

                    if (_capturedImageBytes == null && _cameraReady) ...[
                      _buildAnimatedScanVFX(frameW, frameH),
                      _buildScanCorners(frameW, frameH),
                    ],

                    if (_capturedImageBytes != null) _buildRetryButton(),
                  ],
                ),
              ),
            ),
          ),

          // ── Barre d'actions inférieure ─────────────────────────────────────
          Container(
            color: AppColors.blanc,
            padding: const EdgeInsets.only(top: 24, bottom: 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bouton Galerie (charger une image existante)
                Column(
                  children: [
                    GestureDetector(
                      onTap: _pickGallery,
                      child: Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.vertClair, AppColors.vertFonce],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.vertFonce.withOpacity(0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.photo_library_rounded,
                          color: AppColors.blanc,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Galerie',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.noir.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                // Bouton Scanner (capture via la caméra live)
                Column(
                  children: [
                    GestureDetector(
                      onTap: _cameraReady ? _takePhoto : null,
                      child: Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: _cameraReady
                                ? [AppColors.vertOlive, AppColors.vertFonce]
                                : [
                                    AppColors.gris.withOpacity(0.4),
                                    AppColors.gris.withOpacity(0.6),
                                  ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.vertFonce.withOpacity(0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            )
                          ],
                        ),
                        child: Icon(
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
                        color: AppColors.noir.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
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
    return Center(
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
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: AppColors.blanc,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.noir.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Icon(icon, color: AppColors.noir.withOpacity(0.8), size: size),
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
                            color: AppColors.blanc.withOpacity(0.8),
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
                            AppColors.vertClair.withOpacity(0.45),
                            AppColors.vertClair.withOpacity(0.2),
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
              top: 0,
              left: 0,
              child: _CornerWidget(corner: _CornerType.topLeft)),
          Positioned(
              top: 0,
              right: 0,
              child: _CornerWidget(corner: _CornerType.topRight)),
          Positioned(
              bottom: 0,
              left: 0,
              child: _CornerWidget(corner: _CornerType.bottomLeft)),
          Positioned(
              bottom: 0,
              right: 0,
              child: _CornerWidget(corner: _CornerType.bottomRight)),
        ],
      ),
    );
  }

  Widget _buildRetryButton() {
    return Positioned(
      top: 20,
      right: 20,
      child: GestureDetector(
        onTap: _reset,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.noir.withOpacity(0.7),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Icon(Icons.refresh_rounded, color: AppColors.blanc, size: 18),
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
