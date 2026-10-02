using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstanaTestApp
{
    public partial class HealthPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblStatus.Text      = "OK";
            lblTime.Text        = DateTime.UtcNow.ToString("s") + "Z";
            Response.StatusCode = 200;
        }
    }
}
