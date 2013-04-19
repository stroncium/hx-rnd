import haxe.Timer;

class Test{
  public static function main(){
    trace(measure([
      function(iter){
        var rng = new rnd.FastRNGObj();
        var v;
        for(i in 0...iter) v = rng.int();
      },
      function(iter){
        var rng = new rnd.FastRNG();
        var v;
        for(i in 0...iter) v = rng.int();
      },
    ], 20, 1000000)) ;
  }

  static inline function measure(fs:Array<Int->Void>, ?globalIter = 10, ?localIter = 100000){
    var res = [for(f in fs) 0.0];
    var t;
    for(gi in 0...globalIter){
      trace('global iteration $gi');
      for(fi in 0...fs.length){
        t = Timer.stamp();
        fs[fi](localIter);
        res[fi] += Timer.stamp() - t;
      }
    }
    return res;
  }
}