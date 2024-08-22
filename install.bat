REM Copy Alacritty configuration
mkdir "%APPDATA%\alacritty"
xcopy /y "alacritty\alacritty-windows.toml" "%APPDATA%\alacritty\alacritty.toml"

REM Create fonts directory
mkdir C:\Windows\Fonts

REM Download and install Hack Nerd Fonts
powershell -Command "& {
    $fontsPath = 'C:\Windows\Fonts\';
    $fontUrls = @(
        'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Bold/HackNerdFont-Bold.ttf',
        'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf',
        'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Italic/HackNerdFont-Italic.ttf',
        'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/BoldItalic/HackNerdFont-BoldItalic.ttf'
    );
    foreach ($url in $fontUrls) {
        $fileName = $url.Split('/')[-1];
        $outputPath = $fontsPath + $fileName;
        Invoke-WebRequest -Uri $url -OutFile $outputPath;
        (New-Object -ComObject Shell.Application).Namespace(0x14).ParseName($outputPath).InvokeVerb('Install');
    }
}"
