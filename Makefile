FLEX_SDK = ~/flex_sdk_3
MXML = $(FLEX_SDK)/bin/mxmlc
OUTPUT_PATH = bin
FPS = -default-frame-rate 10 
SIZE = -default-size 180 200
DO_MXML = $(MXML) $< -output $@

OBJS = $(OUTPUT_PATH)/esea_tetris.swf

all : $(OBJS)

$(OUTPUT_PATH)/esea_tetris.swf : FlashTetris.as Board.as Counter.as GameZone.as Block.as
	$(DO_MXML) $(FPS) $(SIZE)

clean :
	rm $(OBJS)
