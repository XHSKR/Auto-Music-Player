@echo off
chcp 65001>nul
color a
title MUSIC AUTO PLAYER - XHSKR (2022)
mode con cols=75 lines=10
SET "musicPath=C:\Users\aaaa\Desktop\신호곡"
SET "musicFolder1=1600(1500) 도수체조"
SET "musicFolder2=1800(1700) 하기식"
SET "musicFolder3=0640(0710) 새벽군가"
SET "musicFolder4=0700(0730) 게양식"
for /f %%i in ('powershell ^(get-date^).DayOfWeek') do set dow=%%i

:loop
SET currentTime=%time:~0,8%
cls
echo Current Time:%currentTime%
echo.

::Update dow to latest
if "%currentTime%"==" 0:00:00" (
for /f %%i in ('powershell ^(get-date^).DayOfWeek') do set dow=%%i
)

::도수체조
if "%dow%"=="Monday" ( SET "musicTime1=16:00:00" )
if "%dow%"=="Tuesday" ( SET "musicTime1=16:00:00" )
if "%dow%"=="Wednesday" ( SET "musicTime1=15:00:00" )
if "%dow%"=="Thursday" ( SET "musicTime1=16:00:00" )
if "%dow%"=="Friday" ( SET "musicTime1=16:00:00" )
if "%dow%"=="Saturday" ( SET "musicTime1=N/A" )
if "%dow%"=="Sunday" ( SET "musicTime1=N/A" )

::하기식
SET "musicTime2=17:59:50"

::새벽군가, 게양식
if "%dow%"=="Saturday" (
SET "musicTime3= 7:09:50"
SET "musicTime4= 7:29:50"
) else (
SET "musicTime3= 6:39:50"
SET "musicTime4= 6:59:50"
)
if "%dow%"=="Sunday" (
SET "musicTime3= 7:09:50"
SET "musicTime4= 7:29:50"
)

echo Today is %dow% so the scheduled time is as follows.
echo.
echo %musicFolder1% will be playing at: %musicTime1%
echo %musicFolder2% will be playing at: %musicTime2%
echo %musicFolder3% will be playing at:%musicTime3%
echo %musicFolder4% will be playing at:%musicTime4%

::Music1
if "%currentTime%"=="%musicTime1%" (
SET "playingFolder=%musicFolder1%"
call:playMusic !musicPath! !playingFolder!
)
::Music2
if "%currentTime%"=="%musicTime2%" (
SET "playingFolder=%musicFolder2%"
call:playMusic !musicPath! !playingFolder!
)
::Music3
if "%currentTime%"=="%musicTime3%" (
SET "playingFolder=%musicFolder3%"
call:playMusic !musicPath! !playingFolder!
)
::Music4
if "%currentTime%"=="%musicTime4%" (
SET "playingFolder=%musicFolder4%"
call:playMusic !musicPath! !playingFolder!
)
timeout /t 1 /nobreak>nul
goto:loop

::Function to play music
:playMusic
SET "list=playlist.m3u"
chcp 949>nul
dir /b "%musicPath%\%playingFolder%" > "%musicPath%\%playingFolder%\%list%"
chcp 65001>nul
start wmplayer "%musicPath%\%playingFolder%\%list%"