package com.kashirov.models 
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author 
	 */
	public class Cache 
	{
		
		private static var cached:Object = { };
		private static var describeTypes:Object = { };
		private static var unitFields:Object = { };
		private static var unitFieldsHash:Object = { };
		private static var assignHash:Object = { };
		private static var exclude:Array = ['prefix', 'signal'];
		
		public static function cacheObject(obj:Object, className:String):void
		{
			if (cached[className]) {
				return;
			}
			
			var structure:XML = describeType(obj);
			describeTypes[className] = structure;
			
			if (obj is Unit) {
				var fieldsHash:Object = { };
				var fields:Array = [];
				for each (var childNode:XML in structure.variable) {
					var name:String = childNode.@name;
					if (exclude.indexOf(name) != -1) continue;
					if (childNode..metadata.(@name == 'Inject').length()) continue
					var type:String = childNode.@type;
					var clazz:Class = getDefinitionByName(type) as Class;
					fields.push(name);
					fieldsHash[name] = clazz;
				}
				fields = fields.sort();	
				
				unitFields[className] = fields;
				unitFieldsHash[className] = fieldsHash;
			}
			
			if (obj is Store) {
				var assignType:String = structure.variable.(@name == 'assign').@type;
				assignHash[className] = getDefinitionByName(assignType) as Class;
			}
			
			cached[className] = true;
		}
		
		public static function getDescribeType(obj:Object):XML
		{
			var name:String = getClassName(obj);
			cacheObject(obj, name);
			return describeTypes[name] as XML;
		}
		
		public static function getUnitFields(obj:Object):Array
		{
			var name:String = getClassName(obj);
			cacheObject(obj, name);
			var a:Array
			return unitFields[name].slice();
		}
		
		public static function getUnitFieldsHash(obj:Object):Object
		{
			var name:String = getClassName(obj);
			cacheObject(obj, name);
			return unitFieldsHash[name];
		}
		
		public static function getAssignClass(obj:Object):Class
		{
			var name:String = getClassName(obj);
			cacheObject(obj, name);
			return assignHash[name];
		}
		
		public static function getClassName(obj:Object):String
		{
			return getQualifiedClassName(obj)
		}
		
	}

}