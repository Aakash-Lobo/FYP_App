import 'package:flutter/material.dart';

class ExpenseManagerPage extends StatefulWidget {
  final String username;

  ExpenseManagerPage({required this.username});

  @override
  _ExpenseManagerPageState createState() => _ExpenseManagerPageState();
}

class _ExpenseManagerPageState extends State<ExpenseManagerPage> {
  final List<FAQItem> faqs = [
    FAQItem(
      question: 'What is ERP?',
      answer:
          'ERP stands for Enterprise Resource Planning. It is a software system that integrates various business processes and functions across different departments within an organization.',
    ),
    FAQItem(
      question: 'Why is ERP important for businesses?',
      answer:
          'ERP systems help businesses streamline their operations, improve efficiency, and make data-driven decisions by providing a centralized platform for managing resources, processes, and information.',
    ),
    FAQItem(
      question: 'What are some common modules in ERP systems?',
      answer:
          'Common modules in ERP systems include finance, human resources, inventory management, supply chain management, customer relationship management (CRM), and manufacturing.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQs',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              faqs[index].question,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Text(
                  faqs[index].answer,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}
