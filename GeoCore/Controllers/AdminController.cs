using System.Data;
using System.Data.SqlClient;
using System.Web.Mvc;
using GeoCore.Models;
using Dapper;

namespace GeoCore.Controllers
{
    public class AdminController : Controller
    {
        //
        // GET: /Admin/

        public ActionResult Index()
        {
            return View();
        }

        public void Saveconfig(SiteConfig siteConfig)
        {

            var p = new DynamicParameters();
            p.Add("@SiteName",siteConfig.SiteName);
            p.Add("@StartLatitude",siteConfig.StartLatitude);
            p.Add("@StartLongitude",siteConfig.StartLongitude);
            p.Add("@ZoomLevel",siteConfig.ZoomLevel);
            p.Add("@BaseMap", siteConfig.BaseMap);

            SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["GeoCore"].ConnectionString);
            connection.Open();
            connection.Execute("GeoCore.SaveConfig", p, commandType: CommandType.StoredProcedure);
            connection.Close();

        }

    }
}
