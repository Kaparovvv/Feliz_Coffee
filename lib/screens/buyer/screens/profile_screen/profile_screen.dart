import 'package:feliz_coin/commons/icon_images.dart';
import 'package:feliz_coin/commons/text_style_helper.dart';
import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:feliz_coin/global_widgets/appCover_widget.dart';
import 'package:feliz_coin/screens/auth_screen/sign_up_screen/bloc/sign_up_bloc.dart';
import 'package:feliz_coin/screens/buyer/buyer_navigation_widget.dart/buyer_navigation_widget.dart';
import 'package:feliz_coin/screens/buyer/screens/profile_screen/local_bloc_consumers/logout_consumers.dart';
import 'package:feliz_coin/screens/buyer/screens/profile_screen/local_widget/changeInfoTextField_widget.dart';
import 'package:feliz_coin/screens/buyer/screens/profile_screen/local_widget/exit_dialog_box_widget.dart';
import 'package:feliz_coin/screens/buyer/screens/profile_screen/local_widget/profileChangeButton_widget.dart';
import 'package:feliz_coin/screens/buyer/screens/profile_screen/logout_bloc/bloc/logout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileSceen extends StatefulWidget {
  const ProfileSceen({Key? key}) : super(key: key);

  @override
  State<ProfileSceen> createState() => _ProfileSceenState();
}

class _ProfileSceenState extends State<ProfileSceen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  late SignUpBloc _signUpBloc;
  late LogoutBloc _logoutBloc;
  late bool isLogout;
  Box userData = Hive.box('userDataBox');

  @override
  void initState() {
    isLogout = false;
    _logoutBloc = LogoutBloc();
    _signUpBloc = SignUpBloc();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const AppCoverWidget(
                  nameCover: "Profile",
                  isSeller: false,
                ),
                SizedBox(height: 79.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h, left: 260.w),
                  child: SizedBox(
                    width: 76.w,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ExitDialogBoxWidget(
                              logoutBloc: _logoutBloc,
                              onPressed: () => _logoutBloc.add(
                                PostLogoutEvent(),
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'Выйти',
                            style: TextStyleHelper.f16Green100,
                          ),
                          SizedBox(width: 5.w),
                          Icon(
                            Icons.exit_to_app_outlined,
                            size: 20,
                            color: ThemeHelper.green100,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocConsumer<SignUpBloc, SignUpState>(
                  bloc: _signUpBloc,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is LoadedSignUpState) {
                      return Container(
                        width: 334.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: ThemeHelper.green80,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 32.w,
                            right: 32.w,
                            top: 70.h,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Text(
                                          'Изменить',
                                          style: TextStyleHelper.changeProfile,
                                        ),
                                        SizedBox(width: 12.w),
                                        ImageIcon(
                                          AssetImage(IconsImages.changeIcon),
                                          size: 19,
                                          color: ThemeHelper.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              ChangeInfoTextFieldWidget(
                                width: 217,
                                valueTextField: 'Имя',
                                controller: usernameController,
                                value: state.responseModel.username,
                              ),
                              SizedBox(height: 20.h),
                              ChangeInfoTextFieldWidget(
                                width: 210,
                                valueTextField: 'email',
                                controller: emailController,
                                value: state.responseModel.email,
                              ),
                              SizedBox(height: 20.h),
                              ChangeInfoTextFieldWidget(
                                width: 123,
                                valueTextField: 'Номер телефона',
                                controller: phoneController,
                                value: state.responseModel.phone,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 94.h, bottom: 30.h),
                                child: ProfileChangeButtonWidget(
                                  buttonText: 'Сохранить',
                                  onTapFunction: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Container(
                      width: 334.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: ThemeHelper.green80,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 32.w,
                          right: 32.w,
                          top: 70.h,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Text(
                                        'Изменить',
                                        style: TextStyleHelper.changeProfile,
                                      ),
                                      SizedBox(width: 12.w),
                                      ImageIcon(
                                        AssetImage(IconsImages.changeIcon),
                                        size: 19,
                                        color: ThemeHelper.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            ChangeInfoTextFieldWidget(
                              width: 217,
                              valueTextField: 'Имя',
                              controller: usernameController,
                              value: userData.get('username'),
                            ),
                            SizedBox(height: 20.h),
                            ChangeInfoTextFieldWidget(
                              width: 210,
                              valueTextField: 'email',
                              controller: emailController,
                              value: userData.get('email'),
                            ),
                            SizedBox(height: 20.h),
                            ChangeInfoTextFieldWidget(
                              width: 170,
                              valueTextField: 'Номер тел',
                              controller: phoneController,
                              value: '${userData.get('phone')}',
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 94.h, bottom: 30.h),
                              child: ProfileChangeButtonWidget(
                                buttonText: 'Сохранить',
                                onTapFunction: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          LogoutConsumer(logoutBloc: _logoutBloc),
        ],
      ),
      bottomNavigationBar: const BuyerNavigationWidget(currentPage: 3),
    );
  }
}
