#
gphoto2 --list-config
  /main/capturesettings/imagequality

# to Jpg
gphoto2 --get-config /main/capturesettings/imagequality
gphoto2 --set-config /main/capturesettings/imagequality=2

# to No Flash
gphoto2 --get-config /main/capturesettings/flashmode
gphoto2 --set-config /main/capturesettings/flashmode=0

