--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--  Löve imgDataTest

LO   = love
-- 3 letter abbrev's
aud  = LO .audio
eve  = LO .event
fil  = LO .filesystem
fon  = LO .font
gra  = LO .graphics
ima  = LO .image
joy  = LO .joystick
key  = LO .keyboard
mat  = LO .math
mou  = LO .mouse
phy  = LO .physics
sou  = LO .sound
sys  = LO .system
thr  = LO .thread
tim  = LO .timer
tou  = LO .touch
vid  = LO .video
win  = LO .window

HH  = gra .getHeight()
WW  = gra .getWidth()

local row  = 10
local col  = 10

local fontsize  = 28
local expected  = gra .newImage( 'expected.png' )
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function LO .load()
  print('Löve App begin')
  gra .setBackgroundColor( 127, 127, 127 )
  gra .setDefaultFilter( 'nearest',  'nearest',  0 )
  font  = gra .newFont( fontsize )
	gra .setFont( font )

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Method 1:  Use values 0 to F

  local data = ''

  for i  = 1,  row * col do
    if i > 80 then
      data  = data .. '000F'
    elseif i > 60 then
      data  = data .. '00FF'
    elseif i > 40 then
      data  = data .. '0F0F'
    elseif i > 20 then
      data  = data .. 'F00F'
    else
      data  = data .. 'FFFF'
    end
  end

  local imgData1  = ima .newImageData( row,  col,  data )
  method1  = gra .newImage( imgData1 )

  print( '1  "' .. imgData1 :getString( ) .. '"' )

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Method 2:  use values 32 to 126.  'space' = ASCII 32,  and 'tilde' = ASCII 126
-- We could use 01 "" to 7F ""  ...but they don't print well as console output.
-- It seems, if this were the intended method of input, 'ÿ' ASCII 255 would be acceptable.

  local data = ''

  for i  = 1,  row * col do
    if i > 80 then
      data  = data .. '   ~'
    elseif i > 60 then
      data  = data .. '  ~~'
    elseif i > 40 then
      data  = data .. ' ~ ~'
    elseif i > 20 then
      data  = data .. '~  ~'
    else
      data  = data .. '~~~~'
    end
  end

  local imgData2  = ima .newImageData( row,  col,  data )
  method2  = gra .newImage( imgData2 )

  print( '2  "' .. imgData2 :getString( ) .. '"' )

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Method 3:   use blank data to begin with, then :setPixel()

  local imgData3  = ima .newImageData( row,  col )

  for i  = 1,  row * col do
    if i >= 80 then
      imgData3 :setPixel( row -1,  col -1,  0,  0,  0,  255 )
    elseif i >= 60 then
      imgData3 :setPixel( row -1,  col -1,  0,  0,  255,  255 )
    elseif i >= 40 then
      imgData3 :setPixel( row -1,  col -1,  0,  255,  0,  255 )
    elseif i >= 20 then
      imgData3 :setPixel( row -1,  col -1,  255,  0,  0,  255 )
    else
      imgData3 :setPixel( row -1,  col -1,  255,  255,  255,  255 )
    end
  end

  method3  = gra .newImage( imgData3 )

  print( '3  "' .. imgData3 :getString( ) .. '"' )

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Method 4,  or methods 2 & 3 combined:

  local data = ''

  for i  = 1,  row * col do            -- populate the data table,  as in Method 2
    data  = data .. '~~~~'
  end

  local imgData4  = ima .newImageData( row,  col,  data )

  for i  = 1,  row * col do            -- then setPixel()  as in Method 3
    if i > 80 then
      imgData4 :setPixel( row -1,  col -1,  0,  0,  0 )
    elseif i > 60 then
      imgData4 :setPixel( row -1,  col -1,  0,  0,  255 )
    elseif i > 40 then
      imgData4 :setPixel( row -1,  col -1,  0,  255,  0 )
    elseif i > 20 then
      imgData4 :setPixel( row -1,  col -1,  255,  0,  0 )
    else
      imgData4 :setPixel( row -1,  col -1,  255,  255,  255 )
    end
  end

  method4  = gra .newImage( imgData4 )

  print( '4  "' .. imgData4 :getString( ) .. '"' )
end

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function LO .draw()
  gra .setColor( 255, 255, 255 )
  gra .draw( expected,  60,  100 )

  gra .draw( method1,  160,  100,  0,  10,  10 )
  gra .draw( method2,  260,  100,  0,  10,  10 )
  gra .draw( method3,  360,  100,  0,  10,  10 )
  gra .draw( method4,  460,  100,  0,  10,  10 )

  gra .setColor( 100, 0, 0 )
  gra .line( 160,  80,  160,  230 )
  gra .line( 260,  80,  260,  230 )
  gra .line( 360,  80,  360,  230 )
  gra .line( 460,  80,  460,  230 )

  gra .print( 'Expected',  120,  250,  math .pi *.35 )
  gra .setColor( 0, 0, 0 )
  gra .print( 'imported PNG',  90,  270,  math .pi *.35, .6, .6 )

  gra .setColor( 100, 0, 0 )
  gra .print( 'Method 1',  220,  250,  math .pi *.35 )
  gra .setColor( 0, 0, 0 )
  gra .print( 'Values 0 to F',  190,  270,  math .pi *.35, .6, .6 )

  gra .setColor( 100, 0, 0 )
  gra .print( 'Method 2',  320,  250,  math .pi *.35 )
  gra .setColor( 0, 0, 0 )
  gra .print( 'ASCII values 32 to 126',  290,  270,  math .pi *.35, .6, .6 )

  gra .setColor( 100, 0, 0 )
  gra .print( 'Method 3',  420,  250,  math .pi *.35 )
  gra .setColor( 0, 0, 0 )
  gra .print( ':setPixel()',  390,  270,  math .pi *.35, .6, .6 )

  gra .setColor( 100, 0, 0 )
  gra .print( 'Methods 2 & 3',  520,  250,  math .pi *.35 )
  gra .setColor( 0, 0, 0 )
  gra .print( 'fill, then :setPixel()',  490,  270,  math .pi *.35, .6, .6 )
end

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function LO .quit()
  print('Löve App exit')
end

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
