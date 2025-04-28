namespace ChristmasTreeApp.Models
{
    public class TreeStylist
    {
        public int TreeStylistId { get; set; }
        public string Name { get; set; }
        public string Bio { get; set; }
        public decimal? Rating { get; set; }
        public string ImageUrl { get; set; }
        public decimal HourlyRate { get; set; }
        //public ICollection<StylistAvailability> Availabilities { get; set; }
        //public ICollection<StylistBooking> Bookings { get; set; }
    }

}
