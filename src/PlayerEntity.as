package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.display.InteractiveObject;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class PlayerEntity extends Entity 
	{
		//All of the below constants are pretty arbitrary. Feel free to tweak according to preferences.
		protected const PLAYER_HSPEED_MAX:int = 4;
		protected const PLAYER_HACCEL:int = 1;
		protected const GRAVITY:Number = .2; 
		protected const PLAYER_JUMP:int = -GRAVITY * 30;
		protected const DRAG:int = -10;
		
		//These are points that can store x and y values, accessed by v.x v.y, etc.
		//There are just kind of a fancy way of storing velocity and acceleration.
		protected var accel:Point; //Acceleration
		protected var vel:Point; //Velocity
		
		private var exit:Boolean = false;
		
		[Embed(source = "../assets/images/platformer/SpritePres.png")] private const PLAYER_SPRITE:Class;
		
		protected var animatedSprite:Spritemap;
		public function PlayerEntity() 
		{
			//Istantializes a lot of stuff, i.e. accel and hitbox.
			animatedSprite = new Spritemap(PLAYER_SPRITE, 60, 60);
			graphic = animatedSprite;
			accel = new Point();
			vel = new Point();
			setHitbox(28, 55, -13, 2); //Hitbox is set to actual player sprite size. Is offset to behave realistically.
			x = 50; //The X and Y the player is created at.
			y = 520;
			//("animation name", [frames], duration);
			animatedSprite.add("runningLeft", [0, 1, 2, 3, 4, 5, 6, 7], 25);
			animatedSprite.add("runningRight", [8, 9, 10, 11, 12, 13, 14, 15], 25);
			animatedSprite.add("standingRight", [16], 50);
			animatedSprite.add("standingLeft", [17], 50);
		}

		override public function update():void
		{
			var i:int;

			// Checking player input.
			if(Input.check(Key.LEFT) || Input.check(Key.A)) {accel.x = -PLAYER_HACCEL; animatedSprite.play("runningLeft"); } // MOVE LEFT
			else if (Input.check(Key.RIGHT) || Input.check(Key.D)) {
				 animatedSprite.play("runningRight");
				accel.x = PLAYER_HACCEL; // MOVE RIGHT
				if (x >= 800 && !exit) {
					exit = true;
					if (y < 300) {
						trace("PLAYER TOOK DIFFICULT PATH");
					} else {
						trace("PLAYER TOOK EASY PATH");
					}
				}
			}
			else {	// IF THEY ARE NOT MOVING LEFT OR RIGHT, FACTOR IN DRAG.
				if (vel.x > 0) { //If the velocity is greater than zero, set the acceleration to drag.
					animatedSprite.play("standingRight");
					accel.x = DRAG;	//		Then, if this ends up with a negative/zero velocity, set it to zero so we don't
					if ((vel.x + accel.x) <= 0) { vel.x = 0; accel.x = 0; } ;//	end up with oscillation.
				}
				if (vel.x < 0) { //Same as above but opposite.
					animatedSprite.play("standingLeft");
					accel.x = -DRAG;
					if ((vel.x + accel.x) >= 0) { vel.x = 0; accel.x = 0; } ;
				}
			}

			// Check to see that the velocity & accel are below max speed. If so, go ahead and add the accel.
			//		If not, it leaves the velocity as is.
			if ( vel.x + accel.x < PLAYER_HSPEED_MAX && vel.x + accel.x > -PLAYER_HSPEED_MAX){
				vel.x += accel.x;
			}
			
			//Are you hitting a wall? Yes? Ok, your velocity is now zero, and if you pressed jump, you can jump.
            if (collide("wall",x,y+1)) {
                vel.y=0;
                if (Input.pressed(Key.SPACE) || Input.pressed(Key.UP) || Input.pressed(Key.W)) { accel.y = PLAYER_JUMP; }
				else { accel.y = 0; }
			//You're not hitting a wall? FALL!
            } else { accel.y=GRAVITY; }
			
			vel.y += accel.y;
			
			// For every bit of x velocity, make sure that moving there won't cause the player to clip.
			//	If it doesn't, go ahead and set the player's x to that.
			//	If it does, set player velocity to 0 so they stop trying to clip.
            for (i = 0; i<Math.abs(vel.x); i++) {
                if (! collide("wall",x+FP.sign(vel.x),y)) {
                    x += FP.sign(vel.x);
                } else {
					//Forces the player to stand still if they are colliding with a wall.
					//Otherwise player would keep walking even if they're stuck clipping.
					if (vel.x > 0) {
						animatedSprite.play("standingRight");
					} else { 
						animatedSprite.play("standingLeft");
					}
                    vel.x=0;
                    break;
                }
            }
            
			// Same as above.
			for (i = 0; i<Math.abs(vel.y); i++) {
                if (! collide("wall",x,y+FP.sign(vel.y))) {
                    y += FP.sign(vel.y);
                } else {
                    vel.y = 0
                    break;
                }
            }

			// Simple collision with boundary--if player is below the edge of the screen, make their velocity to zero
			//		and push them above it.
			if(y + height > FP.screen.height)
			{
				vel.y = 0;
				y = FP.screen.height - height;
			}

			// Update parent shit.
			super.update();
		}
		
	}

}