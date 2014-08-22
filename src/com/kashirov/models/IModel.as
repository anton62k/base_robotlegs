package com.kashirov.models 
{
	
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IModel 
	{
		
		function get changeSignal():Signal;
		function get prefix():String;
		function set prefix(value:String):void;
		
		function data():Object;
		function updateData(value:Object):void;
		function dispose():void;
		function init():void;
		
	}
	
}