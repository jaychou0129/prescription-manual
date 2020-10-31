using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(PrescriptionManual.Startup))]
namespace PrescriptionManual
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
