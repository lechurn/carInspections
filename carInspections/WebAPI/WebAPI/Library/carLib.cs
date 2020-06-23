using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace carlibrary
{
    public class carLib
    {
        public List<CarInspections> getInspections()
        {
            List<CarInspections> carInspections = new List<CarInspections>();

            carInspections.Add(new CarInspections
            {
                 bookingDate = DateTime.Now,                
            });

            return carInspections;

        }

        public void createUpdateInspections()
        {

        }

        public List<CarInspections> getInspectionsDB(DateTime inspectionDate, int userId)
        {
            List<CarInspections> carInspections = new List<CarInspections>();


            return carInspections;
        }
        
    }
}