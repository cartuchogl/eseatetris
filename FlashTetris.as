/*
This file is part of EseaTetris.

EseaTetris is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

EseaTetris is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with EseaTetris.  If not, see <http://www.gnu.org/licenses/>.
*/
package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Keyboard;

	public class FlashTetris extends Sprite {
		private var gameZone:GameZone;
		private var board:Board;
		private var current:Block;
		private var posx:int = 0;
		private var posy:int = 0;
		private var counter:int = 0;
		
		private var gameOver:TextField;
		private var retry:TextField;
		
		public function FlashTetris() {
			gameZone = new GameZone();
			gameZone.x = 10;
			addChild(gameZone);
			board = new Board();
			board.x = 120;
			addChild(board);
			init();
		}
		
		private function loose():void {
			removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			
			gameOver = new TextField();
			gameOver.text = "GAME OVER";
			gameOver.x = (110-gameOver.textWidth)/2;
			gameOver.y = (200-gameOver.textHeight)/2;
			gameOver.background = true;
			gameOver.border = true;
			gameOver.autoSize = TextFieldAutoSize.LEFT;
			addChild(gameOver);
			
			retry = new TextField();
			retry.text = "Retry";
			retry.x = (110-retry.textWidth)/2;
			retry.y = gameOver.y+gameOver.height;
			retry.background = true;
			retry.border = true;
			retry.autoSize = TextFieldAutoSize.LEFT;
			retry.addEventListener(MouseEvent.MOUSE_DOWN,function(event:Event):void {
				removeChild(gameOver);
				removeChild(retry);
				board.reset();
				gameZone.reset();
				init();
			});
			addChild(retry);
		}
		
		private function onEnterFrame(evt:Event):void {
			if(current == null) {
				current = board.nextPiece;
				posx = (10-current.map.length)/2;
				posy = 0;
				board.nextPiece = Block.randomPiece();
				addChild(current);
				if(!canPos(current.map,posx,posy)) {
					loose();
				}
			}
			counter+=board.level;
			if(counter>(10)) {
				counter = 0;
				if(canPos(current.map,posx,posy+1)) {
					posy += 1;
				} else {
					var lines:uint = gameZone.imprintPiece(current,posx,posy);
					board.lines += lines;
					board.score += lines*lines*10;
					removeChild(current);
					current = null;
				}
			}
			if(current!=null) {
				current.x = posx*10+10;
				current.y = posy*10;
			}
		}
		
		private function onKeyDown(event:KeyboardEvent):void {
			if(current!=null) {
				switch (event.keyCode) {
					case Keyboard.UP:
						if(canPos(current.tryTurnRight(),posx,posy)) {
							current.turnRight();
							current.draw();
						}
						break;
					case Keyboard.DOWN:
						counter += 20;
						break;
					case Keyboard.LEFT:
						if(canPos(current.map,posx-1,posy)) {
							posx -= 1;
						}
						break;
					case Keyboard.RIGHT:
						if(canPos(current.map,posx+1,posy)) {
							posx += 1;
						}
						break;
				}
			}
		}
		
		private function init():void {
			board.nextPiece = Block.randomPiece();
			
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		private function canPos(map:Array,x:int,y:int):Boolean {
			for(var i:int=0;i<map.length;i++) {
				for(var j:int=0;j<map[i].length;j++) {
					if(map[i][j]!=0) {
						if(!(gameZone.boxes[x+i]&&gameZone.boxes[x+i][y+j]==0)) {
							return false;
						}
					}
				}
			}
			return true;
		}
	}
}
