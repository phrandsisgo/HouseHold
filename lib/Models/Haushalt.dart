class Haushalte{
  String path;
  String name;

  Haushalte(this.path,this.name);
  String toString(){
    return' ${this.path},${this.name}';
  }
  Haushalte.einzeilig(this.path){
    String zuString(){
      return '${this.path}';
    }
  }
  Haushalte.etwas(this.path,this.name){
    String zuEinemString(){return '${this.path}';
     name= name;}
  }
}