using System;
using System.Collections.Generic;

public class CarInspections
{
  public long id { get; set; }  
    public List<inspectionDetails> bookingDetails { get; set; }
    public DateTime bookingDate { get; set; }
    public DateTime createdOn { get; set; }
    public DateTime updatedOn { get; set; }
}