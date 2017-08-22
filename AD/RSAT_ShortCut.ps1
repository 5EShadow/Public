$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$Home\Desktop\RSAT Install.lnk")
$Shortcut.TargetPath = "goo.gl/J4OguI"
$Shortcut.IconLocation = "C:\windows\system32\rsat.ico"
$Shortcut.Save()
