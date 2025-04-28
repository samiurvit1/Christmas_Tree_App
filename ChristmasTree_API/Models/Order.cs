namespace ChristmasTreeApp.Models
{
    public class Order
    {
        public int OrderId { get; set; }
        public int UserId { get; set; }
        //public User User { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public string Status { get; set; }
        public int ShippingAddressId { get; set; }
        //public Address ShippingAddress { get; set; }
        public string PaymentMethod { get; set; }
        //public ICollection<OrderItem> OrderItems { get; set; }
        //public StylistBooking StylistBooking { get; set; }
    }
}
