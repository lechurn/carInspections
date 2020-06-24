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
        [HttpGet]
        public IHttpActionResult GetInspections(DateTime bookingDate)
        {
            var inspectionDetails = carUtil.getInspections(bookingDate);
            return Json(inspectionDetails);
        }
        
        [Route("GetBooking")]
        [HttpPost]
        public IHttpActionResult PostInspections([FromBody] BookInspectionReq request)
        {
            DateTime dateTime2;

            if (DateTime.TryParse(request.bookingDate, out dateTime2)) {
                if (carUtil.createUpdateInspections(DateTime.Parse(request.bookingDate), request.bookingSlotId, request.userId))
                {
                    return Json("Booking Created");
                }
                else
                {
                    return Json("Unable to Create Booking");
                }
                
            }
            else
            {
                return BadRequest("Invalid Date");
            }

            
        }
    }
}
