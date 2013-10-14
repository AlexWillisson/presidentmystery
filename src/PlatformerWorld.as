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

		public function PlatformerWorld(mapData:Array) 
		{
			levels = new Array();
			levels[0] = new Level(mapData);
			splash = new Splash();
			intro = new Intro(loadPhone);

			phone = new Phone(levels);

			// add(splash);

			add(intro);

			// add(level1);
			// add(phone);
		}
		
		private function loadPhone():void
		{
			remove(intro);
			add(phone);
		}

		override public function update():void
		{
			if (Input.released(Key.M)) {
				if (levels[0].world) {
					remove(levels[0]);
					add(phone);
				} else {
					remove(phone);
					add(levels[0]);
				}
			}

			super.update()
		}
	}
}
