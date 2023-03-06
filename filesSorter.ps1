# Create an array of file types and their corresponding folder names
$types = @(
    @{type="*.txt"; folder="TextFiles"}
    @{type="*.docx"; folder="WordFiles"}
    @{type="*.xlsx"; folder="ExcelFiles"}
    @{type="*.pdf"; folder="PdfFiles"}
    @{type="*.pptx"; folder="PowerPointFiles"}
    @{type="*.jpg"; folder="ImageFiles"}
    @{type="*.png"; folder="ImageFiles"}
    @{type="*.zip"; folder="ArchiveFiles"}
)

# Create the folders if they don't already exist
foreach ($type in $types) {
    $folderPath = Join-Path -Path $PWD.Path -ChildPath $type.folder
    if (-not (Test-Path $folderPath)) {
        New-Item -ItemType Directory -Path $folderPath | Out-Null
    }
}

# Loop through each file in the current directory and move it to the appropriate folder
Get-ChildItem | ForEach-Object {
    foreach ($type in $types) {
        if ($_.Name -like $type.type) {
            $folderPath = Join-Path -Path $PWD.Path -ChildPath $type.folder
            Move-Item $_.FullName -Destination $folderPath -Force
        }
    }
}
