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
-- Method 3:  use values 0 to 127 ""

  local data = ''

  for i  = 1,  row * col do
    if i > 80 then
      data  = data .. '000'
    elseif i > 60 then
      data  = data .. '00'
    elseif i > 40 then
      data  = data .. '00'
    elseif i > 20 then
      data  = data .. '00'
    else
      data  = data .. ''
    end
  end

  local imgData3  = ima .newImageData( row,  col,  data )
  method3  = gra .newImage( imgData3 )

  print( '3  "' .. imgData3 :getString( ) .. '"' )
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Method 4:   use blank data to begin with, then :setPixel()

  local imgData4  = ima .newImageData( row,  col )

  i = 1
  for y  = 0,  row -1 do
    for x = 0,  col -1 do
      if i >= 80 then
        imgData4 :setPixel( x,  y,  0,  0,  0,  255 )
      elseif i >= 60 then
        imgData4 :setPixel( x,  y,  0,  0,  255,  255 )
      elseif i >= 40 then
        imgData4 :setPixel( x,  y,  0,  255,  0,  255 )
      elseif i >= 20 then
        imgData4 :setPixel( x,  y,  255,  0,  0,  255 )
      else
        imgData4 :setPixel( x,  y,  255,  255,  255,  255 )
      end
      i  = i + 1
    end
  end

  method4  = gra .newImage( imgData4 )

  print( '4  "' .. imgData4 :getString( ) .. '"' )

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Method 5,  or methods 3 & 4 combined:

  local data = ''

  for i  = 1,  row * col do            -- populate the data table,  as in Method 2
    data  = data .. ''
  end

  local imgData5  = ima .newImageData( row,  col,  data )

  i = 1
  for y  = 0,  row -1 do
    for x = 0,  col -1 do            -- then setPixel()  as in Method 3
      if i > 80 then
        imgData5 :setPixel( x,  y,  0,  0,  0 )
      elseif i > 60 then
        imgData5 :setPixel( x,  y,  0,  0,  255 )
      elseif i > 40 then
        imgData5 :setPixel( x,  y,  0,  255,  0 )
      elseif i > 20 then
        imgData5 :setPixel( x,  y,  255,  0,  0 )
      else
        imgData5 :setPixel( x,  y,  255,  255,  255 )
      end
      i  = i + 1
    end
  end

  method5  = gra .newImage( imgData5 )

  print( '5  "' .. imgData5 :getString( ) .. '"' )
end

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Method 6:  use values 0 to 1

  local data = ''

  for i  = 1,  row * col do
    if i > 80 then
      data  = data .. '0001'
    elseif i > 60 then
      data  = data .. '0011'
    elseif i > 40 then
      data  = data .. '0101'
    elseif i > 20 then
      data  = data .. '1001'
    else
      data  = data .. '1111'
    end
  end

  local imgData6  = ima .newImageData( row,  col,  data )
  method6  = gra .newImage( imgData6 )

  print( '6  "' .. imgData6 :getString( ) .. '"' )

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function LO .draw()
  gra .setColor( 255, 255, 255 )
  gra .draw( expected,  50,  100 )

  gra .draw( method1,  150,  100,  0,  10,  10 )
  gra .draw( method2,  250,  100,  0,  10,  10 )
  gra .draw( method3,  350,  100,  0,  10,  10 )
  gra .draw( method4,  450,  100,  0,  10,  10 )
  gra .draw( method5,  450,  100,  0,  10,  10 )
  gra .draw( method5,  550,  100,  0,  10,  10 )

  gra .setColor( 100, 0, 0 )
  gra .line( 150,  80,  150,  230 )
  gra .line( 250,  80,  250,  230 )
  gra .line( 350,  80,  350,  230 )
  gra .line( 450,  80,  450,  230 )
  gra .line( 550,  80,  550,  230 )
  gra .line( 650,  80,  650,  230 )

  gra .print( 'Expected',  110,  250,  math .pi *.35 )
  gra .setColor( 0, 0, 0 )
  gra .print( 'imported PNG',  80,  270,  math .pi *.35, .6, .6 )

  gra .setColor( 100, 0, 0 )
  gra .print( 'Method 1',  210,  250,  math .pi *.35 )
  gra .setColor( 0, 0, 0 )
  gra .print( 'Values 0 to F',  180,  270,  math .pi *.35, .6, .6 )

  gra .setColor( 100, 0, 0 )
  gra .print( 'Method 2',  310,  250,  math .pi *.35 )
  gra .setColor( 0, 0, 0 )
  gra .print( 'ASCII values 32 to 126',  280,  270,  math .pi *.35, .6, .6 )

  gra .setColor( 100, 0, 0 )
  gra .print( 'Method 3',  410,  250,  math .pi *.35 )
  gra .setColor( 0, 0, 0 )
  gra .print( 'ASCII values 0 to 127',  380,  270,  math .pi *.35, .6, .6 )

  gra .setColor( 100, 0, 0 )
  gra .print( 'Method 4',  510,  250,  math .pi *.35 )
  gra .setColor( 0, 0, 0 )
  gra .print( ':setPixel()',  490,  280,  math .pi *.35, .6, .6 )

  gra .setColor( 100, 0, 0 )
  gra .print( 'Methods 3 & 4',  610,  250,  math .pi *.35 )
  gra .setColor( 0, 0, 0 )
  gra .print( 'fill, then :setPixel()',  580,  270,  math .pi *.35, .6, .6 )

  gra .setColor( 100, 0, 0 )
  gra .print( 'Method 6',  710,  250,  math .pi *.35 )
  gra .setColor( 0, 0, 0 )
  gra .print( 'values 0 to 1',  680,  270,  math .pi *.35, .6, .6 )
end

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function LO .quit()
  print('Löve App exit')
end

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
