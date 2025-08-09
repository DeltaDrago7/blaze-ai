import 'package:blazemobile/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../functions/dimensions.dart';


class EducationModuleProgress extends StatefulWidget {
  const EducationModuleProgress({super.key});

  @override
  State<EducationModuleProgress> createState() => _EducationModuleProgressState();
}

class _EducationModuleProgressState extends State<EducationModuleProgress> {

  int moduleSelected = -1;

  @override
  void initState() {
    super.initState();
    educationalChatbot = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              child: Container(
                width: screenWidth(context),
                constraints: BoxConstraints(
                  minHeight: screenHeight(context), // Set your minimum height here
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blueAccent.shade700, Colors.indigo.shade900,], // Define your gradient colors
                    stops: [0.1, 8.0], // 70% blue, 30% purple
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 15,right: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,),
                          ),
                          Image.asset("assets/images/Blaze Colored Combo Cropped.PNG",width: 40,height: 40,color: Colors.white,),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text("Investing 101", style: GoogleFonts.montserrat(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 20,),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: educationalContent['content-amount'],
                          itemBuilder: (context, index){
                            return UserModel.userData['modules']['completed-modules'].contains(index)?
                            completedModule(index):
                            UserModel.userData['modules']['modules-in-progress'].contains(index)?
                            moduleInProgress(index)
                            :index <= UserModel.userData['modules']['current-module']?
                            currentModule(index):lockedModule(index);
                          }
                      ),
                      SizedBox(height: 100,),
                    ],
                  ),
                ),
              ),
            ),
            startModuleButton(),
          ],
        ),
      ),
    );
  }
  
  Widget completedModule(int index){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: moduleSelected == index?Colors.white:Colors.grey.withOpacity(0.2), width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(top: 10,bottom: 10),
      child: TextButton(
          onPressed: (){
            setState(() {
              moduleSelected = index;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Completed", style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.w600,
                  ),),
                  SizedBox(width:10,),
                  Container(
                    child: Icon(Icons.check_circle,color: Colors.greenAccent,size: 40,),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                    child: Image.asset("assets/images/${educationalContent[index]['module-image']}.png",)),
              ),
              SizedBox(height:10,),
              Container(
                width: 200,
                child: Text("${educationalContent[index]['module-title']}", style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),textAlign: TextAlign.center,),
              ),
            ],
          )
      ),
    );
  }
  
  Widget moduleInProgress(int index){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: moduleSelected == index?Colors.white:Colors.grey.withOpacity(0.2), width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(top: 10,bottom: 10),
      child: TextButton(
          onPressed: (){
            setState(() {
              moduleSelected = index;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Continue", style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.orangeAccent.shade100,
                    fontWeight: FontWeight.w600,
                  ),),
                  SizedBox(width:20,),
                  Container(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      value: UserModel.userData['modules']['modules-progress']['$index']['progress'] / educationalContent[index]['module-length'],
                      strokeWidth: 4,
                      backgroundColor: Colors.blueAccent.shade700,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent.shade100),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                    child: Image.asset("assets/images/${educationalContent[index]['module-image']}.png",)),
              ),
              SizedBox(height:10,),
              Container(
                width: 200,
                child: Text("${educationalContent[index]['module-title']}", style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),textAlign: TextAlign.center,),
              ),
            ],
          )
      ),
    );
  }
  
  Widget currentModule(int index){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: moduleSelected == index?Colors.white:Colors.grey.withOpacity(0.2), width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(top: 10,bottom: 10),
      child: TextButton(
          onPressed: (){
            setState(() {
              moduleSelected = index;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                    child: Image.asset("assets/images/${educationalContent[index]['module-image']}.png",)),
              ),
              SizedBox(height:10,),
              Container(
                width: 200,
                child: Text(educationalContent[index]['module-title'], style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),textAlign: TextAlign.center,),
              ),
            ],
          )
      ),
    );
  }
  
  Widget lockedModule(int index){
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: moduleSelected == index?Colors.white:Colors.grey.withOpacity(0.2), width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextButton(
        onPressed: (){},
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.indigoAccent.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Container(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Opacity(
                          opacity: 0.5, // value between 0.0 and 1.0
                          child: Image.asset("assets/images/${educationalContent[index]['module-image']}.png",)
                      ),
                      Icon(Icons.lock_outline_rounded,color: Colors.white,size: 50,weight: 2,),
                    ],
                  )),
            ),
            SizedBox(height:10,),
            Container(
              width: 200,
              child: Text(educationalContent[index]['module-title'], style: GoogleFonts.montserrat(
                color: Colors.white.withOpacity(0.4),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),textAlign: TextAlign.center,),
            ),
          ],
        ),
      ),
    );
  }

  Widget startModuleButton(){
    return Positioned(
      bottom: 20,
      child: moduleSelected == -1?Container():Container(
          width: screenWidth(context),
          child: Column(
            children: [
              TextButton(
                  onPressed: () async {
                    if(moduleSelected != -1){
                      currentEducationModule = moduleSelected;
                      if(!UserModel.userData['modules']['modules-in-progress'].contains(currentEducationModule)){
                        UserModel.userData['modules']['modules-in-progress'].add(currentEducationModule);
                        UserModel.userData['modules']['modules-progress']['$currentEducationModule'] = {
                          'progress': 1,
                        };
                        // Use dot notation to access the nested list inside "modules"
                        await UserModel.userRef.update({
                          'modules.modules-in-progress': FieldValue.arrayUnion([currentEducationModule]),
                        });
                        await UserModel.userRef.update({
                          'modules.modules-progress.$currentEducationModule.progress': 1,
                        });
                      }
                      Navigator.pushNamed(context, '/education-lesson');
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: screenWidth(context) * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                      color: moduleSelected == -1?secondaryColor:Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text("Start", style: GoogleFonts.montserrat(
                      color: moduleSelected == -1?Colors.white:Colors.black,
                      fontWeight: FontWeight.w600,
                    ),),
                  )
              ),
            ],
          )
      ),
    );
  }
  
}
