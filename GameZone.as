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
	
	public class GameZone extends Sprite {
		private var bgColor:uint = 0x000000;
		private var sizex:uint   = 100;
		private var sizey:uint   = 200;
		
		public var boxes:Array = new Array(10);
		
		public function GameZone() {
			reset();
		}
		
		public function reset():void {
			for(var i:int=0;i<10;i++) {
				boxes[i] = new Array(20);
				for(var j:int=0;j<20;j++) {
					boxes[i][j] = 0;
				}
			}
			draw();
		}
		
		public function imprintPiece(piece:Block,x:int,y:int):uint {
			for(var i:int=0;i<piece.map.length;i++) {
				for(var j:int=0;j<piece.map[i].length;j++) {
					if(piece.map[i][j]!=0) { // solid
						if(!(boxes[x+i]&&boxes[x+i][y+j])) {
							boxes[x+i][y+j] = piece.map[i][j];
						}
					}
				}
			}
			var lines:uint = 0;
			while(removeLines()) {
				lines++;
			}
			draw();
			return lines;
		}
		
		private function draw():void {
			graphics.clear();
			graphics.beginFill(0);
			graphics.drawRect(0,0,100,200);
			for(var i:int=0;i<10;i++) {
				for(var j:int=0;j<20;j++) {
					if(boxes[i][j]!=0) {
						graphics.lineStyle(1,0xffffff,0.5);
						graphics.beginFill(boxes[i][j]);
						graphics.drawRect(i*10, j*10, 10, 10);
						graphics.endFill();
					} else {
						graphics.lineStyle(0);
					}
				}
			}
		}
		
		private function removeLines():Boolean {
			for(var i:int=0;i<20;i++) {
				var count:uint = 0;
				for(var j:int=0;j<10;j++) {
					if(boxes[j][i]!=0) {
						count++;
					}
				}
				if(count>=10) {
					for(;i>0;i--) {
						for(j=0;j<10;j++) {
							boxes[j][i]=boxes[j][i-1];
						}
					}
					return true;
				}
				
			}
			return false;
		}
	}
}