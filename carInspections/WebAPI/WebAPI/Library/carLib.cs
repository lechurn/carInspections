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

        public bool createUpdateInspections(DateTime inspectionDate, string bookingSlotId, int userId)
        {
            bool updateInsertStatus = false;

            //    check if there is booking within same hour
            //       if true don't allow update / create
            //             return false;
            //       else allow create / update
            //             return true;
            //       end if

            CarInspections carInspections = getInspectionsDB(inspectionDate, 0);
            if (carInspections != null)
            {
                if (carInspections.bookingDetails!=null)
                {
                    var bookingHour = bookingSlotId.Split('-');
                    bool userBooksInSameHour = carInspections.bookingDetails.Where(p => (p.slotNo.Substring(9,2) == bookingHour[1]) && (p.bookedBy == userId)).ToList().Count > 0 ? true : false;
                    if (!userBooksInSameHour)
                    {
                        try
                        {
                            var indexOf = carInspections.bookingDetails.IndexOf(carInspections.bookingDetails.Where(p => (p.slotNo == bookingSlotId)).First());
                            carInspections.bookingDetails[indexOf].booked = true;
                            carInspections.bookingDetails[indexOf].bookedBy = userId;
                            carInspections.bookingDate = inspectionDate;                        
                            upsertInspectionsDB(carInspections, inspectionDate);
                            updateInsertStatus = true;
                        }
                        catch (Exception )
                        {

                        }                        
                    }
                }
                
            }

            return updateInsertStatus;
        }

        public void upsertInspectionsDB(CarInspections carInspections,DateTime inspectionDate)
        {
            using (SqlConnection connection = new SqlConnection(DB_Conn))
            {
                try
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand("usp_upsert_CarInspection", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.Add("@bookingDetails", SqlDbType.VarChar).Value =JsonConvert.SerializeObject(carInspections.bookingDetails).ToString();
                    command.Parameters.Add("@bookingDate", SqlDbType.Date).Value = inspectionDate;
                    command.CommandTimeout = 5;

                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    /*Handle error*/
                }
            }
        }


        public CarInspections getInspectionsDB(DateTime inspectionDate, int userId)
        {
            CarInspections carInspections = new CarInspections();
            DataSet dataSet = new DataSet();
            using (SqlConnection connection = new SqlConnection(DB_Conn))
            {
                try
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand("SELECT id,bookingDate,bookingDetails,createdOn,updatedOn from Inspection WHERE bookingDate = @bookingDate", connection);
                    command.CommandType = System.Data.CommandType.Text;
                    command.Parameters.Add("@bookingDate", SqlDbType.Date).Value = inspectionDate;
                    command.CommandTimeout = 5;


                    dataSet.Tables.Clear();
                    var da = new SqlDataAdapter(command);
                    da.Fill(dataSet, "Inspection");

                    if (dataSet.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow row in dataSet.Tables[0].Rows)
                        {
                            carInspections.bookingDate = DateTime.Parse(row[1].ToString());
                            carInspections.bookingDetails = JsonConvert.DeserializeObject<List<inspectionDetails>>(row[2].ToString());
                            carInspections.createdOn = DateTime.Parse(row[3].ToString());
                            carInspections.updatedOn = DateTime.Parse(row[4].ToString()==null? DateTime.Now.ToString("yyyy-MM-dd") : row[4].ToString());
                        }
                    }
                    else {
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
                catch (Exception ex)
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