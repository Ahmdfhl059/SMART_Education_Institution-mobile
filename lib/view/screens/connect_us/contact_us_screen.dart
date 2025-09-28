import 'package:SMART/data/api/contact_api.dart';
import 'package:SMART/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 65,
        backgroundColor: defaultColor,
        iconTheme: IconThemeData(color: Colors.white,size: 30),
        title: DefaultText(
          text: 'Contact With us',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actionsPadding: EdgeInsets.only(right: 10),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultListTile(
              onTap: (){
                openUrl("https://wa.me/$phone");
              },
              textTitle: 'Whatsapp',
              isSubTitle: false,
            ),
            SizedBox(height: 10),
            DefaultListTile(
              onTap: (){
                openUrl(facebook);
              },
              textTitle: 'Facebook',
              isSubTitle: false,
            ),
            SizedBox(height: 10),
            DefaultListTile(
              onTap: (){
                openUrl(instagram);
              },
              textTitle: 'Instagram',
              isSubTitle: false,
            ),
          ],
        ),
      ),
    );
  }
}
