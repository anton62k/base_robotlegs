package base.script.vo 
{
	
	import com.kashirov.models.Store;
	
	public class ExecuteStore extends Store
	{
		
		public var assign:Check;
		
		public function get(key:*):Check { return getItem(key) as Check; }
		public function remove(key:*):Check { return removeItem(key) as Check; }
		public function add(key:* = null, data:Object = null):Check { return addItem(key, data) as Check; }
		
	}

}