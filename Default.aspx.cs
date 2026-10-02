using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InstanaTestApp
{
    public class DefaultPage : Page
    {
        protected Label lblRuntime;
        protected Label lblClr;
        protected Label lblOs;
        protected Label lblMachine;
        protected Label lblPool;
        protected Label lblCorProfiling;
        protected Label lblProfilerGuid;
        protected Label lblAgentHost;
        protected Label lblAgentPort;

        protected void Page_Load(object sender, EventArgs e)
        {
            lblRuntime.Text       = System.Runtime.InteropServices.RuntimeEnvironment.GetSystemVersion();
            lblClr.Text           = Environment.Version.ToString();
            lblOs.Text            = Environment.OSVersion.ToString();
            lblMachine.Text       = Environment.MachineName;
            lblPool.Text          = Environment.GetEnvironmentVariable("APPL_MD_PATH") ?? "(no disponible)";
            lblCorProfiling.Text  = Env("COR_ENABLE_PROFILING");
            lblProfilerGuid.Text  = Env("COR_PROFILER");
            lblAgentHost.Text     = Env("INSTANA_AGENT_HOST");
            lblAgentPort.Text     = Env("INSTANA_AGENT_PORT");
        }

        private string Env(string name)
        {
            var val = Environment.GetEnvironmentVariable(name);
            return string.IsNullOrEmpty(val) ? "<no establecida>" : val;
        }
    }
}