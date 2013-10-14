package  
{
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class PlatformerWorld extends World 
	{
		private var phone:Phone;
		private var level1:Level;
		private var splash:Splash;
		private var intro:Intro;

		public function PlatformerWorld(mapData:Array) 
		{
			phone = new Phone();
			level1 = new Level(mapData);
			splash = new Splash();
			intro = new Intro(loadPhone);

			// welcome();

			startGame();

			// startLevel();
			// openPhone();
		}
		
		private function loadPhone():void
		{
			remove(intro);
			add(phone);
		}

		override public function update():void
		{
			if (Input.released(Key.M)) {
				if (level1.world) {
					endLevel();
					openPhone();
				} else {
					closePhone();
					startLevel();
				}
			}

			super.update()
		}

		private function startGame():void
		{
			add(intro);
		}

		private function welcome():void
		{
			add(splash);
		}

		private function openPhone():void
		{
			add(phone);
		}

		private function closePhone():void
		{
			remove(phone);
		}

		private function startLevel():void
		{
			add(level1);
		}

		private function endLevel():void
		{
			remove(level1)
		}
	}
}
