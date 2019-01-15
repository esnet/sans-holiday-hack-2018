$global:firstrun = $TRUE
function Show-Menu
{
    $intro = @(
        "We just hired this new worker,",
        "Californian or New Yorker?",
        "Think he's making some new toy bag...",
        "My job is to make his name tag.",
        "",
        "Golly gee, I'm glad that you came,",
        "I recall naught but his last name!",
        "Use our system or your own plan,",
        "Find the first name of our guy `"Chan!`"",
        "",
        "-Bushy Evergreen",
        "",
        "To solve this challenge, determine the new worker's first name and submit to runtoanswer."
    )
    $header = @(
        "===================================================================="
        "=                                                                  =",
        "= S A N T A ' S  C A S T L E  E M P L O Y E E  O N B O A R D I N G =",
        "=                                                                  =",
        "===================================================================="
    )
    cls
    if ($global:firstrun -eq $TRUE) {
        Write-Host "`n`n"
        for ($i = 0; $i -lt $intro.length; $i++) {
            Write-Host $intro[$i]
        }
        $global:firstrun = $FALSE
    }
    Write-Host "`n`n`n"
    for ($i = 0; $i -lt $header.length; $i++) {
        Write-Host $header[$i]
    }
    Write-Host "`n`n`n"
    Write-Host ' Press '1' to start the onboard process.'
    Write-Host ' Press '2' to verify the system.'
    Write-Host ' Press 'q' to quit.'
    Write-Host "`n"
}

function Employee-Onboarding-Form
{
    Write-Host "`n`nWelcome to Santa's Castle!`n`n"
    Write-Host "At Santa's Castle, our employees are our family. We care for each other,"
    Write-Host "and support everyone in our common goals.`n"
    Write-Host "Your first test at Santa's Castle is to complete the new employee onboarding paperwork."
    Write-Host "Don't worry, it's an easy test! Just complete the required onboarding information below.`n`n"
    $efirst = Read-Host "Enter your first name.`n"
    $elast = Read-Host "Enter your last name.`n"
    $estreet1 = Read-Host "Enter your street address (line 1 of 2).`n"
    $estreet2 = Read-Host "Enter your street address (line 2 of 2).`n"
    $ecity = Read-Host "Enter your city.`n"
    $epostalcode = Read-Host "Enter your postal code.`n"
    $ephone = Read-Host "Enter your phone number.`n"
    $eemail = Read-Host "Enter your email address.`n"
    Write-Host "`n`nIs this correct?`n`n"
    Write-Host "$efirst $elast"
    Write-Host "$estreet1"
    if ($estreet2) {
        Write-Host "$estreet2"
    }
    Write-Host "$ecity, $epostalcode"
    Write-Host "$ephone"
    Write-Host "$eemail"
    $input = Read-Host 'y/n'
    if ($input -eq 'y' -Or $input -eq 'Y') {
        Write-Host "Save to sqlite DB using command line"
        Start-Process -FilePath "./sqlite3" -ArgumentList "onboard.db `"INSERT INTO onboard (fname, lname, street1, street2, city, postalcode, phone, email) VALUES (`'$efirst`',`'$elast`', `'$estreet1`', `'$estreet2`', `'$ecit
y`', `'$epostalcode`', `'$ephone`', `'$eemail`')`""
    }
}
try
{
    do
    {
        Show-Menu
        $input = Read-Host 'Please make a selection'
        switch ($input)
        {
            '1' {
                cls
                Employee-Onboarding-Form
            } '2' {
                cls
                Write-Host "Validating data store for employee onboard information."
                $server = Read-Host 'Enter address of server'
                /bin/bash -c "/bin/ping -c 3 $server"
                /bin/bash -c "/usr/bin/file onboard.db"
            } '9' {
                /usr/bin/pwsh
                return
            } 'q' {
                return
            } default {
                Write-Host "Invalid entry."
            }
        }
        pause
    }
    until ($input -eq 'q')
} finally {
}
