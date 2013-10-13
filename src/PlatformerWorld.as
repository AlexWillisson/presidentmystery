package  
{
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class PlatformerWorld extends World 
	{
		private const READ:uint = 0xffffff;
		private const UNREAD:uint = 0xf7941e;

		private var phone:Phone;
		private var phoneOpen:Boolean;
		private var msg0:Message, msg1:Message, msg2:Message, msg3:Message, msg4:Message, msg5:Message, msg6:Message, msg7:Message, msg8:Message, msg9:Message, title:Message;

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
			title = new Message(290, 120, "Messages", 36, READ);

			msg0 = new Message(300, 170, "VP", 22, UNREAD);
			msg1 = new Message(455, 175, "8:38p", 12, UNREAD);

			msg2 = new Message(300, 200, "Speaker", 22, READ);
			msg3 = new Message(455, 205, "4:32p", 12, READ);

			msg4 = new Message(300, 230, "Mayor", 22, READ);
			msg5 = new Message(455, 235, "2:33p", 12, READ);

			msg6 = new Message(300, 260, "Police", 22, READ);
			msg7 = new Message(455, 265, "Tues", 12, READ);

			msg8 = new Message(300, 290, "Doctor", 22, READ);
			msg9 = new Message(455, 295, "Tues", 12, READ);

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
			add(msg0);
			add(msg1);
			add(msg2);
			add(msg3);
			add(msg4);
			add(msg5);
			add(msg6);
			add(msg7);
			add(msg8);
			add(msg9);
			add(title);
			phoneOpen = true;
		}

		private function closePhone():void
		{
			remove(phone);
			remove(msg0);
			remove(msg1);
			remove(msg2);
			remove(msg3);
			remove(msg4);
			remove(msg5);
			remove(msg6);
			remove(msg7);
			remove(msg8);
			remove(msg9);
			remove(title);
			phoneOpen = false;
		}
	}
}
