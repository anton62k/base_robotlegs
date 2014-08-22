package base.script.vo 
{
	
	import com.kashirov.models.Store;
	
	public class ScriptStore extends Store 
	{
		
		public var assign:Script;
		
		public function get(key:*):Script { return getItem(key) as Script; }
		public function remove(key:*):Script { return removeItem(key) as Script; }
		public function add(key:* = null, data:Object = null):Script { return addItem(key, data) as Script; }
		
	}

}