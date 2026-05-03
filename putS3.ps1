$ErrorActionPreference = "Stop"

$currentPath = Get-Location
$uploadFileList = Join-Path -Path $currentPath -ChildPath "UploadFileList.csv"
if (!(Test-Path -Path $uploadFileList)) {
  Write-Host "アップロードファイルリストがありません。"
  exit 1
}

$execTime = Get-Date -Format "yyyyMMdd-HHmmss"
$logFileName = $execTime + "-s3put.log"
$logFilePath = Join-Path -Path $currentPath -ChildPath $logFileName
Start-Transcript $logFilePath -Append | Out-Null

try {
  Import-Csv $uploadFileList | Foreach-Object {
    $uploadFilePath = $_.FilePath
    if (!(Test-Path -Path "${uploadFilePath}")) {
      Write-Host "ERROR: ${uploadFilePath} が存在しないので処理をスキップします。"
    }
    else {
      $bucketName = $_.S3BucketName
      $uploadFileInfo = Get-ChildItem -Path $uploadFilePath
      $uploadFileName = $uploadFileInfo.Name
      $folder = $_.FolderName
      $bucketKey = "${folder}/${uploadFileName}"
      $s3ApiCommand = "aws s3api put-object --body ${uploadFilePath} --bucket ${bucketName} --key ${bucketKey} --if-none-match `"*`" --expected-bucket-owner アカウント A のアカウント ID"
      Invoke-Expression $s3ApiCommand
      if ($lastexitcode -eq 0) {
        Write-Host "INFO: ${uploadFilePath} のアップロードに成功しました。"
      }
      else {
        Write-Host "ERROR: ${uploadFilePath} のアップロードに失敗しました。"
      }
    }
  }
}
catch {
  Write-Host "ERROR: $_"
}
finally {
  Stop-Transcript
}