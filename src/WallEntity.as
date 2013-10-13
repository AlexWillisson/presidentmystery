package  
{
	/**
	 * ...
	 * @author ...
	 */
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
    public class WallEntity extends Entity {
        [Embed(source = "../assets/images/wall.png")] private const WALL:Class;
        public function WallEntity(posX:int, posY:int, value:int) {
			//I didn't want to code too much dependency on the matroid tileset, so I only did one case so far.
			//This can be updated once we have our new tileset to set the right image depending on what it is.
			switch (value) {
				case 13:
					graphic = new Image(WALL);
					break;
				default:
					graphic = new Image(WALL);
					break;
					
			}
            setHitbox(16,16);
            type="wall"; 
            x=posX*16;
            y=posY*16;
        }
    }

}