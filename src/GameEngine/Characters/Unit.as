package GameEngine.Characters 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author skipgamer
	 */
	public class Unit extends Entity 
	{
		public var graphiclist:Graphiclist;
		public var unitSprite:Spritemap; //set in hero.as
		public var weaponSprite:Spritemap; //set in hero.as
		public var isHero:Boolean;
		
		public var unitName:String = "";
		public var health:Number;
		public var maxHealth:Number;
		public var power:Number;
		public var maxPower:Number;
		
		public var walkUp:Boolean;
		public var walkDown:Boolean;
		public var walkLeft:Boolean;
		public var walkRight:Boolean;
		public var isMoving:Boolean;
		public var direction:String = "down";
		
		public var isCasting:Boolean;
		
		public var unitID:int = 0; //set by gameworld
		
		public function Unit() 
		{
			
		}
		
		public function SpriteMap():void
		{
			AddSprites(unitSprite);
			if (isHero) {AddSprites(weaponSprite);}
			
			if (isHero) { graphiclist = new Graphiclist(unitSprite, weaponSprite); }
			else { graphiclist = new Graphiclist(unitSprite); }
			graphic = graphiclist;
		}
		
		public function AddSprites(_spritemap:Spritemap):void
		{
			var i:int;
			i = 0;
			_spritemap.add("walkDown", [i + 0, i + 1, i + 0, i + 2], 4, true);
			i = 3;
			_spritemap.add("walkRight", [i + 0, i + 1, i + 0, i + 2], 4, true);
			i = 6;
			_spritemap.add("walkLeft", [i + 0, i + 1, i + 0, i + 2], 4, true);
			i = 9;
			_spritemap.add("walkUp", [i + 0, i + 1, i + 0, i + 2], 4, true);
			i = 0;
			_spritemap.add("standDown", [i + 0], 1);
			i = 3;
			_spritemap.add("standRight", [i + 0], 1);
			i = 6;
			_spritemap.add("standLeft", [i + 0], 1);
			i = 9;
			_spritemap.add("standUp", [i + 0], 1);
		}
		
		public function UnitNotMoving():void //to be overwritten by hero
		{
			//do nothing 
		}
		
		override public function update():void
		{
			
			
			if (!isMoving) //if not moving
			{
				//PlayAnim(direction, 2); //play stand animation
				//UnitNotMoving();
			}
			else
			{
				if (walkUp && !walkLeft && !walkRight && !walkDown) //up
				{
					this.y -= 120*FP.elapsed; //should be 2 units per second regardless of fps
				}
				if (walkDown && !walkLeft && !walkRight && !walkUp) //down
				{
					this.y += 120*FP.elapsed;
				}
				if (walkLeft && !walkUp && !walkDown && !walkRight) //left
				{
					this.x -= 120*FP.elapsed;
				}
				if (walkRight && !walkUp && !walkDown && !walkLeft) //right
				{
					this.x += 120*FP.elapsed;
				}
				if (walkUp && walkLeft && !walkRight && !walkDown) //upleft
				{
					this.y -= 80*FP.elapsed;
					this.x -= 80*FP.elapsed;
				}
				if (walkUp && walkRight && !walkLeft && !walkDown) //upright
				{
					this.y -= 80*FP.elapsed;
					this.x += 80*FP.elapsed;
				}
				if (walkDown && walkLeft && !walkRight && !walkUp) //downleft
				{
					this.y += 80*FP.elapsed;
					this.x -= 80*FP.elapsed;
				}
				if (walkDown && walkRight && !walkLeft && !walkUp) //downright
				{
					this.y += 80*FP.elapsed;
					this.x += 80*FP.elapsed;
				}
			PlayAnim(direction, 1);
			layer = -y; //the higher the number the lower the object
			}
		}
		
		
		
		//// actions
		// 1 = walk
		// 2 = stand
		public function PlayAnim(_direction:String = "", _action:int = 0):void
		{
			if (_action == 1)
			{
				unitSprite.play("walk" + _direction);
				if (isHero) {weaponSprite.play("walk" + _direction);}
			}
			if (_action == 2)
			{
				unitSprite.play("stand" + _direction);
				if (isHero) {weaponSprite.play("stand" + _direction);}
			}
		}
		
		public function RecieveStopWalk():void
		{
			isMoving = false;
			walkDown = false;
			walkRight = false;
			walkLeft = false;
			walkUp = false;
		}
		
		public function RecieveInput(_direction:String = "", _action:int = 0):void
		{
			trace("input recieved");
			
			if (_action == 1)
			{
				direction = _direction;
				isMoving = true;
				if (_direction == "Down")
				{
					walkDown = true;
				}
				if (_direction == "Right")
				{
					walkRight = true;
				}
				if (_direction == "Left")
				{
					walkLeft = true;
				}
				if (_direction == "Up")
				{
					walkUp = true;
				}
			}
			if (_action == 2)
			{
				if (_direction == "Down")
				{
					walkDown = false;
					if (walkLeft == true) direction = "Left";
					if (walkRight == true) direction = "Right";
				}
				if (_direction == "Right")
				{
					walkRight = false;
					if (walkUp == true) direction = "Up";
					if (walkDown == true) direction = "Down";
				}
				if (_direction == "Left")
				{
					walkLeft = false;
					if (walkUp == true) direction = "Up";
					if (walkDown == true) direction = "Down";
				}
				if (_direction == "Up")
				{
					walkUp = false;
					if (walkLeft == true) direction = "Left";
					if (walkRight == true) direction = "Right";
				}
				if (!walkUp && !walkDown && !walkLeft && !walkRight)
				{
					direction = _direction;
					isMoving = false;
					UnitNotMoving();
					PlayAnim(direction, 2);
				}
			}
		}
		
		public function MoveToLocation(_x:int, _y:int):void //moves the unit to a location
		{
			this.x = _x;
			this.y = _y;
		}
		
		public function DealDamage(_damageAmount:int, _fromid:int):void //called to deal damage to this unit (for example from game world when damage is delt), overriden by entities which extend this
		{
			
		}
	}

}