package base.robotlegs 
{
	import base.model.config.Module;
	import base.model.ModularStore;
	import com.kashirov.models.IModel;
	
	public class BaseHook extends BaseCommand 
	{
		
		[Inject]
		public var module:Module;
		
		[Inject]
		public var moduleStore:ModularStore;
		
		public var rt:Object;
		
		override public function execute():void
		{
			rt = { };
			super.execute();
			hook();
			var modularData:ModularData = moduleStore.get(module.prefix) || moduleStore.add(module.prefix);
			modularData.moduleData = getReturn(); 
		}
		
		public function hook():void
		{
			// override
		}
		
		public function getReturn():Object {
			if (rt is IModel) {
				return (rt as IModel).data();
			}
			return rt;
		}
		
		protected function getModuleModel(clazz:Class):Object 
		{
			if (!(rt is clazz)) {
				rt = new clazz();
			}
			return rt;
		}
		
	}

}