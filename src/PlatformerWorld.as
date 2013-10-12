package  
{
	import net.flashpunk.World;
	public class PlatformerWorld extends World 
	{
		
		public function PlatformerWorld() 
		{
			add(new PlayerEntity());
            for (var i:int=0; i<20; i++) {
                add(new WallEntity(i,0));
                add(new WallEntity(i,14));
            }
            for (i=0; i<14; i++) {
                add(new WallEntity(0,i));
                add(new WallEntity(19,i));
            }
            for (i=1; i<5; i++) {
                add(new WallEntity(5-i,14-i));
                add(new WallEntity(8+i,5+i));
                add(new WallEntity(2+i,10-i));
                add(new WallEntity(13+i,8-i));
            }
		}
		
	}

}