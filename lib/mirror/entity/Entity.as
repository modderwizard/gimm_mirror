package lib.mirror.entity
{
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	import lib.mirror.Dictionary;
	import lib.mirror.GameSettings;
	import lib.mirror.entity.states.*;
	import lib.mirror.graphics.AnimationCollection;
	import lib.mirror.level.Level;
	import lib.mirror.physics.Quadrilateral;
	
	public class Entity extends Sprite
	{
		// General
		public var healthMax:Number;
		public var health:Number;
		public var score:Number;
		public var isDead:Boolean;
		public var canRemove:Boolean;
		protected var invulnerable:Boolean;
		protected var abilities:Array;
		
		// State
		public var state:State = null;		
		
		// Animation
		protected var animations:AnimationCollection = new AnimationCollection();
		
		// Position
		public var posX:Number;
		public var posY:Number;
		public var posXPrev:Number;
		public var posYPrev:Number;
		
		// Facing
		protected var direction:int;
		protected var directionPrev:int;
		
		// Velocity
		public var xVel:Number;
		public var yVel:Number;
		public var xVelPrev:Number;
		public var yVelPrev:Number;
		
		// Physics
		public var onGround:Boolean;
		public var physicsCheckTiles:Boolean;
		public var physicsCheckEntities:Boolean;
		public var physicsDoGravity:Boolean;
		
		public var boundingBoxWidth:int;
		public var boundingBoxHeight:int;
		private var boundingBox:Quadrilateral;
		private var boundingBoxPrev:Quadrilateral;
		
		public var level:Level;
		
		public function Entity()
		{
			this.healthMax = 1;
			this.health = 1;
			this.score = 0;
			this.isDead = false;
			this.canRemove = false;
			this.invulnerable = false;
			
			this.abilities = new Array();
			
			this.posX = x;
			this.posY = y;
			this.posXPrev = x;
			this.posYPrev = y;
			
			this.direction = 1;
			this.directionPrev = 1;
			
			this.xVel = 0;
			this.yVel = 0;
			this.xVelPrev = 0;
			this.yVelPrev = 0;
			
			this.onGround = false;
			this.physicsCheckTiles = true;
			this.physicsCheckEntities = true;
			this.physicsDoGravity = true;
			
			this.boundingBox = new Quadrilateral();
			this.boundingBoxPrev = new Quadrilateral();

			this.boundingBoxWidth = 16;
			this.boundingBoxHeight = 16;
			
			this.addChild(this.animations);
		}
		
		public function update():void
		{
			this.animations.update();
			
			if(this.state != null)
			{
				this.state.update(this);
			}
			
			// Update 'previous' values
			this.xVelPrev = this.xVel;
			this.yVelPrev = this.yVel;
			
			this.posXPrev = posX;
			this.posYPrev = posY;
			
			this.posX += xVel;
			this.posY += yVel;
			
			// Set new x and y position
			this.x = this.posX;
			this.y = this.posY;
			
			this.x = int(this.x);
			this.y = int(this.y);
		}
		
		public function applyForce(velX:Number, velY:Number, sender:Object):void
		{
			this.xVel += velX;
			this.yVel += velY;
		}
		
		public function setForce(velX:Number, velY:Number, sender:Object):void
		{
			if(!isNaN(velX))
			{
				this.xVel = velX;
			}
			
			if(!isNaN(velY))
			{
				this.yVel = velY;
			}
		}
		
		public function getBoundingBox():Quadrilateral
		{
			return this.boundingBox.fromPositionAndSize(this.posX - this.getBoundingBoxXOffset(), this.posY, this.boundingBoxWidth, this.boundingBoxHeight);
		}
		
		public function getBoundingBoxPrev():Quadrilateral
		{
			return this.boundingBoxPrev.fromPositionAndSize(this.posXPrev - this.getBoundingBoxXOffset(), this.posYPrev, this.boundingBoxWidth, this.boundingBoxHeight);
		}
		
		public function getBoundingBoxXOffset():int
		{
			return this.direction == -1 ? this.boundingBoxWidth : 0;
		}
		
		public function getDirection():int
		{
			return this.direction;
		}
		
		public function setDirection(direction:int):void
		{
			this.directionPrev = this.direction;
			this.direction = direction;
			
			if(this.direction != this.directionPrev)
			{
				if(this.direction == -1)
				{
					this.posX += this.getBoundingBox().width;
				}
				else
				{
					this.posX -= this.getBoundingBox().width;
				}
				
				this.scaleX = this.direction;
			}
		}
		
		public function setState(state:State):void
		{
			if(this.state != null)
			{
				this.state.exit(this);
			}
			
			this.state = state;
			this.state.enter(this);
		}
		
		public function getState():State
		{
			return this.state;
		}
		
		public function setAnimation(animation:String):void
		{
			this.animations.setAnimation(animation);
		}
		
		public function getAnimation():String
		{
			return this.animations.getAnimationName();
		}
		
		public function getGravityMultiplier():Number
		{
			return 1.0;
		}
		
		public function canAttack(entity:Entity):Boolean
		{
			return entity != this;
		}
		
		public function onAttacked(attacker:Entity):void
		{
			this.health--;
						
			if(this.health <= 0)
			{
				this.setDead();
				
				attacker.addScore(1);
			}
		}
		
		public function onTileHit(side:String, quad:Quadrilateral):Boolean
		{
			return true;
		}
		
		public function setDead():void
		{
			this.isDead = true;
			this.canRemove = true;
		}
		
		public function setInvulnverable(invulnerable:Boolean, playAnim:Boolean):void
		{
			this.invulnerable = invulnerable;
		}
		
		public function isInvulnerable():Boolean
		{
			return this.invulnerable;
		}
		
		public function addScore(toAdd:Number):void
		{
			this.score += toAdd;
		}
		
		public function hasAbility(ability:Ability):Boolean
		{
			return this.abilities.indexOf(ability) >= 0;
		}
		
		public function getIdentifier():String
		{
			throw new Error("Entity class does not override getIdentifier!");
		}
	}
}