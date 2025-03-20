# Pip Packages
$Pip = @(
    # General Python
    "coverage", # Code Coverage Tool
    "pylint", # Code Linter
    "ruff", # Code Formatter
    "mypy", # Static Type Checker

    # Data Science
    "numpy", # Numerical Python
    "pandas", # Data Analysis Library
    "matplotlib", # Data Visualization Library
    "seaborn", # Data Visualization Library
    "plotly", # Data Visualization Library

    # Machine Learning
    "scipy", # Scientific Computing Library
    "scikit-learn", # Machine Learning Library
    "torch", # Pytorch-Machine Learning Library
    "torchvision", # PyTorch for computer vision
    "torchaudio", # PyTorch Audio Library
    "tensorflow", # Machine Learning Library
    "keras", # Machine Learning Library
    "transformers", # Hugging Face Transformers Library
    "openai", # OpenAI Library


    # Web Development
    "flask", # Web App Library
    "flask_cors", # HTTPS for Flask
    "django", # Web App Library
    "requests", # HTTP Library
    "beautifulsoup4" # Web Scraping Library

    #Miscellaneous
    "pillow", # Image Processing Library
    "gradio", # Machine Learning Web App Library
    "langchain" # Building Apps with LLMs
)

# Print a line on the console for a new step
function New-Step {
    $width = (Get-Host).UI.RawUI.MaxWindowSize.Width
    for ($i = 1; $i -le $width; $i++) {
        Write-Host "-" -NoNewline -ForegroundColor Cyan -BackgroundColor DarkBlue
    }
    Write-Host ""
}

# Print a line on the console between sub-steps
function New-SubStep {
    $width = (Get-Host).UI.RawUI.MaxWindowSize.Width
    for ($i = 1; $i -le $width; $i++) {
        Write-Host "-" -NoNewline
    }
    Write-Host ""
}

function Install-PipPackage {
    param ( [string]$Package )

    New-Step
    Write-Host "Installing $Package"
    New-SubStep
    pip install $package
}

# Install Pip Packages
New-Step
Write-Host "Installing Pip Packages..."

pip install --upgrade pip
python.exe -m pip install --upgrade pip

foreach ($item in $Pip) {
    Install-PipPackage -Package "$item"
}