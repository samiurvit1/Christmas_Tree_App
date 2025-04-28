namespace ChristmasTreeApp.Models
{
    public class Address
    {
        public int AddressId { get; set; }
        public int UserId { get; set; }
        //public User User { get; set; }
        public string Street { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string PostalCode { get; set; }
        public string Country { get; set; }
        public bool IsDefault { get; set; }
        //public ICollection<Order> Orders { get; set; }
        //public ICollection<StylistBooking> StylistBookings { get; set; }
    }
}
