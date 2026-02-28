import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String email = "";
  String message = "";
  String projectType = "Website Development";

  bool submitted = false;
  bool isSubmitting = false;
  String? errorMessage;

  Future<void> handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isSubmitting = true;
        errorMessage = null;
      });

      try {
        // Using FormSubmit service to send email
        // Note: FormSubmit.co requires form-urlencoded format, not JSON
        final response = await http
            .post(
              Uri.parse('https://formsubmit.co/kemsyz.labs@gmail.com'),
              headers: {'Content-Type': 'application/x-www-form-urlencoded'},
              body: {
                'name': name,
                'email': email,
                'project_type': projectType,
                'message': message,
                '_subject': 'New Project Inquiry from $name',
                '_captcha': 'false',
                '_template': 'table',
                '_next': 'https://kemsyzlabs.com/thank-you',
              },
            )
            .timeout(
              const Duration(seconds: 15),
              onTimeout: () {
                throw TimeoutException('Connection timeout');
              },
            );

        if (response.statusCode == 200 || response.statusCode == 302) {
          setState(() {
            submitted = true;
            isSubmitting = false;
            // Clear form
            _formKey.currentState!.reset();
          });

          // Reset success message after 5 seconds
          Future.delayed(const Duration(seconds: 5), () {
            if (mounted) setState(() => submitted = false);
          });
        } else {
          throw Exception('Failed to send email');
        }
      } on SocketException catch (e) {
        // Handle offline/no internet connection
        setState(() {
          isSubmitting = false;
          errorMessage =
              '⚠️ No internet connection. Please check your network and try again.';
        });
        print('SocketException: $e');

        // Clear error message after 8 seconds
        Future.delayed(const Duration(seconds: 8), () {
          if (mounted) setState(() => errorMessage = null);
        });
      } on TimeoutException catch (e) {
        // Handle timeout
        setState(() {
          isSubmitting = false;
          errorMessage =
              'Connection timeout. Please check your internet connection and try again.';
        });
        print('TimeoutException: $e');

        // Clear error message after 8 seconds
        Future.delayed(const Duration(seconds: 8), () {
          if (mounted) setState(() => errorMessage = null);
        });
      } on http.ClientException catch (e) {
        // Handle HTTP client exceptions (network issues)
        setState(() {
          isSubmitting = false;
          errorMessage =
              '⚠️ Network error. Please check your connection and try again.';
        });
        print('ClientException: $e');

        // Clear error message after 8 seconds
        Future.delayed(const Duration(seconds: 8), () {
          if (mounted) setState(() => errorMessage = null);
        });
      } catch (e) {
        // Handle other errors
        setState(() {
          isSubmitting = false;
          errorMessage =
              'Failed to send message. Please try again or contact directly at kemsyz.labs@gmail.com';
        });
        print('Error sending message: $e');

        // Clear error message after 8 seconds
        Future.delayed(const Duration(seconds: 8), () {
          if (mounted) setState(() => errorMessage = null);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final isMobile = MediaQuery.of(context).size.width < 600;
    final verticalPadding = isMobile ? 60.0 : 96.0;
    final horizontalPadding = isMobile ? 16.0 : 24.0;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      color: AppColors.navy,
      child: Stack(
        children: [
          // Decorative Background Grid
          // Positioned.fill(
          //   child: Opacity(
          //     opacity: 0.1,
          //     child: CustomPaint(painter: _GridPainter()),
          //   ),
          // ),

          // Content
          Column(
            children: [
              const _Header(),
              const SizedBox(height: 64),
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _buildForm()),
                        const SizedBox(width: 32),
                        const Expanded(child: _ContactInfo()),
                      ],
                    )
                  : Column(
                      children: [
                        _buildForm(),
                        const SizedBox(height: 32),
                        const _ContactInfo(),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final formPadding = isMobile ? 20.0 : 32.0;

    return Container(
      padding: EdgeInsets.all(formPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.charcoal.withValues(alpha: 0.7),
            AppColors.charcoal.withValues(alpha: 0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cyberBlue.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyberBlue.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form Title
            Text(
              "Project Inquiry Form",
              style: AppText.h3.copyWith(
                color: AppColors.cyberBlue,
                fontSize: isMobile ? 18 : 20,
              ),
            ),
            const SizedBox(height: 24),

            // Name & Email Fields - Responsive
            isMobile
                ? Column(
                    children: [
                      _input("Full Name *", (v) => name = v!, "Your name"),
                      const SizedBox(height: 16),
                      _input(
                        "Email Address *",
                        (v) => email = v!,
                        "yourEmail@email.com",
                        isEmail: true,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: _input(
                          "Full Name *",
                          (v) => name = v!,
                          "Your name",
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _input(
                          "Email Address *",
                          (v) => email = v!,
                          "yourEmail@email.com",
                          isEmail: true,
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 20),

            // Project Type Dropdown
            _dropdown(),
            const SizedBox(height: 20),

            // Message Textarea
            _textarea(),
            const SizedBox(height: 28),

            // Submit Button
            _submitButton(),

            // Success Message
            if (submitted) ...[const SizedBox(height: 20), const _SuccessBox()],

            // Error Message
            if (errorMessage != null) ...[
              const SizedBox(height: 20),
              _ErrorBox(message: errorMessage!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _input(
    String label,
    FormFieldSetter<String> onSaved,
    String placeholder, {
    bool isEmail = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFCBD5E1),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: isEmail
              ? TextInputType.emailAddress
              : TextInputType.text,
          style: const TextStyle(color: Colors.white),
          cursorColor: AppColors.cyberBlue,
          decoration: _fieldDecoration(placeholder),
          validator: (v) {
            if (v == null || v.isEmpty) return "This field is required";
            if (isEmail && !v.contains('@')) return "Enter a valid email";
            return null;
          },
          onSaved: onSaved,
        ),
      ],
    );
  }

  Widget _textarea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Project Details / Requirements *",
          style: TextStyle(
            color: Color(0xFFCBD5E1),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: 5,
          style: const TextStyle(color: Colors.white),
          cursorColor: AppColors.cyberBlue,
          decoration: _fieldDecoration(
            "Describe your project, goals, and requirements...",
          ),
          validator: (v) =>
              (v == null || v.isEmpty) ? "Please describe your project" : null,
          onSaved: (v) => message = v!,
        ),
      ],
    );
  }

  Widget _dropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Project Type",
          style: TextStyle(
            color: Color(0xFFCBD5E1),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: projectType,
          dropdownColor: AppColors.navy,
          style: const TextStyle(color: Colors.white),
          decoration: _fieldDecoration("Select project type"),
          items: [
            "Website Development",
            "Mobile App (iOS/Android)",
            "Web Application",
            "E-commerce Platform",
            // "UI/UX Design",
            // "Consulting",
            "Other",
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => setState(() => projectType = v!),
        ),
      ],
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: AppColors.textSecondary.withValues(alpha: 0.5),
      ),
      filled: true,
      fillColor: AppColors.navy.withValues(alpha: 0.6),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.cyberBlue.withValues(alpha: 0.3),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.cyberBlue.withValues(alpha: 0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.cyberBlue, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(
              backgroundColor: submitted ? Colors.green : AppColors.cyberBlue,
              foregroundColor: AppColors.navy,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ).copyWith(
              overlayColor: WidgetStateProperty.all(
                AppColors.neonBlue.withValues(alpha: 0.1),
              ),
            ),
        onPressed: (submitted || isSubmitting) ? null : handleSubmit,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSubmitting) ...[
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.navy),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Text(
              isSubmitting
                  ? "Sending..."
                  : submitted
                  ? "Request Submitted!"
                  : "Submit Project Request",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
            if (!submitted && !isSubmitting) ...[
              const SizedBox(width: 8),
              const Icon(Icons.send, size: 18),
            ],
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.charcoal.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: AppColors.cyberBlue.withValues(alpha: 0.4),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.cyberBlue.withValues(alpha: 0.15),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: const Text(
            "GET IN TOUCH",
            style: TextStyle(
              color: AppColors.cyberBlue,
              letterSpacing: 2,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 28),

        // Main Title
        Text(
          "Let's Build Something Amazing",
          style: AppText.h2.copyWith(fontSize: 42, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        // Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: Text(
            "Share your vision and I'll respond within 24 hours with a clear roadmap and next steps to bring your project to life.",
            style: AppText.body.copyWith(fontSize: 17),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _SuccessBox extends StatelessWidget {
  const _SuccessBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "Your request has been received. I'll get back to you shortly!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  final String message;

  const _ErrorBox({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.red.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.error_outline, color: Colors.red, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final cardPadding = isMobile ? 20.0 : 28.0;
    final titleFontSize = isMobile ? 18.0 : 20.0;

    return Column(
      children: [
        // Contact Details Card
        Container(
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.charcoal.withValues(alpha: 0.7),
                AppColors.charcoal.withValues(alpha: 0.4),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.cyberBlue.withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.cyberBlue.withValues(alpha: 0.1),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact Information",
                style: AppText.h3.copyWith(
                  fontSize: titleFontSize,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              const _InfoTile(
                Icons.email_outlined,
                "Email",
                "kemsyz.labs@gmail.com",
              ),
              const SizedBox(height: 16),
              const _InfoTile(Icons.phone_outlined, "Phone", "+92 317 5151056"),
              const SizedBox(height: 16),
              const _InfoTile(
                Icons.location_on_outlined,
                "Location",
                "Remote / Pakistan",
              ),
              const SizedBox(height: 16),
              const _InfoTile(
                Icons.access_time_outlined,
                "Availability",
                "Mon-Fri, 9am-6pm PKT",
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Response Time Notice
        Container(
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.charcoal.withValues(alpha: 0.7),
                AppColors.charcoal.withValues(alpha: 0.4),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.amber.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.amber,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Quick Response",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "I typically respond within 24 hours. For urgent inquiries, feel free to call directly.",
                      style: TextStyle(
                        color: AppColors.textSecondary.withValues(alpha: 0.9),
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile(this.icon, this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon Box
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.cyberBlue.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.cyberBlue.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Icon(icon, color: AppColors.cyberBlue, size: 22),
        ),
        const SizedBox(width: 14),

        // Text Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.textSecondary.withValues(alpha: 0.8),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Grid Painter for Background
// class _GridPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = AppColors.cyberBlue
//       ..strokeWidth = 0.5
//       ..style = PaintingStyle.stroke;

//     const gridSize = 60.0;

//     // Draw vertical lines
//     for (double x = 0; x < size.width; x += gridSize) {
//       canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
//     }

//     // Draw horizontal lines
//     for (double y = 0; y < size.height; y += gridSize) {
//       canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
