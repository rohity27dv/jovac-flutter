import 'package:flutter/material.dart';

void main() => runApp(const CafeApp());

class CafeApp extends StatelessWidget {
  const CafeApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Arial', colorSchemeSeed: const Color(0xff573de4)),
    home: const CafePage(),
  );
}

class CafePage extends StatefulWidget { const CafePage({super.key}); @override State<CafePage> createState()=>_CafePageState(); }
class _CafePageState extends State<CafePage> {
  final data={'Burger':['🍔','Veg Burger','120'],'Pizza':['🍕','Margherita Pizza','250'],'Sandwich':['🥪','Grilled Sandwich','90'],'Cold Coffee':['🥤','Cold Coffee','80'],'French Fries':['🍟','French Fries','70']};
  String category='Burger'; int qty=1;
  Color get purple=>const Color(0xff573de4);
  void toast(String text)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:const Color(0xff35ad50),content:Text(text),action:SnackBarAction(label:'DISMISS',textColor:Colors.white,onPressed:(){})));
  void options()=>showMenu(context:context,position:const RelativeRect.fromLTRB(245,205,20,0),items:const [PopupMenuItem(child:Text('🧀  Add Cheese')),PopupMenuItem(child:Text('🧴  Extra Sauce')),PopupMenuItem(child:Text('🌿  View Nutrition')),PopupMenuItem(child:Text('↗  Share Item'))]);
  @override Widget build(BuildContext context) { final item=data[category]!; return Scaffold(
    appBar:AppBar(backgroundColor:purple,foregroundColor:Colors.white,elevation:0,centerTitle:true,title:const Text('Smart Café',style:TextStyle(fontWeight:FontWeight.bold)),leading:IconButton(onPressed:()=>Navigator.maybePop(context),icon:const Icon(Icons.arrow_back)),actions:[IconButton(onPressed:options,icon:const Icon(Icons.more_vert))]),
    body:SingleChildScrollView(padding:const EdgeInsets.fromLTRB(26,17,26,12),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      label('Choose Category'), const SizedBox(height:5),
      Container(height:46,padding:const EdgeInsets.symmetric(horizontal:12),decoration:BoxDecoration(border:Border.all(color:const Color(0xff7d61ff)),borderRadius:BorderRadius.circular(9)),child:DropdownButtonHideUnderline(child:DropdownButton<String>(value:category,isExpanded:true,icon:Icon(Icons.keyboard_arrow_down,color:purple),items:data.keys.map((x)=>DropdownMenuItem(value:x,child:Text('${data[x]![0]}   $x'))).toList(),onChanged:(x)=>setState(()=>category=x!)))),
      const SizedBox(height:16),label('Selected Item'),const SizedBox(height:5),
      Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Container(width:80,height:80,alignment:Alignment.center,decoration:BoxDecoration(color:const Color(0xfffff5df),borderRadius:BorderRadius.circular(9)),child:Text(item[0],style:const TextStyle(fontSize:53))),
        const SizedBox(width:13),Expanded(child:Padding(padding:const EdgeInsets.only(top:4),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(item[1],style:const TextStyle(fontSize:14,fontWeight:FontWeight.w600)),const SizedBox(height:5),const Text('Delicious veg burger with\nfresh veggies and cheese.',style:TextStyle(fontSize:11,color:Color(0xff555555),height:1.35)),Text('₹${item[2]}',style:const TextStyle(color:Color(0xff169d38),fontWeight:FontWeight.bold))]))),
        Container(width:35,height:35,decoration:BoxDecoration(color:const Color(0xfffaf9ff),border:Border.all(color:const Color(0xffe7e4ef)),borderRadius:BorderRadius.circular(8)),child:IconButton(padding:EdgeInsets.zero,onPressed:options,icon:Icon(Icons.more_vert,color:purple,size:20)))
      ]),
      const SizedBox(height:18),label('Quantity'),const SizedBox(height:6),Row(children:[round(Icons.remove,()=>setState(()=>qty=qty>1?qty-1:1)),const SizedBox(width:29),Text('$qty',style:const TextStyle(fontSize:19,fontWeight:FontWeight.w600)),const SizedBox(width:29),round(Icons.add,()=>setState(()=>qty++))]),
      const SizedBox(height:21),fullButton('🛒   Place Order',()=>toast('Order Placed Successfully!')),
      const SizedBox(height:8),SizedBox(width:225,height:40,child:OutlinedButton.icon(style:OutlinedButton.styleFrom(foregroundColor:purple,side:BorderSide(color:purple),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(7))),onPressed:()=>toast('Saved for later'),icon:const Icon(Icons.bookmark_border,size:18),label:const Text('Save for Later'))),
      const SizedBox(height:7),Center(child:TextButton.icon(onPressed:()=>setState((){category='Burger';qty=1;}),icon:const Icon(Icons.delete_outline,color:Colors.red,size:18),label:const Text('Clear Selection',style:TextStyle(color:Colors.red)))),
      const Divider(height:24),Center(child:Text('Order on iPhone Style',style:TextStyle(color:purple,fontSize:11,fontWeight:FontWeight.bold))),const SizedBox(height:4),
      SizedBox(width:double.infinity,height:40,child:ElevatedButton.icon(style:ElevatedButton.styleFrom(backgroundColor:const Color(0xff1fb2e7),foregroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(7))),onPressed:()=>toast('Order Placed Successfully!'),icon:const Icon(Icons.apple),label:const Text('Order on iPhone Style'))),
      const SizedBox(height:15),special()
    ])),
    floatingActionButton:FloatingActionButton.small(backgroundColor:purple,onPressed:()=>toast("Today's special: Veg Burger"),child:const Icon(Icons.cloud,color:Colors.white)),
  ); }
  Widget label(String x)=>Text(x,style:TextStyle(color:purple,fontSize:11,fontWeight:FontWeight.w600));
  Widget round(IconData icon,VoidCallback f)=>CircleAvatar(radius:19,backgroundColor:const Color(0xffeeeaff),child:IconButton(onPressed:f,icon:Icon(icon,color:purple,size:20)));
  Widget fullButton(String text,VoidCallback f)=>SizedBox(width:225,height:40,child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:purple,foregroundColor:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(7))),onPressed:f,child:Text(text)));
  Widget special()=>Container(width:double.infinity,padding:const EdgeInsets.all(17),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(10),boxShadow:const [BoxShadow(color:Color(0x22000000),blurRadius:9,offset:Offset(0,3))]),child:Row(children:[const Text('🎉',style:TextStyle(fontSize:48)),const SizedBox(width:17),const Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text("Today's Special",style:TextStyle(color:Color(0xff573de4),fontWeight:FontWeight.w600)),SizedBox(height:7),Text('Veg Burger'),SizedBox(height:4),Text('₹99',style:TextStyle(color:Color(0xff169d38),fontWeight:FontWeight.bold))])),CircleAvatar(radius:27,backgroundColor:const Color(0xfff1efff),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.close,color:purple),Text('Close',style:TextStyle(color:purple,fontSize:8))]))]));
}
