package rnd;

class FastRNGObj{
  static inline var FLOAT_MULT = 0.00000000046566128742;
  static inline var INT_MULT = 0x7FFFFFFF;
  public var seed:Int;

  public function new(?seed:Null<Int>)
    this.seed = (seed == null) ? newSeed() : seed;

  public inline function getInt():Int{
    var t:Int = (seed^(seed<<11));
    return seed = (seed ^ (seed >> 19))^(t ^ (t >> 8));
    }

  public inline function getFloat():Float
    return getInt() * FLOAT_MULT;

  public inline function getIntBound(bound:Int)
    return getInt() % bound;

  public inline function getIntBounds(lbound:Int, rbound:Int)
    return lbound+(getInt() % (rbound-lbound));

  public inline function getFloatBound(bound:Float)
    return bound*getFloat();

  public inline function getFloatBounds(lbound:Float, rbound:Float)
    return lbound+((rbound-lbound)*getFloat());

  public inline function getBool():Bool
    return (getInt() & 1) == 0;

  public static function newSeed():Int{
    return Std.int((Math.random()*2 - 1) * INT_MULT);
  }


  public inline function bool(?trueProbability:Null<Float>)
    return (trueProbability == null) ? getBool() : getFloat() < trueProbability;

  public inline function int(?b1:Null<Int>, ?b2:Null<Int>)
    return
      (b2 == null) ?
        (b1 == null) ? getInt() : getIntBound(b1)
        :
        getIntBounds(b1, b2);

  public inline function float(?b1:Null<Float>, ?b2:Null<Float>)
    return
      (b2 == null) ?
        (b1 == null) ? getFloat() : getFloatBound(b1)
        :
        getFloatBounds(b1, b2);

  // #if flash
  //   static inline var UINT_MULT = 4294967295;
  //   public inline function getUInt():UInt return getInt()
  //   public inline function u() return getUInt()
  // #end


  }
