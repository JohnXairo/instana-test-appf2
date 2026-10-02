# =============================================================
#  setup-iis.ps1
#  Configura el App Pool en IIS para CLR v2.0
#  y establece las variables de entorno de Instana
#
#  Ejecutar como Administrador en Windows Server 2012 R2
# =============================================================

param(
    [string]$PoolName    = "InstanaTestF2",
    [string]$SiteName    = "InstanaTestF2",
    [string]$PhysPath    = "C:\inetpub\wwwroot\instana-test-appf2",
    [string]$AgentHost   = "127.0.0.1",
    [int]   $AgentPort   = 42699,
    [string]$ProfilerDll = "C:\Program Files (x86)\Instana\instana-agent\data\instana-dotnet\COR_PROFILER_PATH\Instana.Profiler.Native.x64.dll"
)

Import-Module WebAdministration

# --- 1. Crear App Pool con CLR v2.0 ---
if (-not (Test-Path "IIS:\AppPools\$PoolName")) {
    New-WebAppPool -Name $PoolName
    Write-Host "[OK] App Pool '$PoolName' creado."
} else {
    Write-Host "[--] App Pool '$PoolName' ya existe."
}

Set-ItemProperty "IIS:\AppPools\$PoolName" managedRuntimeVersion "v2.0"
Set-ItemProperty "IIS:\AppPools\$PoolName" managedPipelineMode   "Integrated"
Write-Host "[OK] CLR version = v2.0 | Pipeline = Integrated"

# --- 2. Variables de entorno Instana en el App Pool (via appcmd) ---
$appcmd = "$env:windir\system32\inetsrv\appcmd.exe"

$vars = @{
    "COR_ENABLE_PROFILING" = "1"
    "COR_PROFILER"         = "{cf0d821e-299b-5307-a3d8-b283c03916dd}"
    "COR_PROFILER_PATH"    = $ProfilerDll
    "INSTANA_AGENT_HOST"   = $AgentHost
    "INSTANA_AGENT_PORT"   = $AgentPort.ToString()
}

foreach ($key in $vars.Keys) {
    $val = $vars[$key]
    & $appcmd set config `
        -section:system.applicationHost/applicationPools `
        "/[name='$PoolName'].environmentVariables.[name='$key',value='$val']" | Out-Null
    Write-Host "[OK] $key = $val"
}

# --- 3. Crear sitio IIS si no existe ---
if (-not (Test-Path "IIS:\Sites\$SiteName")) {
    if (-not (Test-Path $PhysPath)) { New-Item -ItemType Directory -Path $PhysPath | Out-Null }
    New-Website -Name $SiteName -Port 8090 -PhysicalPath $PhysPath -ApplicationPool $PoolName
    Write-Host "[OK] Sitio '$SiteName' creado en puerto 8090."
} else {
    Write-Host "[--] Sitio '$SiteName' ya existe."
}

# --- 4. Reciclar pool ---
Restart-WebAppPool -Name $PoolName
Write-Host "[OK] App Pool reciclado."
Write-Host ""
Write-Host "Accede a: http://localhost:8090/"
Write-Host "w3wp deberia arrancar con: -v 'v2.0' -l 'webengine4.dll'"