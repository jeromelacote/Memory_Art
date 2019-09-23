﻿package com.jeromelacote.exploration {		import caurina.transitions.*;		import flash.display.MovieClip;	import flash.display.Sprite;	import flash.display.Stage;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.events.TimerEvent;	import flash.filters.DropShadowFilter;	import flash.filters.GlowFilter;	import flash.system.Security;	import flash.utils.Timer;	import flash.utils.getTimer;	import com.jeromelacote.exploration.Creature;
		public class Mover extends Creature	{		public var _type:String;		public var _speed:Number=10;		public var _direction:Number=1; //+1 ou -1		public var _destination:Number;		public var _startpos:Number=-300;		public var _isHooked:Boolean;		public var _waitTime:Number=0;		public var _finalpos:Number;		[Inspectable]		public var speed:Number;		[Inspectable]		public var destination:Number;		[Inspectable]		public var startpos:Number;		[Inspectable]		public var invert:Boolean=false;		[Inspectable]		public var isfilter:Boolean=false;				public function Mover()		{			//loaderInfo.addEventListener(Event.INIT, onInit);			addEventListener(Event.ADDED_TO_STAGE, onInit);			//trace(this.name);		}		public function onInit(e:Event)		{			if (destination){				_destination=destination;								}else{				_destination=960*4+300;				}			if (speed){				_speed=speed;			}else{			}			if (startpos){				_startpos=startpos;			}						if(this.isfilter!=true){				//trace(this.name+" isfilter false");				if(this.filters.length<1){					var filter1:GlowFilter =new GlowFilter(0x000000, 1, 5, 5, 20, 3, false, false);					var filter2:DropShadowFilter=new DropShadowFilter(7, 65, 0x000000, 1, 5, 5, 0.4, 1, false, false, false);					this.filters=[filter1,filter2];				}			}			_finalpos=_destination;			move();			//trace('Plane_mc init' + _startpos);		}								public function move():void		{			//trace('object moves');						Tweener.addTween(this,{x:_finalpos,time:_speed,delay:_waitTime,transition:'linear',onComplete:moveAgain});		}				public function moveAgain():void		{						if (_direction==1){_direction=-1;}else{_direction=1;}			if (_direction==1){				_finalpos=_destination;			}else{				_finalpos= _startpos;			}			if(this.name!="CREATURE_pingu"){			scaleX = _direction * Math.abs(scaleX);			}			_waitTime=Math.random()*2;						//trace('object waits '+ _destination);			//changeAltitude();			move();					}	}	}