class DrawerModel{
  final String title;
  final String icon;
  List<DrawerModel>? child;
  bool isExpanded;

  DrawerModel({required this.title, required this.icon, this.child = null,this.isExpanded=false});
}
