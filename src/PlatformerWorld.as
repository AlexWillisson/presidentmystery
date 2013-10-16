package  
{
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class PlatformerWorld extends World 
	{
		private var phone:Phone;
		private var levels:Array;
		private var splash:Splash;
		private var intro:Intro;

		public function PlatformerWorld(mapData:Array,xStart:int,yStart:int) 
		{
			levels = new Array();
			levels[0] = new Level(mapData,xStart,yStart);
			splash = new Splash();
			intro = new Intro(loadPhone);

			phone = new Phone(levels);

			// add(splash);

			add(intro);
			//add(levels[0]); // DEBUG PURPOSES ONLY

			// add(level1);
			// add(phone);
		}
		
		private function loadPhone():void
		{
			remove(intro);
			add(phone);
		}
	}
}
