using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using carlibrary;
using System.Web.Http.Cors;

namespace WebAPI.Controllers
{
    [EnableCors(origins: "http://localhost:3345", headers: "*", methods: "*")]
    [RoutePrefix("api/inspect")]
    public class InspectionsController : ApiController
    {
        carLib carUtil = new carLib();
        [Route("GetBooking")]
        public IHttpActionResult GetInspections(DateTime bookingDate)
        {
            var inspectionDetails = carUtil.getInspections(bookingDate);
            return Json(inspectionDetails);
        }
    }
}
