<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="InstanaTestApp.DefaultPage" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>Instana Test App — .NET Framework 3.5 / CLR v2.0</title>
  <style>
    body { font-family: Segoe UI, sans-serif; max-width: 800px; margin: 40px auto; }
    h1   { color: #e55; }
    table { border-collapse: collapse; width: 100%; margin-top: 20px; }
    th, td { border: 1px solid #ccc; padding: 8px 12px; text-align: left; }
    th { background: #f0f0f0; }
    a.btn { display: inline-block; margin: 6px 4px; padding: 8px 16px;
            background: #0078d4; color: #fff; text-decoration: none; }
    a.btn:hover { background: #005fa3; }
  </style>
</head>
<body>
  <h1>Instana Test App</h1>
  <p>Emulando: <strong>Windows Server 2012 R2 / IIS 8.5 / .NET Framework 3.5 / CLR v2.0</strong></p>

  <h2>Estado del entorno</h2>
  <table>
    <tr><th>Propiedad</th><th>Valor</th></tr>
    <tr><td>.NET Runtime</td>              <td><asp:Label ID="lblRuntime"      runat="server" /></td></tr>
    <tr><td>CLR Version</td>               <td><asp:Label ID="lblClr"          runat="server" /></td></tr>
    <tr><td>OS</td>                        <td><asp:Label ID="lblOs"           runat="server" /></td></tr>
    <tr><td>Machine</td>                   <td><asp:Label ID="lblMachine"      runat="server" /></td></tr>
    <tr><td>App Pool (APPL_MD_PATH)</td>   <td><asp:Label ID="lblPool"         runat="server" /></td></tr>
    <tr><td>COR_ENABLE_PROFILING (CLR2)</td><td><asp:Label ID="lblCorProfiling" runat="server" /></td></tr>
    <tr><td>COR_PROFILER</td>              <td><asp:Label ID="lblProfilerGuid" runat="server" /></td></tr>
    <tr><td>INSTANA_AGENT_HOST</td>        <td><asp:Label ID="lblAgentHost"    runat="server" /></td></tr>
    <tr><td>INSTANA_AGENT_PORT</td>        <td><asp:Label ID="lblAgentPort"    runat="server" /></td></tr>
  </table>

  <h2>Pruebas de traza</h2>
  <a class="btn" href="health.aspx">Health check (span entrante simple)</a>
  <a class="btn" href="call.aspx">HTTP saliente (genera span saliente)</a>
  <a class="btn" href="call.aspx?url=http://httpbin.org/delay/1">HTTP saliente con latencia</a>
  <a class="btn" href="call.aspx?error=1">Simular error HTTP 500</a>

  <h2>Instrucciones rapidas</h2>
  <ol>
    <li>Asegurate de que el agente Instana esta corriendo y accesible.</li>
    <li>Ejecuta <code>setup-iis.ps1</code> como Administrador para crear el pool con CLR v2.0.</li>
    <li>Recicla el App Pool: <code>Restart-WebAppPool "InstanaTestF2"</code></li>
    <li>Haz clic en los botones de arriba y busca las trazas en Instana UI.</li>
  </ol>
</body>
</html>