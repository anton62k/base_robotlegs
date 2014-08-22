package base.model.config 
{
	
	import com.kashirov.models.Store;
	
	public class ModuleStore extends Store
	{
		
		public var assign:Module;
		
		public function get(key:*):Module { return getItem(key) as Module; }
		public function remove(key:*):Module { return removeItem(key) as Module; }
		public function add(key:* = null, data:Object = null):Module { return addItem(key, data) as Module; }
		
	}

}