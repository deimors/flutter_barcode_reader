@echo off

docker run ^
 -it ^
 -v %cd%\protos:/work/protos ^
 -v %cd%\lib:/work/lib ^
 flutter_barcode_protoc:latest
