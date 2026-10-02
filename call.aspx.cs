using System;
using System.Net;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstanaTestApp
{
    public partial class CallPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Simular error 500
            if (Request.QueryString["error"] == "1")
            {
                Response.StatusCode = 500;
                lblStatus.Text = "500 - Error simulado";
                lblUrl.Text    = "(ninguna)";
                lblBody.Text   = "Se ha simulado un error HTTP 500.";
                return;
            }

            var targetUrl = Request.QueryString["url"]
                         ?? System.Web.Configuration.WebConfigurationManager.AppSettings["TargetUrl"]
                         ?? "http://httpbin.org/get";

            lblUrl.Text = targetUrl;

            try
            {
                var wc   = new WebClient();
                var body = wc.DownloadString(targetUrl);
                lblStatus.Text = "200 OK";
                lblBody.Text   = Server.HtmlEncode(body.Length > 500 ? body.Substring(0, 500) + "..." : body);
            }
            catch (Exception ex)
            {
                lblStatus.Text      = "ERROR";
                lblBody.Text        = Server.HtmlEncode(ex.Message);
                Response.StatusCode = 502;
            }
        }
    }
}
