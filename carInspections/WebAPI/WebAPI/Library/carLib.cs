using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebAPI.Properties;
namespace carlibrary
{
    public class carLib
    {
        string DB_Conn = Settings.Default.DB_Conn;


        public CarInspections getInspections(DateTime inspectionDate)
        {
            CarInspections carInspections = new CarInspections();

            carInspections = getInspectionsDB(inspectionDate, 0);

            return carInspections;

        }

        public void createUpdateInspections()
        {

        }

        public CarInspections getInspectionsDB(DateTime inspectionDate, int userId)
        {
            CarInspections carInspections = new CarInspections();

            using (SqlConnection connection = new SqlConnection(DB_Conn))
            {
                try
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand("SELECT id,bookingDetails,bookingDate,createdOn,updatedOn from Inspection WHERE bookingDate = @bookingDate", connection);
                    command.CommandType = System.Data.CommandType.Text;
                    command.Parameters.Add("@bookingDate", SqlDbType.Date).Value = inspectionDate;
                    command.CommandTimeout = 5;

                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            //carInspections.id = long.Parse(reader.GetString(0));
                            carInspections.bookingDate = DateTime.Parse(reader.GetString(1));
                            carInspections.bookingDetails = JsonConvert.DeserializeObject<List<inspectionDetails>>(reader.GetString(2));
                            carInspections.createdOn = DateTime.Parse(reader.GetString(3));
                            carInspections.updatedOn = DateTime.Parse(reader.GetString(4));
                        }
                    } else
                    {
                        DayOfWeek daySelected = inspectionDate.DayOfWeek;
                        if (daySelected == DayOfWeek.Sunday)
                        {

                        } else if (daySelected == DayOfWeek.Saturday || daySelected != DayOfWeek.Sunday)
                        {
                            carInspections.bookingDate = inspectionDate;
                            carInspections.bookingDetails = createInspectionSlot(inspectionDate);
                            carInspections.createdOn = DateTime.UtcNow;
                            carInspections.updatedOn = DateTime.UtcNow;
                        }                       
                    }
                }
                catch (Exception)
                {
                    /*Handle error*/
                }
            }

            return carInspections;
        }

        private List<inspectionDetails> createInspectionSlot(DateTime inspectionDate)
        {
            List<inspectionDetails> inspectionsList = new List<inspectionDetails>();
            DateTime startDate = DateTime.Parse(inspectionDate.ToString("yyyy-MM-dd 09:00"));
            DateTime endDate = DateTime.Parse(inspectionDate.ToString("yyyy-MM-dd 18:00"));
            DateTime startDate_30mins = startDate.AddMinutes(30);
            int slotNoCtr = 1;
            DayOfWeek daySelected = inspectionDate.DayOfWeek;
            int availableSlots = daySelected==DayOfWeek.Saturday? 4: 2;

            while (startDate.AddMinutes(30) <= endDate)
            {
                for (var availableSlot = 1; availableSlot <= availableSlots; availableSlot++)
                {
                    inspectionsList.Add(new inspectionDetails
                    {
                        booked = false,
                        timeSlot = String.Format("{0}-{1}", startDate.ToString("HH:mm"), startDate.AddMinutes(30).ToString("HH:mm")),
                        slotNo = string.Format("{0}-{1}-{2}", startDate.ToString("yyyyMMdd"), startDate.ToString("HH"), slotNoCtr)
                    });
                    slotNoCtr += 1;

                }
                startDate = startDate.AddMinutes(30);
            }

            return inspectionsList;
        }
    }
}