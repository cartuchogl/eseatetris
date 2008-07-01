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
	
	public class Block extends Sprite {
		public var map:Array;
		
		private static function _dotArray(ary:Array,val:uint):Array {
			for(var i:int=0;i<ary.length;i++) {
				for(var j:int=0;j<ary[i].length;j++) {
					ary[i][j] *= val;
				}
			}
			return ary;
		}
		
		public static function randomPiece():Block {
			return newPiece(Math.floor(Math.random()*7));
		}
		
		public static function newPiece(type:uint):Block {
			switch(type) {
				case 0:
					return new Block(_dotArray(new Array(
						new Array(0,1,0),
						new Array(0,1,0),
						new Array(0,1,0),
						new Array(0,1,0)),
						0x00ffff));
				case 1:
					return new Block(_dotArray(new Array(
						new Array(1,0,0),
						new Array(1,1,1),
						new Array(0,0,0)),
						0xff8800));
				case 2:
					return new Block(_dotArray(new Array(
						new Array(0,0,0),
						new Array(1,1,1),
						new Array(1,0,0)),
						0x0000ff));
				case 3:
					return new Block(_dotArray(new Array(
						new Array(1,1),
						new Array(1,1)),
						0xffff00));
				case 4:
					return new Block(_dotArray(new Array(
						new Array(1,1,0),
						new Array(0,1,1)),
						0x00ff00));
				case 5:
					return new Block(_dotArray(new Array(
						new Array(0,1,1),
						new Array(1,1,0)),
						0xff0000));
				case 6:
				default:
					return new Block(_dotArray(new Array(
						new Array(0,1,0),
						new Array(1,1,1),
						new Array(0,0,0)),
						0x8800ff));
			}
		}
		public function Block(map:Array) {
			this.map = map;
		}
		
		public function draw():void {
			graphics.clear();
			for(var i:int=0;i<map.length;i++) {
				for(var j:int=0;j<map[i].length;j++) {
					if(map[i][j]!=0) {
						graphics.lineStyle(1,0xffffff);
						graphics.beginFill(map[i][j]);
						graphics.drawRect(i*10, j*10, 10, 10);
						graphics.endFill();
					}
				}
			}
		}
		
		public function tryTurnRight():Array {
			var res1:uint = map.length;
			var res2:uint = map[0].length;
			
			var retval:Array = new Array(res2);
			for(var i:uint=0;i<res2;i++) {
				retval[i] = new Array(res1);
				for(var j:uint=0;j<res1;j++) {
					retval[i][j] = map[j][res2-1-i];
				}
			}
			return retval;
		}
		
		public function turnRight():void {
			map = tryTurnRight();
		}
	}
}