package base.model 
{
	
	import base.robotlegs.ModularData;
	import com.kashirov.models.Store;
	
	public class ModularStore extends Store 
	{
		
		public var assign:ModularData;
		
		public function get(key:*):ModularData { return getItem(key) as ModularData; }
		public function remove(key:*):ModularData { return removeItem(key) as ModularData; }
		public function add(key:* = null, data:Object = null):ModularData { return addItem(key, data) as ModularData; }
		
	}

}