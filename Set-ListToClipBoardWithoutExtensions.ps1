for ($i = 0; $i -lt $args.Count; $i++) {
  $leaf = (Split-Path $args[$i] -LeafBase)
  # Write-Host $leaf
  if ($i -eq 0) {
    Set-Clipboard -Value $leaf
  }
  else {
    Set-Clipboard -Value $leaf -Append
  }
}
