package  
{
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class PlatformerWorld extends World 
	{
		private var phone:Phone;
		private var phoneOpen:Boolean;
		private var msg0:Message, msg1:Message, msg2:Message, msg3:Message, msg4:Message, title:TextEntity;

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

			phone = new Phone();
			title = new TextEntity(290, 120, "Inbox", 36, 0xffffff);

			phoneOpen = false;
		}
		
		override public function update():void
		{
			if (Input.released(Key.M)) {
				if (phoneOpen) {
					closePhone();
				} else {
					openPhone();
				}
			}

			super.update()
		}

		private function openPhone():void
		{
			add(phone);
			// add(msg0);
			// add(msg1);
			// add(msg2);
			// add(msg3);
			// add(msg4);
			// add(msg5);
			// add(msg6);
			// add(msg7);
			// add(msg8);
			// add(msg9);
			// add(btn0);
			// add(btn1);
			// add(btn2);
			// add(btn3);
			// add(btn4);
			add(title);
			phoneOpen = true;
		}

		private function closePhone():void
		{
			remove(phone);
			// remove(msg0);
			// remove(msg1);
			// remove(msg2);
			// remove(msg3);
			// remove(msg4);
			// remove(msg5);
			// remove(msg6);
			// remove(msg7);
			// remove(msg8);
			// remove(msg9);
			// remove(btn0);
			// remove(btn1);
			// remove(btn2);
			// remove(btn3);
			// remove(btn4);
			remove(title);
			phoneOpen = false;
		}

	}
}
