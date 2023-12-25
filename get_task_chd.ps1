param([Int32]$time_lag = 1)

$tasks = Get-ScheduledTask

foreach ($task in $tasks) {
    $full_task_path = ($task.TaskPath + $task.TaskName)
    $task_info = Get-ScheduledTaskInfo $full_task_path
    
    $time = [datetime]::Now.AddHours($time_lag * -1)

    if ($task_info.LastRunTime -lt $time) {
        continue
    }
    if ($task.State -eq "Disabled") {
        continue
    }

    Write-Output $task_info
} 

