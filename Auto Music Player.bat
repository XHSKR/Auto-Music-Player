@echo off
chcp 65001>nul
color a
title AUTO MUSIC PLAYER
SET "musicPath=C:\Users\USER\Desktop\신호곡"
SET "musicFolder1=군가"
SET "musicFolder2=애국가 게양식"
SET "musicFolder3=애국가 하기식"

:check
for /f %%i in ('powershell ^(get-date^).DayOfWeek') do set dow=%%i
cls
SET newTime=%time:~0,8%
echo Current time: %newTime%
echo.

::Logical operator ("or") is not supported so I have to do this way..
if "%dow%"=="Saturday" (
    SET "musicTime1=07:00:00"
    SET "musicTime2=07:30:00"
) else (
    SET "musicTime1=06:30:00"
    SET "musicTime2=07:00:00"
)
if "%dow%"=="Sunday" (
    SET "musicTime1=07:00:00"
    SET "musicTime2=07:30:00"
)

SET "musicTime3=17:00:00"

echo Today is %dow% so the scheduled time is as follows.
echo.
echo %musicFolder1% will be playing at: %musicTime1%
echo %musicFolder2% will be playing at: %musicTime2%
echo %musicFolder3% will be playing at: %musicTime3%
timeout /t 1 /nobreak>nul
::Music1
if "%newTime%"=="%musicTime1%" (
 SET "playingFolder=%musicFolder1%"
call:playMusic !musicPath! !playingFolder!
  )

::Music2
if "%newTime%"=="%musicTime2%" (
 SET "playingFolder=%musicFolder2%"
call:playMusic !musicPath! !playingFolder!
  )

  ::Music3
if "%newTime%"=="%musicTime3%" (
 SET "playingFolder=%musicFolder3%"
call:playMusic !musicPath! !playingFolder!
  )

goto:check

::Function to play music
:playMusic
SET "list=playlist.m3u"
chcp 949>nul
dir /b "%musicPath%\%playingFolder%" > "%musicPath%\%playingFolder%\%list%"
chcp 65001>nul
start wmplayer "%musicPath%\%playingFolder%\%list%"