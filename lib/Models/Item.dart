class ItemsInHousehold{
  String path;
  String name;

  ItemsInHousehold(this.path,this.name);
  String toString(){
    return '${this.path},${this.name}';
  }
}