<%@ Page Language="C#" AutoEventWireup="true" CodeFile="health.aspx.cs" Inherits="InstanaTestApp.HealthPage" %>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8" /><title>Health</title></head>
<body>
  <h2>Health Check</h2>
  <p>Status: <asp:Label ID="lblStatus" runat="server" /></p>
  <p>Timestamp: <asp:Label ID="lblTime" runat="server" /></p>
  <p><a href="Default.aspx">&laquo; Volver</a></p>
</body>
</html>