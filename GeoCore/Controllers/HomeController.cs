
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Mvc;
using Dapper;
using GeoCore.Models;

namespace GeoCore.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
            GetSiteSettings(); 
            return View();
        }

        public JsonResult GetSiteSettings()
        {
            SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["GeoCore"].ConnectionString);
            connection.Open();

            var result = connection.Query<SiteConfig>("GeoCore.GetSiteConfiguration", commandType: CommandType.StoredProcedure).ToList();

            connection.Close();

            JsonResult siteConfig = Json(result, JsonRequestBehavior.AllowGet);
            return siteConfig;

        }
    }
}
