$KBS = @("4025341","4014504")
foreach ($KB in $KBS) {
	if ( get-hotfix KB$KB -ErrorAction SilentlyContinue ) {
		Start-Process wusa.exe -ArgumentList "/KB:$KB /uninstall /quiet /norestart" -Wait
	}
}
