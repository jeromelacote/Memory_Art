package com.jeromelacote.mylib{
	
	//import com.adobe.serialization.json.JSON;
	//import com.playdom.cityofmight.hud.CityOfMightHUD;
	//import com.playdom.projectsparta.ui.event.*;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLVariables;
	import flash.utils.Dictionary;
	
	
	public class SubController{
		
		protected var _dispatcher:EventDispatcher;
		private var _listenerTable:Dictionary;
	//	protected var _hud:CityOfMightHUD;
		
		public function SubController(){//hud:CityOfMightHUD
			//_hud = hud;
			_dispatcher = UIEventDispatcher.INSTANCE;
			_listenerTable = new Dictionary();
			//_hud.stage.addEventListener( Event.RESIZE, onStageResize );
		}
		
		
		public function dispatchEvent( event:Event ):void{
			_dispatcher.dispatchEvent( event );
		}
		
		protected function setEventListener( type:String, listener:Function ):void {
			clearEventListener( type );
			_listenerTable[type] = listener;
			_dispatcher.addEventListener( type, listener, false, 0, true );
		}
		
		protected function clearEventListener( type:String ):void {
			if( _listenerTable[type] != null ){
				_dispatcher.removeEventListener( type, _listenerTable[type] as Function, false );
				delete _listenerTable[type];
			}
		}
		
		public function clearAllEventListeners( ):void {
			//_hud.stage.removeEventListener( Event.RESIZE, onStageResize );
			for( var type:String in _listenerTable ){
				if( _listenerTable[type] != null ){
					_dispatcher.removeEventListener( type, _listenerTable[type] as Function, false );
					delete _listenerTable[type];
				}
			}
		}
		
		protected function onStageResize( evt:Event ):void{
			
		}
		
		
		
	}
}