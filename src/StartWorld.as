package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import flash.events.*;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Image
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	

	public class StartWorld extends World
	{
		protected var num_maps:int = 2;
		[Embed(source = "../assets/images/credits_button.png")] private const CREDITS_BUTTON:Class;
		[Embed(source = "../assets/images/start_button.png")] private const START_BUTTON:Class;
		[Embed(source = "../assets/images/splash.png")] private const SPLASH:Class;
		[Embed(source = "../assets/images/start_title.png")] private const START_TITLE:Class;
		
		private var _playbutton:Button;
		private var _creditsbutton:Button;
		
		public function StartWorld() 
		{
			addGraphic(new Image(SPLASH));
			addGraphic(new Image(START_TITLE), 0, FP.width / 3 - 15, 20);
			_playbutton = new Button(preStartGame,FP.width/2,FP.height - 50,120,20);
			_playbutton.addGraphic(new Image(START_BUTTON));
			_creditsbutton = new Button(showCredits, FP.width / 2 - 120, FP.height - 50, 100, 20);
			_creditsbutton.addGraphic(new Image(CREDITS_BUTTON));
			add(_creditsbutton);
			add(_playbutton);
		}
		
		public function showCredits():void {
			FP.world = new CreditsWorld();
		}
		
        public function preStartGame():void {
				//Generates a random number to choose which map to load. Will have to be changed to include new maps.
				var whichGameInt:int = Math.round(Math.random() * 1000);
				switch(whichGameInt % 3) {
					case 0:
						startGame("../assets/maps/Hard Level.txt",320,500);
						break;
					case 1:
						startGame("../assets/maps/test.txt",52,500);
						break;
					case 2:
						startGame("../assets/maps/test2.txt",52,500);
						break;
				}
        }
		
		public function startGame(mapURL:String,xStart:int,yStart:int):void 
		{
			var request:URLRequest = new URLRequest(mapURL);
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
				var i:int;

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
				for (i = 0; i < map_height * map_width - 1; i++) {
					layer_data[i] = layer_data[i].replace(/[\u000d\u000a\u0008\u0020]+/g, "");
					//Getting rid of newlines.
				}
				
				//Splits layer_data into a two-dimensional array, for ease of use.
				var new_layerdata:Array = [];
				for (i = 0; i < map_height; i++) {
					new_layerdata[i] = [];
					for (var j:int = 0; j < map_width; j ++) {
						new_layerdata[i][j] = layer_data[50 * i + j];
					}
				}
				var all_data:Array = [map_width, map_height, tile_width, tile_height, tileset_url, new_layerdata];
				FP.world = new PlatformerWorld(all_data,xStart,yStart);
			}
			//This actually causes the load, which when done calls the above weird-ass function.
			loader.load(request); 
		}
	}
}