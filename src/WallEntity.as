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
        public function WallEntity(posX:int,posY:int) {
            graphic=new Image(WALL);
            setHitbox(16,16);
            type="wall"; 
            x=posX*16;
            y=posY*16;
        }
    }

}