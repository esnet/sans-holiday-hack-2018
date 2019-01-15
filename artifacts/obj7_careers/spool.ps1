#WE WILL NEED TO create a regular restricted user on the system and use there creds for the service account we will run this script from
#Tell it which directory to look it. When we turn this into a service, its best to give full path
$UPLOAD_DIR = "C:\careerportal\uploads"
while ($true) {
    #Recursively get teh .csv files from teh upload dir
    $files = (Get-ChildItem -Path $UPLOAD_DIR -Filter *.csv -Recurse -File| ForEach-Object { 
        #Grab contents of file
        $cont = (Get-Content $_.FullName)
        #If there is only one line, then powershell makes it a string other its an array. We want to grab first line
        if ($cont.GetType().Name -eq "Object[]") {
            $first = $cont[0]
        } else {
            $first = $cont
        }
        #This adds CSV headers of 1,2,3,4,5   etc... so we can be sure the ConvertFrom-CSV command can convert it properly in case they forgot headers
        $csv_w_headers = (('"'+(((1..(([regex]::Matches($first, ',' )).count + 1)) | ForEach { $_.toString()} ) -join '","')+'"') + "`n" + $cont | ConvertFrom-CSV )
        #Iterate each column of the csv
        $csv_w_headers | Foreach-Object { 
            #iterate each column of 1,2,3,4,5,6
            foreach ($property in $_.PSObject.Properties)
            {
                #grabs the values and grabs regex matches for =cmd|'/c calc.exe'!_xlbgnm.A1.. We really only want whats inside of '/c <SOMECOMMAND>'.
                $cmds = [regex]::Matches($property.Value, "(?i:\=cmd\|\'\s*?\/c\s+?(.+)\'\!\w\w+?)" )
                #Long as our second capture group of (.+) found something, then our length of groups should be 2
                if ($cmds.Groups.length -gt 1) {
                    #If so, start the command as a new process. Command is stored in $cmds.Groups[1]
                    Start-Job -ScriptBlock {param($p) iex($p)} -Arg $cmds.Groups[1]
                    #Sleep for one second so that the job has time to startup otherwise it might die before it ever starts
                    Start-Sleep -s 1
                }
            } 

        }
        #We delete the file after we are done with it
        Remove-Item $_.FullName -Force
    } )
    #We wait before continueing in our for loop. This gives all command execution 30 seconds to run before its killed
    Start-Sleep -s 30
    #first lets grab this processes id and its parents/grandparents cause we dont want to kill them
    $parent = (Get-CimInstance -Class Win32_Process -Filter "Handle = $pid").ParentProcessID
    $grandparent = (Get-CimInstance -Class Win32_Process -Filter "Handle = $parent").ParentProcessID
    $greatgrandparent = (Get-CimInstance -Class Win32_Process -Filter "Handle = $grandparent").ParentProcessID
    $all_pids = @()
    $all_pids += $pid.toString()
    if ($parent) {$all_pids += $parent.toString()}
    if ($grandparent) {$all_pids += $grandparent.toString()}
    if ($greatgrandparent) {$all_pids += $greatgrandparent.toString()}
    #Get all processes
    Get-CimInstance Win32_Process | Foreach-Object {
        #filter out the ones that share the same user as this script
        if ((Invoke-CimMethod -InputObject $_ -MethodName GetOwner).User -eq $env:UserName) {
            #As long as the PID is not contained in the parent or current process pids, then lets kill it
            if (!$all_pids.contains($_.Handle) -and $_.Name -ne "conhost.exe") {
                Stop-Process -Id ($_.Handle | Out-string) -Force
            }
        }
    } 
}
