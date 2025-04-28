namespace ChristmasTreeApp.DTOs
{
    public class OrderDto
    {
        public int OrderId { get; set; }
        public int UserId { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public string Status { get; set; }
        public int ShippingAddressId { get; set; }
        public string PaymentMethod { get; set; }
        public List<OrderItemDto> OrderItems { get; set; }
        public StylistBookingDto StylistBooking { get; set; }
    }
}
