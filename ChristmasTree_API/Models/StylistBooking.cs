namespace ChristmasTreeApp.Models
{
    public class StylistBooking
    {
        public int StylistBookingId { get; set; }
        public int OrderId { get; set; }
        //public Order Order { get; set; }
        public int StylistId { get; set; }
        //public TreeStylist Stylist { get; set; }
        public DateTime BookingDate { get; set; }
        public int AddressId { get; set; }
        //public Address Address { get; set; }
        public string Notes { get; set; }
        public string Status { get; set; }
    }
}
