using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstanaTestApp
{
    public partial class DefaultPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblRuntime.Text      = System.Runtime.InteropServices.RuntimeEnvironment.GetSystemVersion();
            lblClr.Text          = Environment.Version.ToString();
            lblOs.Text           = Environment.OSVersion.ToString();
            lblMachine.Text      = Environment.MachineName;
            lblPool.Text         = Env("APPL_MD_PATH");
            lblCorProfiling.Text = Env("COR_ENABLE_PROFILING");
            lblProfilerGuid.Text = Env("COR_PROFILER");
            lblAgentHost.Text    = Env("INSTANA_AGENT_HOST");
            lblAgentPort.Text    = Env("INSTANA_AGENT_PORT");
        }

        private string Env(string name)
        {
            string val = Environment.GetEnvironmentVariable(name);
            return string.IsNullOrEmpty(val) ? "<no establecida>" : val;
        }
    }
}
