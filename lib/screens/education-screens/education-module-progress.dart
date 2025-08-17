import 'package:blazemobile/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../utils.dart';
import '../../widgets/level-map/level_map.dart';
import '../../widgets/level-map/model/image_params.dart';
import '../../widgets/level-map/model/level_map_params.dart';



class EducationModuleProgress extends StatefulWidget {
  const EducationModuleProgress({super.key});

  @override
  State<EducationModuleProgress> createState() => _EducationModuleProgressState();
}

class _EducationModuleProgressState extends State<EducationModuleProgress> {

  int moduleSelected = -1;
  int parentModule = 0;



  @override
  void initState() {
    super.initState();
    educationalChatbot = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GradientBackground(
          child: Column(
            children: [
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

              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    //itemCount: educationalContent[0]['content-amount'],
                    itemCount: 2,
                    itemBuilder: (context, index){
                      return UserModel.userData['modules']['completed-modules'].contains(index)?
                      ModuleBtn(index, 'complete'):
                      UserModel.userData['modules']['modules-in-progress'].contains(index)?
                      ModuleBtn(index, 'in-progress')
                          :index <= UserModel.userData['modules']['current-module']?
                      ModuleBtn(index, 'current'):ModuleBtn(index, 'locked');
                    }
                ),
              ),
              SizedBox(height: xlargeGap,),

              AnimatedSlide(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                offset: moduleSelected != -1 ? Offset(0, 0) : Offset(0, 1),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: moduleSelected != -1 ? 1 : 0,
                  child: startModuleButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ModuleBtn(int index, String status){
    return GestureDetector(
      onTap: status == 'locked' ? null : (){
        setState(() {
          moduleSelected = index == moduleSelected ? -1 : index;
        });
      },
      child: Container(
      height: 300,
      margin: EdgeInsets.only(bottom: largeGap), clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(color: moduleSelected == index?Colors.white:Colors.grey.withOpacity(0.2), width: 2),
        borderRadius: borderRadius,
      ),
      child: Stack(
          fit: StackFit.expand,
        children: [
          Container(
            padding: cardPadding,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(status == 'in-progress')
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Continue", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.orangeAccent.shade100)),
                  SizedBox(width: smallGap),
                  Container(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      value: UserModel.userData['modules']['modules-progress']['$index']['progress']/ educationalContent[parentModule][index]['module-length'],
                      strokeWidth: 4,
                      backgroundColor: Colors.blueAccent.shade700,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent.shade100),
                    ),
                  ),
                ],
              ),
              if(status == 'complete')
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Completed", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.greenAccent)),
                    SizedBox(width: smallGap),
                    Container(
                      child: Icon(Icons.check_circle,color: Colors.greenAccent,size: 40,),
                    ),
                  ],
                ),
              if(status == 'in-progress' || status == 'complete')
                SizedBox(height: smallGap),

              Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                    child: Image.asset("assets/images/${educationalContent[parentModule][index]['module-image']}.png",)),
              ),
              SizedBox(height: smallGap),
              Text(educationalContent[parentModule][index]['module-title'], style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),

            ],
                    ),
          ),
          if(status == 'locked')
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Icon(Icons.lock_outline_rounded,color: Colors.white,size: 150,weight: 2,),
              ),
            ),
        ]
      ),
              )
    );
  }



  Widget startModuleButton(){
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: moduleSelected != -1 ? () async {
          if(moduleSelected != -1){
            currentEducationModule = moduleSelected;
            if(!UserModel.userData['modules']['modules-in-progress'].contains(currentEducationModule)){
              UserModel.userData['modules']['modules-in-progress'].add(currentEducationModule);
              UserModel.userData['modules']['modules-progress']['$currentEducationModule'] = {
                'progress': 1,
              };
              await UserModel.userRef.update({
                'modules.modules-in-progress': FieldValue.arrayUnion([currentEducationModule]),
              });
              await UserModel.userRef.update({
                'modules.modules-progress.$currentEducationModule.progress': 1,
              });
            }
            Navigator.pushNamed(context, '/education-lesson');
          }
        } : null,
        child: Text("Start"),
      ),
    );
  }
  
}

/*

 Expanded(
                child: LevelMap(
                  checkpointSize: Size(60, 60),
                  levelMapParams: LevelMapParams(

                    levelCount: 9,
                    currentLevel: 1,
                    levelHeight: 200, //distance between levels
                    pathStrokeWidth: 15, //path thickness
                    dashLengthFactor: 0.025, //distance between dashes 0.5 >= x > 0 (least is 0.025) for no spacing
                    pathColor: Colors.white,
                    showPathShadow: false,
                    enableVariationBetweenCurves: false,
                    //want to remove
                    currentLevelImage: ImageParams(
                      path: "assets/images/blazebot.png",
                      size: Size(64, 64),
                    ),


                    //want to keep
                    /*startLevelImage: ImageParams(
                    path: "assets/images/Boy Study.png",
                    size: Size(60, 60),
                  ),
                  pathEndImage: ImageParams(
                    path: "assets/images/Boy Graduation.png",
                    size: Size(60, 60),
                  ),
                  bgImagesToBePaintedRandomly: [
                    ImageParams(
                        path: "assets/images/Energy equivalency.png",
                        size: Size(80, 80),
                        repeatCountPerLevel: 0.5),
                    ImageParams(
                        path: "assets/images/Astronomy.png",
                        size: Size(80, 80),
                        repeatCountPerLevel: 0.25),
                    ImageParams(
                        path: "assets/images/Atom.png",
                        size: Size(80, 80),
                        repeatCountPerLevel: 0.25),
                    ImageParams(
                        path: "assets/images/Certificate.png",
                        size: Size(80, 80),
                        repeatCountPerLevel: 0.25),
                  ],
                  */
                  ),
                  checkpointBuilder: (level, isCompleted, isCurrent) => Builder(
                    builder: (context) => GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          clipBehavior: Clip.hardEdge,
                          context: context,
                          builder: (context) {
                            final topics = educationalModules[0]['topics'];
                            final currentModule = topics.keys.toList()[level - 1];
                            final subModuleTitle = (topics[currentModule] is String) ? topics[currentModule] : topics[currentModule]['title'];
                            return Stack(
                              children: [

                                Container(
                                  height: 500,
                                  width: double.infinity,
                                  padding: cardPadding,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 200,
                                            width: 200,
                                            child: Image.asset("assets/images/${educationalContent[level - 1]['module-image']}.png",),
                                          ),
                                          Text(
                                            'Module $currentModule',
                                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: mainColor),
                                          ),
                                          Text(
                                            '$subModuleTitle',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: mainColor),
                                          ),
                                        ],
                                      ),
                                      startModuleButton(
                                        (isCurrent || isCompleted) ? level - 1 : -1,
                                      )// add your drawer content here
                                    ],
                                  ),
                                ),
                                if(!(isCurrent || isCompleted))
                                  Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    color: Colors.black.withOpacity(0.5),
                                    child: Center(
                                      child: Icon(Icons.lock_outline_rounded,color: Colors.white,size: 200,weight: 2,),
                                    ),
                                  ),
                              ]
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted ? Colors.green : isCurrent ? Colors.amber : Colors.grey,
                        ),
                        child: Center(child: Text('$level')),
                      ),
                    ),
                  ),



                ),
              ),

 */




