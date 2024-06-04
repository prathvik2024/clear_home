class DrawerModel{
  final String title;
  final String icon;
  List<DrawerModel>? child;
  bool isExpanded;
  void Function()? onClick;

  DrawerModel({required this.title, required this.icon, this.child = null,this.isExpanded=false, this.onClick});
}
