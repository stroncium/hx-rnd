package rnd;

abstract FastRNG(Int) from Int to Int{
  static inline var FLOAT_MULT = 0.00000000046566128742;
  static inline var INT_MULT = 0x7FFFFFFF;

  public function new(?seed:Int){
    this = (seed == null) ? newSeed() : seed;
  }

  static inline function mutate(v){
    var t:Int = (v^(v<<11));
    return (v ^ (v >> 19))^(t ^ (t >> 8));
  }

  public inline function getInt():Int{
    return this = mutate(this);
  }

  public inline function getFloat()
    return getInt(this) * FLOAT_MULT;

  public inline function getIntB(bound:Int) return getInt(this) % bound;

  public inline function getIntBB(lb:Int, rb:Int)
    return lb + getIntB(this, rb - lb);

  public inline function getFloatB(bound:Float) return bound * getFloat(this);

  public inline function getFloatBB(lb:Float, rb:Float)
    return lb + getFloatB(this, rb - lb);

  public inline function getBool() return (getInt(this) & 1) == 0;

  public static function newSeed():Int{
    return Std.int((Math.random()*2 - 1) * INT_MULT);
    }


  public inline function bool(?chance:Float)
    return (chance == null) ? getBool(this) : getFloat(this) < chance;

  public inline function int(?b1:Int, ?b2:Int)
    return
      (b2 == null) ?
        (b1 == null) ? getInt(this) : getIntB(this, b1):
        getIntBB(this, b1, b2);

  public inline function float(?b1:Null<Float>, ?b2:Null<Float>)
    return
      (b2 == null) ?
        (b1 == null) ? getFloat(this) : getFloatB(this, b1):
        getFloatBB(this, b1, b2);

  // #if flash
  //   static inline var UINT_MULT = 4294967295;
  //   public inline function getUInt():UInt return getInt()
  //   public inline function u() return getUInt()
  // #end



}
