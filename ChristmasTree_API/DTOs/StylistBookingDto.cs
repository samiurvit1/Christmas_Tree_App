namespace ChristmasTreeApp.DTOs
{
    public class StylistBookingDto
    {
        public int StylistId { get; set; }
        public string StylistName { get; set; }
        public DateTime BookingDate { get; set; }
        public int AddressId { get; set; }
        public string Notes { get; set; }
    }
}
