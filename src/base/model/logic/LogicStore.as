package base.model.logic 
{
	
	import com.kashirov.models.Store;
	
	public class LogicStore extends Store
	{
		
		public var assign:LogicItem;
		
		public function get(key:*):LogicItem { return getItem(key) as LogicItem; }
		public function remove(key:*):LogicItem { return removeItem(key) as LogicItem; }
		public function add(key:* = null, data:Object = null):LogicItem { return addItem(key, data) as LogicItem; }
		
		
	}

}