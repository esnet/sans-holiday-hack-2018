while ($true) {
	Get-Childitem C:\careerportal\resources\public | ForEach-Object { Remove-Item $_.FullName -Force }
	Start-Sleep -s 300
}
