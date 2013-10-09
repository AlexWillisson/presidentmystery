package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.display.InteractiveObject;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class PlayerEntity extends Entity 
	{
		//protected const PLAYER_HSPEED_MAX:int = 70;
		//protected const PLAYER_HACCEL:int = 25;
		//protected const GRAVITY:int = 4;
		//protected const DRAG:int = -60;
		//protected const PLAYER_JUMP:int = 150;
		//protected var a:Point;
		//protected var v:Point;
		
		[Embed(source="../assets/images/player.png")] private const PLAYER:Class;
		
		public function PlayerEntity() 
		{
			graphic = new Image(PLAYER);
			//a = new Point();
			//v = new Point();
			setHitbox(27,35);
		}

		override public function update():void
		{
			/*// Checking player input.
			var hInput:int = 0;
			if(Input.check(Key.LEFT)) {a.x = -PLAYER_HACCEL;} // MOVE LEFT
			else if (Input.check(Key.RIGHT)) {a.x = PLAYER_HACCEL;} // MOVE RIGHT
			else {
				if(v.x > 0) {
					a.x = DRAG;
					if ((v.x + a.x) < 0) { v.x = 0 } ;
				}
				if (v.x > 0) {
					a.x = -DRAG;
				if ((v.x + a.x) > 0) {v.x = 0 } ;
				}
			}
			

			// Update physics.
			if ( v.x + a.x < PLAYER_HSPEED_MAX && v.x + a.x > -PLAYER_HSPEED_MAX);{
				v.x += a.x;
			}

			a.y = GRAVITY;
			v.y += a.y;*/

			if (Input.check(Key.LEFT)) { v.x = -160; }
			else if (Input.check(Key.RIGHT)) { v.x = 160; }
			else { v.x = 0 }
			v.y = 80
			
			// Apply physics.
			x += v.x * FP.elapsed;
			y += v.y * FP.elapsed;

			// Simple collision with boundries.
			if(y + height > FP.screen.height)
			{
				v.y = 0;
				y = FP.screen.height - height;
			}

			// Update parent shit.
			super.update();
		}
		
	}

}