using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using carlibrary;
using System.Web.Http.Cors;
using WebAPI.Models.errorType;

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
                string createUpdateResponse = carUtil.createUpdateInspections(DateTime.Parse(request.bookingDate), request.bookingSlotId, request.userId);


                if (createUpdateResponse == CreateUpdateInspectErrorType.USER_BOOK_SAME_HOUR)
                {
                    //return Json(CreateUpdateInspectErrorType.USER_BOOK_SAME_HOUR);
                    return Json("Not Allowed to Book the same hour");
                }
                else if (createUpdateResponse == CreateUpdateInspectErrorType.UNABLE_CREATE_UPDATE)
                {
                    //return Json(CreateUpdateInspectErrorType.UNABLE_CREATE_UPDATE);
                    return Json("An errpr has occurred.Not Allowed to Book.Try again in 5 minutes");
                }else
                {
                    //return Json(CreateUpdateInspectErrorType.CREATE_UPDATE_SUCCESSFUL);
                    return Json("Booking created successfully");
                }                
            }
            else
            {
                return BadRequest(CreateUpdateInspectErrorType.INVALID_DATE);
            }

            
        }
    }
}
