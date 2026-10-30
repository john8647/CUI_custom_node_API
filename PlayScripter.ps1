param(
	[string]$ScriptPath = (Join-Path $PSScriptRoot 'script.txt'),
	[ValidateRange(0, 86400)]
	[double]$DelaySeconds = 1
)

$ErrorActionPreference = 'Stop'

$directCommandPath = Join-Path $PSScriptRoot 'direct_command.ps1'
$directSayPath = Join-Path $PSScriptRoot 'direct_say.ps1'

if (-not (Test-Path -LiteralPath $ScriptPath -PathType Leaf)) {
	throw "Script file not found: $ScriptPath"
}

$firstLine = Get-Content -LiteralPath $ScriptPath -TotalCount 1
if ($firstLine -eq 'action,character,text,delay_before_seconds') {
	$records = @(Import-Csv -LiteralPath $ScriptPath)
	if ($records.Count -eq 0) {
		throw "CSV script contains no actions: $ScriptPath"
	}

	foreach ($record in $records) {
		$kind = $record.action.Trim().ToLowerInvariant()
		if ($kind -notin @('command', 'say')) {
			throw "Invalid CSV action '$($record.action)' in '$ScriptPath'. Use 'command' or 'say'."
		}

		$character = $record.character.Trim()
		$text = $record.text.Trim()
		if (-not $character) {
			throw "Empty character in '$ScriptPath'."
		}
		if (-not $text) {
			throw "Empty text for $kind action in '$ScriptPath'."
		}
		if ($record.delay_before_seconds -notmatch '^\d+(?:\.\d+)?$' -or
			[double]$record.delay_before_seconds -gt 86400) {
			throw "Invalid delay '$($record.delay_before_seconds)' in '$ScriptPath'. Use a number from 0 to 86400."
		}

		$delay = [double]$record.delay_before_seconds
		if ($delay -gt 0) {
			Start-Sleep -Seconds $delay
		}

		if ($kind -eq 'command') {
			& $directCommandPath -Character $character -command $text
		}
		else {
			& $directSayPath -Character $character -Text $text
		}
	}

	return
}

foreach ($line in Get-Content -LiteralPath $ScriptPath) {
	$record = $line.Trim()
	if (-not $record -or $record.StartsWith('#')) {
		continue
	}

	if ($record -notmatch '^(command|say)(?:\s*:\s*|\s+)(.+)$') {
		throw "Invalid record in '$ScriptPath': $line. Use 'command: <character>' or 'say: <phrase>'."
	}

	$kind = $Matches[1].ToLowerInvariant()
	$text = $Matches[2].Trim()
	if (-not $text) {
		throw "Empty $kind record in '$ScriptPath'."
	}

	if ($kind -eq 'command') {
		& $directCommandPath $text
	}
	else {
		& $directSayPath $text
	}

	if ($DelaySeconds -gt 0) {
		Start-Sleep -Seconds $DelaySeconds
	}
}
