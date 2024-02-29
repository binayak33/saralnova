import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Auth/login_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login-screen";
  final c = Get.find<LoginController>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(
                  IconPath.logo,
                  fit: BoxFit.contain,
                  height: 100,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 0),
                            color: AppColors.shadowColor,
                            spreadRadius: 1,
                            blurRadius: 8)
                      ]),
                  child: Form(
                    key: c.formKey,
                    child: Column(
                      children: [
                        SkyTextField(
                          hint: "Email",
                          textCapitalization: TextCapitalization.none,
                          validator: (value) => Validator.validateEmail(value!),
                          controller: c.emailController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => SkyTextField(
                            hint: "Password",
                            controller: c.passwordController,
                            validator: (value) =>
                                Validator.validatePassword(value!),
                            obscureText: !c.showPassword.value,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            suffixIcon: c.showPassword.value
                                ? IconButton(
                                    icon: const Icon(Icons.visibility_off,
                                        color: AppColors.borderColor),
                                    onPressed: () => c.showPassword.value =
                                        !c.showPassword.value,
                                  )
                                : IconButton(
                                    icon: const Icon(
                                      Icons.visibility,
                                      color: AppColors.primary,
                                    ),
                                    onPressed: () => c.showPassword.value =
                                        !c.showPassword.value,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkResponse(
                          borderRadius: BorderRadius.circular(10),
                          radius: 10,
                          onTap: c.forgetPassword,
                          child: Text(
                            "Forgot your password?",
                            style: CustomTextStyles.f16W400().copyWith(),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SkyElevatedButton(
                          onPressed: c.onSubmit,
                          // onPressed: () {
                          //   Get.offAllNamed(DashPanel.routeName);
                          // },
                          title: "LOG IN",
                          radius: 8,
                          // width: 100,
                          height: 40,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SkyOutlineButton(
                          onPressed: c.onSubmit,
                          title: "Login with QR",
                          radius: 8,
                          // width: 100,
                          height: 40,
                          prefixIconPath: IconPath.qr,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
