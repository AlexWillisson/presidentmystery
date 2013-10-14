package  
{
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class PlatformerWorld extends World 
	{
		private var phone:Phone;
		private var level1:Level;

		public function PlatformerWorld(mapData:Array) 
		{
			phone = new Phone();
			level1 = new Level(mapData);

			// startLevel();
			openPhone();
		}
		
		override public function update():void
		{
			if (Input.released(Key.M)) {
				if (phone.world) {
					closePhone();
					startLevel();
				} else {
					endLevel();
					openPhone();
				}
			}

			super.update()
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
