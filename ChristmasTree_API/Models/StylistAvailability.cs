namespace ChristmasTreeApp.Models
{
    public class StylistAvailability
    {
        public int StylistAvailabilityId { get; set; }
        public int StylistId { get; set; }
        //public TreeStylist Stylist { get; set; }
        public int DayOfWeek { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
    }
}
