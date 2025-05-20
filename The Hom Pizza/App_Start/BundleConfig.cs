using System.Web;
using System.Web.Optimization;

namespace The_Hom_Pizza
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            //JS System
            bundles.Add(new ScriptBundle("~/jsa").Include("~/js/jquery-3.2.1.min.js"));
            bundles.Add(new ScriptBundle("~/jsc").Include("~/js/bootstrap.min.js"));
            //JS Admin
            bundles.Add(new ScriptBundle("~/jst").Include("~/js/adminlte.js"));
            bundles.Add(new ScriptBundle("~/jsw").Include("~/js/ajaxDeleteAdmin.js"));
            bundles.Add(new ScriptBundle("~/jsp").Include("~/js/jquery.min.js"));
            bundles.Add(new ScriptBundle("~/jsq").Include("~/js/bootstrap.bundle.min.js"));
            bundles.Add(new ScriptBundle("~/jsr").Include("~/js/jquery.overlayScrollbars.min.js"));
            //JS User
            bundles.Add(new ScriptBundle("~/jsv").Include("~/js/slider.js"));
            bundles.Add(new ScriptBundle("~/jsu").Include("~/js/ajaxCart.js"));
            bundles.Add(new ScriptBundle("~/jsx").Include("~/js/Address.js"));
            bundles.Add(new ScriptBundle("~/jso").Include("~/js/Modal.js"));


            //CSS User
            bundles.Add(new StyleBundle("~/styles").Include("~/css/styles.css"));
            bundles.Add(new StyleBundle("~/cssa").Include("~/css/bootstrap.min.css"));
            bundles.Add(new StyleBundle("~/cssb").Include("~/css/responsive.css"));
            //CSS Admin
            bundles.Add(new StyleBundle("~/cssg").Include("~/css/adminlte.min.css"));
            bundles.Add(new StyleBundle("~/cssh").Include("~/css/all.min.css"));
            bundles.Add(new StyleBundle("~/cssi").Include("~/css/OverlayScrollbars.min.css"));
            bundles.Add(new StyleBundle("~/cssf").Include("~/css/ProductDetails.css"));
        }
    }
}
