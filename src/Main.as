package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;

	public class Main extends Engine
	{
		public function Main()
		{
			var request:URLRequest = new URLRequest("../assets/maps/test.txt");
			var loader:URLLoader = new URLLoader(); 
			var mapinfo:Array = [];
			loader.addEventListener(Event.COMPLETE, onLoaded);
			
			//This is basically a metric shitton of string splitting to isolate the wanted values.
			//Most of this is actually useless--I couldn't figure out how to handle tilesets, so instead I
			//		am having WallEntity figure out its own image. tilesets_mapdata is the relevant part.
			//I can't figure out how to make the game window size change according to what it read (because super()
			//		is called before onLoaded), so mapwidth, mapheight, tilewidth, and tileheight are MOSTLY useless.
			//		That being said, DO NOT REMOVE MAPWIDTH AND MAPHEIGHT. tilewidth and tileheight should be
			//		safe to remove if you really want.
			//Layer_data is the important part, basically.
			
			//This may be more useful later. When we implement phone menu, we can start testing certain buttons
			//		causing the loading of different map files rather than always loading test.txt.
			function onLoaded(e:Event):void {
				var mapdata:String = e.target.data;
				var split_mapdata:Array = mapdata.split("[");
				var header_mapdata:String = split_mapdata[1].split("]")[1];
				var tilesets_mapdata:String = split_mapdata[2].split("]")[1];
				var layer_mapdata:String = split_mapdata[3].split("]")[1];
				
				var split_header:Array = header_mapdata.split("=");
				var map_width:int = split_header[1].split("\n")[0];
				var map_height:int = split_header[2].split("\n")[0];
				var tile_width:int = split_header[3].split("\n")[0];
				var tile_height:int = split_header[4].split("\n")[0];
				
				var split_tilesets:Array = tilesets_mapdata.split("=");
				var resplit_tilesets:Array = split_tilesets[1].split(",");
				var tileset_url:String = resplit_tilesets[0];
				
				var split_layer:Array = layer_mapdata.split("=");
				var layer_data:Array = split_layer[2].split(",");
				for (var i:int = 0; i < map_height * map_width - 1; i++) {
					layer_data[i] = layer_data[i].replace(/[\u000d\u000a\u0008\u0020]+/g, "");
					//Getting rid of newlines.
				}
				
				//Splits layer_data into a two-dimensional array, for ease of use.
				var new_layerdata:Array = [];
				for (var i:int = 0; i < map_height; i++) {
					new_layerdata[i] = [];
					for (var j:int = 0; j < map_width; j ++) {
						new_layerdata[i][j] = layer_data[50 * i + j];
					}
				}
				var all_data:Array = [map_width, map_height, tile_width, tile_height, tileset_url, new_layerdata];
				FP.world = new PlatformerWorld(all_data);
			}
			//Changed to 592 because 600 has 8 pixels too much. This doesn't seem to have fixed anything, however.
			//Will need to figure out how to fix that later.
			super(800, 592, 60, false);
			
			//This actually causes the load, which when done calls the above weird-ass function.
			loader.load(request); 
		}

		override public function init():void
		{
			trace("FlashPunk has started successfully!");
		}
	}
}