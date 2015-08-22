cd ..\www\
copy ..\nw\config\package.json package.json
rem copy ..\nw\sumatrapdf\SumatraPDF.exe SumatraPDF.exe
..\nw\zip\zip.exe -r app.zip  *
del package.json
rem del SumatraPDF.exe
mkdir ..\nw\tmp
move app.zip ..\nw\tmp\app.nw
cd ..\nw\


start bin32\nw.exe tmp\app.nw
exit
