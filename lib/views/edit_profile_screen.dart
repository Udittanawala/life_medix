import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_medix_demo/controller/editprofile_controller.dart';
import 'package:life_medix_demo/generated/pref_manager.dart';
import 'package:life_medix_demo/model/user_model.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  PrefManager manager = PrefManager();
  final EditProfileController _controller = Get.put(EditProfileController());

  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _contactController;
  late TextEditingController _locationController;

  File? _image;
  String? _imagePath; // Store image path

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: manager.getUserName());
    _emailController = TextEditingController(text: manager.getUserEmail());
    //_passwordController = TextEditingController(text: manager.get);
    _contactController = TextEditingController(text: manager.getUserContact());
    // _locationController = TextEditingController(text: widget.user.userAddress);
    // _imagePath = widget.user.userImg; // Load existing profile image
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _contactController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imagePath = pickedFile.path;
      });
    }
  }

  void _saveChanges() async {
    // if (_formKey.currentState!.validate()) {
    //   _controller
    //       .editProfileUser(
    //     userId: widget.user.userId,
    //     userImg: _imagePath ?? "", // Send image path or empty string
    //     userName: _usernameController.text.trim(),
    //     userEmail: _emailController.text.trim(),
    //     userPass: _passwordController.text.trim(),
    //   )
    //       .then((_) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Profile Updated Successfully')),
    //     );
    //     Navigator.pop(context); // Navigate back to Account Page
    //   }).catchError((error) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Failed to Update Profile')),
    //     );
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade100,
        title: Text("Edit Profile", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 20),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : (_imagePath != null && _imagePath!.isNotEmpty
                              ? NetworkImage(_imagePath!) as ImageProvider
                              : AssetImage(
                                  'assets/default_avatar.png')), // Default image
                      child: _image == null &&
                              (_imagePath == null || _imagePath!.isEmpty)
                          ? Icon(Icons.person, size: 60, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          backgroundColor: Colors.cyan.shade700,
                          radius: 18,
                          child: Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              _buildRoundedTextField(
                  _usernameController, "Username", Icons.person),
              _buildRoundedTextField(_emailController, "Email", Icons.email),
              _buildRoundedTextField(
                  _passwordController, "Password", Icons.lock,
                  obscureText: true),
              _buildRoundedTextField(
                  _contactController, "Contact Number", Icons.phone),
              _buildRoundedTextField(
                  _locationController, "Location", Icons.location_on),
              SizedBox(height: 30),
              Obx(() => ElevatedButton(
                    onPressed: _controller.isLoaded.value ? null : _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan.shade700,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: _controller.isLoaded.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Save Changes',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "$label cannot be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.cyan.shade700),
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}
