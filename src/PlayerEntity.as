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
		
		//Embed Sprite, Set Sprite Map Width, Create Sprite Map, and set Current Animation
		public const SPRITE_WIDTH:Number = 60;
		public const SPRITE_HEIGHT:Number = 59;
		[Embed(source="../assets/images/SpritePres.png")] private const PRESIDENT:Class;
		public var sprPresident:Spritemap = new Spritemap(PRESIDENT, SPRITE_WIDTH, SPRITE_HEIGHT);
		public var curAnim:String = "standRight";
		
		//Helper Function to Add Sprite Animations
		public function setUpSpriteSheet():void {
			sprPresident.add("standLeft", [17], 20, true);
			sprPresident.add("standRight", [16], 20, true);
			
			sprPresident.add("runLeft", [7, 6, 5, 4, 3, 2, 1, 0], 20, true);
			sprPresident.add("runRight", [8, 9, 10, 11, 12, 13, 14, 15], 20, true);
			
			sprPresident.add("jumpLeft", [4, 3, 2], 20, false);
			sprPresident.add("jumpRight", [8, 9, 10], 20, false);	
		}
		
		//These are points that can store x and y values, accessed by v.x v.y, etc.
		//There are just kind of a fancy way of storing velocity and acceleration.
		protected var accel:Point; //Acceleration
		protected var vel:Point; //Velocity
		
		private var exit:Boolean = false;
		
		[Embed(source="../assets/images/player.png")] private const PLAYER_SPRITE:Class;
		
		public function PlayerEntity() 
		{
			//Instantializes a lot of stuff, i.e. accel and hitbox.
			//Add Animations and Initiate Graphic in Standing Animation
			setUpSpriteSheet();
			graphic = sprPresident;
			sprPresident.play(curAnim);
			accel = new Point();
			vel = new Point();
			setHitbox(9, 60); //NOTE: THIS HAS TO BE UPDATED WITH THE SPRITE!!! THIS IS SET TO PRESIDENT (without transpaency)!
			x = 16; //The X and Y the player is created at. Made to be 16/16 so that samus doesn't clip with the
			y = 16; //		walls upon spawning.
			
			
			//Define Input Labels
			Input.define("Jump", Key.UP, Key.SPACE, Key.W);
			Input.define("Left", Key.LEFT, Key.A);
			Input.define("Right", Key.RIGHT, Key.D);
			Input.define("Lift", Key.DOWN);
		}

		override public function update():void
		{
			sprPresident.play(curAnim);
			var i:int;
			
			var horizontalMovement:Boolean = true;
			var verticalMovement:Boolean = true;

			// Checking player input.
			if (Input.check("Left")) {
				curAnim = "runLeft";
				accel.x = -PLAYER_HACCEL;
			} // MOVE LEFT
			else if (Input.check("Right")) {
				curAnim = "runRight";
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
				if(vel.x > 0) { //If the velocity is greater than zero, set the acceleration to drag.
					accel.x = DRAG;	//		Then, if this ends up with a negative/zero velocity, set it to zero so we don't end up with oscillation.
					if ((vel.x + accel.x) <= 0) { 
						vel.x = 0;
						accel.x = 0; 
					}
				}
				if (vel.x < 0) { //Same as above but opposite.
					accel.x = -DRAG;
					if ((vel.x + accel.x) >= 0) { 
						vel.x = 0; 
						accel.x = 0; 
					} ;
				}
				horizontalMovement = false;
			}

			// Check to see that the velocity & accel are below max speed. If so, go ahead and add the accel.
			//		If not, it leaves the velocity as is.
			if ( vel.x + accel.x < PLAYER_HSPEED_MAX && vel.x + accel.x > -PLAYER_HSPEED_MAX){
				vel.x += accel.x;
			}
			
			//Are you hitting a wall? Yes? Ok, your velocity is now zero, and if you pressed jump, you can jump.
            if (collide("wall",x,y+1)) {
                vel.y=0;
                if (Input.pressed("Jump")) { 
					accel.y = PLAYER_JUMP;
				}
				else { accel.y = 0; verticalMovement = false;}
			//You're not hitting a wall? FALL!
            } else { accel.y=GRAVITY; }
			
			vel.y += accel.y;
			
			// For every bit of x velocity, make sure that moving there won't cause the player to clip.
			//	If it doesn't, go ahead and set the player's x to that.
			//	If it does, set player velocity to 0 so they stop trying to clip.
            for (i = 0; i<Math.abs(vel.x); i++) {
                if (! collide("wall",x+FP.sign(vel.x),y)) {
                    x += FP.sign(vel.x);
                }
				else {
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
			
			//Skeleton Code for Possible Lifting
			if (Input.check("Lift")) {
				trace("bro, do you even lift?");
			}
			
			//If Vertical Movement, Do the Appropriate Jump (Given any horizontal movement)
			if (verticalMovement) {
				switch(curAnim) {
					case "standRight": curAnim = "jumpRight"; break;
					case "standLeft": curAnim = "jumpLeft"; break;
					case "runLeft": curAnim = "jumpLeft"; break;
					case "runRight": curAnim = "jumpRight"; break;
				}
			}
			
			//If no horizontal or vertical movement, set player to standing.
			if (!horizontalMovement && !verticalMovement) {
				switch(curAnim) {
					case "runLeft": curAnim = "standLeft"; break;
					case "runRight": curAnim = "standRight"; break;
					case "jumpLeft": curAnim = "standLeft"; break;
					case "jumpRight": curAnim = "standRight"; break;
				}
			}
			
			// Update parent shit.
			super.update();
		}
		
	}

}