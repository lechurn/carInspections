using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using carlibrary;

namespace WebAPI.Controllers
{
    [RoutePrefix("api/inspect")]
    public class InspectionsController : ApiController
    {
        carLib carUtil = new carLib();
        [Route("GetBooking")]
        public IHttpActionResult GetInspections()
        {
            var bookinngDetails = carUtil.getInspections();
            return Json(bookinngDetails);
        }
    }
}
