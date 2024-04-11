import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Jobs {
  final String companyID;
  final String category;
  final String occupationTitle;
  final String reqNoEmployees;
  final String salaries;
  final String durationEmployment;
  final String qualificationWorkExperience;
  final String jobDescription;
  final String preferredSex;
  final String sectorVacancy;

  Jobs({
    required this.companyID,
    required this.category,
    required this.occupationTitle,
    required this.reqNoEmployees,
    required this.salaries,
    required this.durationEmployment,
    required this.qualificationWorkExperience,
    required this.jobDescription,
    required this.preferredSex,
    required this.sectorVacancy,
  });

  Map<String, dynamic> toMap() {
    return {
      'COMPANYID': companyID,
      'CATEGORY': category,
      'OCCUPATIONTITLE': occupationTitle,
      'REQ_NO_EMPLOYEES': reqNoEmployees,
      'SALARIES': salaries,
      'DURATION_EMPLOYEMENT': durationEmployment,
      'QUALIFICATION_WORKEXPERIENCE': qualificationWorkExperience,
      'JOBDESCRIPTION': jobDescription,
      'PREFEREDSEX': preferredSex,
      'SECTOR_VACANCY': sectorVacancy,
    };
  }

  factory Jobs.fromJson(Map<String, dynamic> json) {
    return Jobs(
      companyID: json['COMPANYID'],
      category: json['CATEGORY'],
      occupationTitle: json['OCCUPATIONTITLE'],
      reqNoEmployees: json['REQ_NO_EMPLOYEES'],
      salaries: json['SALARIES'],
      durationEmployment: json['DURATION_EMPLOYEMENT'],
      qualificationWorkExperience: json['QUALIFICATION_WORKEXPERIENCE'],
      jobDescription: json['JOBDESCRIPTION'],
      preferredSex: json['PREFEREDSEX'],
      sectorVacancy: json['SECTOR_VACANCY'],
    );
  }
}

class AddVacancyPage extends StatefulWidget {
  final String username;

  AddVacancyPage({required this.username});

  @override
  _AddVacancyPageState createState() => _AddVacancyPageState();
}

class _AddVacancyPageState extends State<AddVacancyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _companyIDController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _occupationTitleController = TextEditingController();
  TextEditingController _reqNoEmployeesController = TextEditingController();
  TextEditingController _salariesController = TextEditingController();
  TextEditingController _durationEmploymentController = TextEditingController();
  TextEditingController _qualificationWorkExperienceController =
      TextEditingController();
  TextEditingController _jobDescriptionController = TextEditingController();
  TextEditingController _preferredSexController = TextEditingController();
  TextEditingController _sectorVacancyController = TextEditingController();

  Future<void> addVacancy() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse("http://localhost/fyp/app/modules/placement/addvacancy.php"),
        body: {
          'COMPANYID': _companyIDController.text,
          'CATEGORY': _categoryController.text,
          'OCCUPATIONTITLE': _occupationTitleController.text,
          'REQ_NO_EMPLOYEES': _reqNoEmployeesController.text,
          'SALARIES': _salariesController.text,
          'DURATION_EMPLOYEMENT': _durationEmploymentController.text,
          'QUALIFICATION_WORKEXPERIENCE':
              _qualificationWorkExperienceController.text,
          'JOBDESCRIPTION': _jobDescriptionController.text,
          'PREFEREDSEX': _preferredSexController.text,
          'SECTOR_VACANCY': _sectorVacancyController.text,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        if (result['message'] == 'Vacancy added successfully') {
          print('Vacancy added successfully');
          // Handle successful addition, e.g., navigate to another page
        } else {
          print('Failed to add vacancy');
          // Handle failure, e.g., show an error message
        }
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
        // Handle HTTP request failure, e.g., show an error message
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Vacancy',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ),
        ),
        centerTitle: true,
        elevation: 0, // Remove app bar shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _companyIDController,
                  decoration: InputDecoration(
                    labelText: 'Company ID:*',
                    hintText: 'Add ID',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the company ID';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20), // Add spacing between fields
                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: 'Category:*',
                    hintText: 'Add Category',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the category';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20), // Add spacing between fields
                TextFormField(
                  controller: _occupationTitleController,
                  decoration: InputDecoration(
                    labelText: 'Occupation Title:*',
                    hintText: 'Add Title',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the occupation title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _reqNoEmployeesController,
                  decoration: InputDecoration(
                    labelText: 'Required No. of Employees:*',
                    hintText: 'Add Number',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the required no. of employees';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _salariesController,
                  decoration: InputDecoration(
                    labelText: 'Salaries:*',
                    hintText: 'Add Salary',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the salaries';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _durationEmploymentController,
                  decoration: InputDecoration(
                    labelText: 'Duration of Employment:*',
                    hintText: 'Add Duration',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the duration of employment';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _qualificationWorkExperienceController,
                  decoration: InputDecoration(
                    labelText: 'Qualification/Work Experience:*',
                    hintText: 'Add Qualification',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the qualification/work experience';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _jobDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Job Description:*',
                    hintText: 'Add Description',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the job description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _preferredSexController,
                  decoration: InputDecoration(
                    labelText: 'Preferred Sex:*',
                    hintText: 'Add Sex',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the preferred sex';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _sectorVacancyController,
                  decoration: InputDecoration(
                    labelText: 'Sector Vacancy:*',
                    hintText: 'Add Sector',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the sector vacancy';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity, // Set button width to match parent
                  height: 50, // Set button height
                  child: ElevatedButton(
                    onPressed: addVacancy,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                          color: Colors.white), // Apply Raleway font
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.blue, // Set button background color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
