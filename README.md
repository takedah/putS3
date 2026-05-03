# putS3.ps1

同じディレクトリにある UploadFileList.csv のパスに指定したファイルを S3 へアップロードするスクリプトです。

UploadFileList.csv の書式例は以下のとおりです。

| FilePath | S3BucketName | FolderName |
|:-|:-|:-|
| C:\Users\Administrator\Desktop\share\001o005\ebi-dance001.png | test01-0001-0018 | 0001 |
| C:\Users\Administrator\Desktop\share\001o005\ebi-dance002.png | test01-0001-0020 | 0001 |
| C:\Users\Administrator\Desktop\share\001o009\ebi-dance002.png | test01-0001-0028 | 0028 |
| C:\Users\Administrator\Desktop\share\001o009\ebi-dance001.png | test01-0001-0028 | 0028 |

https://qiita.com/takeda_h/items/b1a8a8095529d5f1e38e