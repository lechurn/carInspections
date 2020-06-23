using System.Web.Http;

namespace WebAPI.Configuration
{
    public class WebAPIConfig
    {
        public static void Register(HttpConfiguration config)
        {
            config.EnableCors();

            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
        }
    }
}