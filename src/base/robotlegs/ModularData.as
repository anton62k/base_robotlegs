package base.robotlegs 
{
	
	import base.Actions;
	import com.kashirov.models.Unit;
	
	public class ModularData extends Unit 
	{
		
		public static function create(action:String):ModularData
		{
			var data:ModularData = new ModularData();
			return data.setAction(action);
		}
		
		public static function logic(command:String):ModularData
		{
			return new ModularData().setAction(Actions.LOGIC).setLogic(command);
		}
		
		public static function update(module:String):ModularData
		{
			return new ModularData().setAction(Actions.UPDATE).setModule(module);
		}
		
		public static function close(module:String):ModularData
		{
			return new ModularData().setAction(Actions.CLOSE).setModule(module);
		}
		
		public static function select(module:String):ModularData
		{
			return new ModularData().setAction(Actions.SELECT);
		}
		
		public static function open(module:String):ModularData
		{
			return new ModularData().setAction(Actions.OPEN).setModule(module);
		}
		
		public static function moduleData(value:Object):ModularData
		{
			return new ModularData().setModuleData(value)
		}
		
		public function ModularData()
		{
			
		}
		
		public function setOwnModule(module:String):ModularData
		{
			this.ownModule = module;
			return this;
		}		
		
		public function setAction(action:String):ModularData
		{
			this.action = action;
			return this;
		}
		
		public function setModule(module:String):ModularData
		{
			this.module = module;
			return this;
		}
		
		public function setLogic(logic:String):ModularData
		{
			this.logic = logic;
			return this;
		}
		
		public function setItemId(itemId:int):ModularData
		{
			this.itemId = itemId;
			return this;
		}
		
		public function setType(type:String):ModularData
		{
			this.type = type;
			return this;
		}
		
		public function setValue(value:Number):ModularData
		{
			this.value = value;
			return this;
		}
		
		public function setModuleData(moduleData:Object):ModularData
		{
			this.moduleData = moduleData;
			return this;
		}
		
		public function setEnabled(value:Boolean):ModularData
		{
			this.enabled = value;
			return this;
		}
		
		public var ownModule:String = '';
		public var action:String = '';
		public var module:String = '';
		public var logic:String = '';
		public var itemId:int = -1;
		public var type:String = '';
		public var value:Number = 0;
		public var enabled:Boolean = true;
		public var moduleData:Object;
		
	}

}