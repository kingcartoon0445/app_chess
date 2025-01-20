import 'package:app_chess/screens/financial_summary/financial_summary_screen.dart';
import 'package:app_chess/screens/login/widget.dart';
import 'package:app_chess/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  Function(String userName, String passwold) onLogin;
  LoginScreen({Key? key, required this.onLogin}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor:  context.theme.primaryColor, // Brown background color
      body: Column(
        children: [
          Container(
            // padding:  EdgeInsets.only(top: 60),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  color: context.theme.primaryColor,
                  height: MediaQuery.of(context).padding.top,
                ),
                Stack(
                  children: [
                    SvgPicture.asset("assets/svg/appbar.svg",
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width),
                    Container(
                      color: context.theme.primaryColor,
                      // height: MediaQuery.of(context).size.height / 6,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top),
                        child: Center(
                          child: Text(
                            "LOGIN",
                            style: context.textTheme.displayLarge,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //  SizedBox(height: 4),
                //  Text(
                //   '94 × 54',
                //   style: TextStyle(
                //     color: Colors.blue,
                //     fontSize: 12,
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  // Username field

                  CustomTextField(
                    pretfixIcon: SvgPicture.asset("assets/svg/user_name.svg"),
                    controller: _usernameController,
                    hintText: 'Username',
                  ),
                  SizedBox(height: 20),
                  // // Password field

                  CustomTextField(
                    pretfixIcon: SvgPicture.asset("assets/svg/pass_word.svg"),
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    hintText: 'Password',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      child: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.brown[300],
                      ),
                    ),
                  )

                  // TextField(
                  //   controller: _passwordController,
                  //   obscureText: _obscurePassword,
                  //   decoration: InputDecoration(
                  //     prefixIcon:
                  //         SvgPicture.asset("assets/svg/pass_word.svg"),
                  //     suffixIcon: IconButton(
                  //       icon: Icon(
                  //         _obscurePassword
                  //             ? Icons.visibility_off
                  //             : Icons.visibility,
                  //         color: Colors.brown[300],
                  //       ),
                  //       onPressed: () {
                  //         setState(() {
                  //           _obscurePassword = !_obscurePassword;
                  //         });
                  //       },
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(30),
                  //       borderSide: BorderSide(color: Colors.brown[300]!),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(30),
                  //       borderSide: BorderSide(color: Colors.brown[400]!),
                  //     ),
                  //   ),
                  // ),
                  ,
                  SizedBox(height: 20),
                  // Remember me switch
                  Row(
                    children: [
                      Switch(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value;
                          });
                        },
                        activeTrackColor: context.theme.primaryColor,
                        activeColor: Colors.white,
                        inactiveThumbColor: context.theme.primaryColor,
                        inactiveTrackColor: Colors.white,
                      ),
                      Text('Ghi nhớ cho lần sau',
                          style: context.textTheme.titleSmall!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.normal)),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Login button
                  Center(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        widget.onLogin(
                            _usernameController.text, _passwordController.text);
                      },
                      child: Container(
                        width: 250,
                        height: 60,
                        decoration: BoxDecoration(
                          color: context.theme.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text('Đăng nhập',
                              style: context.textTheme.titleMedium!
                                  .copyWith(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   // width: MediaQuery.of(context).size.width / 3,
                  //   height: 80,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // Add login logic here
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: context.theme.primaryColor,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //     ),
                  //     child:
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
