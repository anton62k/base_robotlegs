package base.main.command 
{
	
	import base.Actions;
	import base.robotlegs.ModularData;
	
	public class StartupCommand extends MainCommand 
	{
		
		override public function execute():void
		{
			scriptManager.update(ModularData.create(Actions.INIT).setModule('main'));
		}
		
	}

}