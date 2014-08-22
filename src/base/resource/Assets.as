package base.resource 
{
	
	import starling.utils.AssetManager;
	
	public class Assets extends AssetManager
	{
		private static var _instance:Assets;
		public static function get instance():Assets { return _instance; }
		
		[PostConstruct]
		public function init():void
		{
			_instance = this;
		}
		
	}

}