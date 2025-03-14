Register-ArgumentCompleter -CommandName ssh, scp -Native -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    # .ssh\config からHost項目の一覧を取得
    $sshConfigHostList = (Get-Content ~\.ssh\config).trim() -replace "\s+", " " | Select-String -Pattern "^Host\s" | ForEach-Object { $_ -split "\s+" | Select-Object -Skip 1 }

    # Host一覧 から入力値（$wordToComplete）に合致する物を補完対象。
    # [System.Management.Automation.CompletionResult]を生成して返す
    $sshConfigHostList | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
        $resultType = [System.Management.Automation.CompletionResultType]::ParameterValue
        # CompletionResult Class
        # completionText , listItemText , resultType, toolTip
        [System.Management.Automation.CompletionResult]::new($_, $_, $resultType , $_)
    }
}
