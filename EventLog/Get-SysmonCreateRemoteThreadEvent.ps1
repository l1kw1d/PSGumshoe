
function Get-SysmonCreateRemoteThreadEvent {
    <#
    .SYNOPSIS
        Short description
    .DESCRIPTION
        The CreateRemoteThread event detects when a process creates a thread in another process. This technique is used by malware to inject code and hide in other processes. The event indicates the source and target process. It gives information on the code that will be run in the new thread: StartAddress, StartModule and StartFunction. Note that StartModule and StartFunction fields are inferred, they might be empty if the starting address is outside loaded modules or known exported functions.
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        General notes
    #>
    [CmdletBinding(DefaultParameterSetName = 'Local')]
    param (
        # Log name for where the events are stored.
        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string]
        $LogName = 'Microsoft-Windows-Sysmon/Operational',

        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $SourceProcessGuid,

        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $SourceProcessId,

        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $SourceImage,

        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $TargetProcessGuid,

        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $TargetProcessId,

        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $TargetImage,

        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $NewThread,

        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $StartAddress,

        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $StartModule,

        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $StartFunction,

        # Specifies the path to the event log files that this cmdlet get events from. Enter the paths to the log files in a comma-separated list, or use wildcard characters to create file path patterns. Function supports files with the .evtx file name extension. You can include events from different files and file types in the same command.
        [Parameter(Mandatory=$true,
                   Position=0,
                   ParameterSetName="file",
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [string[]]
        $Path,

        # Gets events from the event logs on the specified computer. Type the NetBIOS name, an Internet Protocol (IP) address, or the fully qualified domain name of the computer.
        # The default value is the local computer.
        # To get events and event logs from remote computers, the firewall port for the event log service must be configured to allow remote access.
        [Parameter(Mandatory = $true,
                   ValueFromPipelineByPropertyName = $true,
                   ParameterSetName = 'Remote')]
        [string[]]
        $ComputerName,

        # Specifies a user account that has permission to perform this action.
        #
        # Type a user name, such as User01 or Domain01\User01. Or, enter a PSCredential object, such as one generated by the Get-Credential cmdlet. If you type a user name, you will
        # be prompted for a password. If you type only the parameter name, you will be prompted for both a user name and a password.
        [Parameter(Mandatory = $false,
                   ParameterSetName = 'Remote')]
        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential,

        # Specifies the maximum number of events that are returned. Enter an integer. The default is to return all the events in the logs or files.
        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [int64]
        $MaxEvents,

        # Stsrttime from where to pull events.
        [Parameter(Mandatory = $false)]
        [datetime]
        $StartTime,

        # Stsrttime from where to pull events.
        [Parameter(Mandatory = $false)]
        [datetime]
        $EndTime,

        # Changes the default logic for matching fields from 'and' to 'or'.
        [Parameter(Mandatory = $false)]
        [switch]
        $ChangeLogic
    )

    begin {}

    process {
        Search-SysmonEvent -EventId 8 -ParamHash $MyInvocation.BoundParameters

    }

    end {}
}