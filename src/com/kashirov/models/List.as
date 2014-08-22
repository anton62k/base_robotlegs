package com.kashirov.models 
{
	import org.as3commons.collections.ArrayList;
	/**
	 * ...
	 * @author ...
	 */
	public class List extends ArrayList
	{
		
		public function updateData(data:Array):void
		{
			clear();
			for (var i:int = 0; i < data.length; i++) 
			{
				add(data[i]);
			}
		}
		
		public function data():Array
		{
			return toArray();
		}
		
	}

}