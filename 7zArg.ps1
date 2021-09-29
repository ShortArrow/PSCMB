foreach ($arg in $args) {
  echo $arg
  iex "7z a $arg.zip $arg -y"
}
Read-Host "続けるには Enter キーを押してください。"
