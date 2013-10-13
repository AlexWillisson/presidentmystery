package  
{
	import net.flashpunk.World;
	
	public class PlatformerWorld extends World 
	{
		
		public function PlatformerWorld(mapData:Array) 
		{
			add(new PlayerEntity());
			
			//It is given mapdata, and for every row and column it goes through and creates a Wall Entity.
			// 1 is a placeholder for "there is actually a tile here, yes.
			// It is an artifact of using the metroid tileset, and when we make our own we can set it to 0.
			//mapData[5] refers to new_layerdata, from Main.as. This stores what every room actually is--wall or what.
			//mapData[0] refers to map_width.
			//mapData[1] refers to map_height.
			//if you know how to set global constants, please let me know and I can update this to use the constants
			//		rather than explaining it in comments.
			for ( var i:int = 0; i < mapData[1]; i ++) {
				for ( var j:int = 0; j < mapData[0]; j ++) {
					if (mapData[5][i][j] > 1) {
						add(new WallEntity(j, i, mapData[5][i][j]));
					}
					
				}
			}
		}
		
	}

}