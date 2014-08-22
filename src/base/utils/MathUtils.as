package base.utils 
{
	/**
	 * ...
	 * @author 
	 */
	public class MathUtils 
	{
		
		public static function randRange(minNum:Number, maxNum:Number):Number 
        {
            return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
        }
		
		public static function shuffle(array:Array):Array {
			var l:int = array.length;
			for (var i:uint=0; i<l; i++) {
				var j:uint = l * Math.random() | 0;
				if (j==i) { continue; }
				var item:* = array[j];
				array[j] = array[i];
				array[i] = item;
			}
			return array;
		}
		
	}

}