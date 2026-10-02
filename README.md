# instana-test-appf2

App de prueba **ASP.NET Web Forms** orientada a simular el escenario de un cliente que corre IIS con App Pool en **CLR v2.0** (.NET Framework 3.5).

## Escenario que emula

```
Windows Server 2012 R2 / IIS 8.5
App Pool: CLR v2.0 — Integrated Pipeline
w3wp.exe arranca con: -v "v2.0" -l "webengine4.dll"
```

> Diferencia clave con el repo `instana-test-app` (que usa CLR v4.0 / .NET 4.8):
> aqui el `targetFramework` es **3.5** para ser compatible con CLR v2.0.

## Archivos

| Archivo | Descripcion |
|---|---|
| `Default.aspx` / `.cs` | Pagina principal con tabla de estado del entorno |
| `health.aspx` / `.cs` | Endpoint health check — span entrante simple |
| `call.aspx` / `.cs` | Llamada HTTP saliente — genera span saliente |
| `web.config` | Config IIS/ASP.NET con `targetFramework=3.5` |
| `setup-iis.ps1` | Script PowerShell para crear el App Pool con CLR v2.0 y variables Instana |

## Setup rapido

### 1. Clonar y copiar a IIS

```powershell
git clone https://github.com/JohnXairo/instana-test-appf2.git C:\inetpub\wwwroot\instana-test-appf2
```

### 2. Configurar App Pool y variables de entorno

```powershell
# Ejecutar como Administrador
cd C:\inetpub\wwwroot\instana-test-appf2
.\setup-iis.ps1
```

Esto crea el App Pool `InstanaTestF2` con:
- `.NET CLR Version = v2.0`
- `COR_ENABLE_PROFILING=1`
- `COR_PROFILER={cf0d821e-299b-5307-a3d8-b283c03916dd}`
- `COR_PROFILER_PATH=<ruta Instana profiler>`
- `INSTANA_AGENT_HOST=127.0.0.1`
- `INSTANA_AGENT_PORT=42699`

### 3. Verificar que w3wp arranca con CLR v2.0

```powershell
Get-Process w3wp | ForEach-Object {
    $cmdline = (Get-WmiObject Win32_Process -Filter "ProcessId=$($_.Id)").CommandLine
    Write-Host $cmdline
}
```

Deberias ver `-v "v2.0" -l "webengine4.dll"` en la linea de comandos.

### 4. Acceder a la app

http://localhost:8090/

## Variables de entorno para CLR v2.0

| Variable | Valor |
|---|---|
| `COR_ENABLE_PROFILING` | `1` |
| `COR_PROFILER` | `{cf0d821e-299b-5307-a3d8-b283c03916dd}` |
| `COR_PROFILER_PATH` | Ruta a `Instana.Profiler.Native.x64.dll` |
| `INSTANA_AGENT_HOST` | IP del agente Instana |
| `INSTANA_AGENT_PORT` | `42699` |

> **NO uses** `CORECLR_ENABLE_PROFILING` — esa variable es para .NET Core/5+.
> Para CLR v2.0 y v4.0 la variable correcta es `COR_ENABLE_PROFILING`.
