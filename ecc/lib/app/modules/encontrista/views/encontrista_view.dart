import 'package:flutter/material.dart';
import 'package:form_page_view/enum/progress_enum.dart';
import 'package:form_page_view/models/form_page_model.dart';
import 'package:form_page_view/form_page_view.dart';
import 'package:form_page_view/models/form_page_style.dart';

import 'package:get/get.dart';

import '../controllers/encontrista_controller.dart';

class EncontristaView extends GetView<EncontristaController> {
  const EncontristaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EncontristaView'),
        centerTitle: true,
      ),
      body: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Forms keys
    final GlobalKey<FormState> formKeyPage1 = GlobalKey<FormState>();
    final GlobalKey<FormState> formKeyPage2 = GlobalKey<FormState>();
    final GlobalKey<FormState> formKeyPage3 = GlobalKey<FormState>();

    // Controllers
    final emailController = TextEditingController();
    final usernameController = TextEditingController();
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();

    // Create a list of FormPageModel objects representing the form pages
    final pages = [
      FormPageModel(
        formKey: formKeyPage1,
        title: 'Dados do casal',
        textButton: 'Next',
        body: Form(
          key: formKeyPage1,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
      FormPageModel(
        formKey: formKeyPage1,
        title: 'Como falamos com vocês',
        textButton: 'Next',
        body: Form(
          key: formKeyPage1,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
      FormPageModel(
        formKey: formKeyPage2,
        title: 'Seu casamento',
        textButton: 'Next',
        body: Form(
          key: formKeyPage2,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      FormPageModel(
        formKey: formKeyPage3,
        title: 'Filhos',
        textButton: 'Next',
        body: Form(
          key: formKeyPage3,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      FormPageModel(
        formKey: formKeyPage3,
        title: 'E.C.C.',
        textButton: 'Next',
        body: Form(
          key: formKeyPage3,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      FormPageModel(
        formKey: formKeyPage3,
        title: 'Filhos',
        textButton: 'Next',
        body: Form(
          key: formKeyPage3,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      FormPageModel(
        formKey: formKeyPage3,
        title: 'Seu endereço',
        textButton: 'Next',
        body: Form(
          key: formKeyPage3,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    ];

    const style = FormPageStyle(
      backgroundColor: Colors.white,
      buttonHeight: 60,
    );

    return FormPageView(
      controller: PageController(),
      progress: ProgressIndicatorType.circular,
      pages: pages,
      style: style,
      onFormSubmitted: () {
        // print all the values
        print('Username: ${usernameController.text}');
        print('First Name: ${firstNameController.text}');
        print('Last Name: ${lastNameController.text}');
        print('Email: ${emailController.text}');
      },
    );
  }
}
