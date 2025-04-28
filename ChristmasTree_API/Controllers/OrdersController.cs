using ChristmasTreeApp.Data;
using ChristmasTreeApp.DTOs;
using ChristmasTreeApp.Models;
using ChristmasTreeApp.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ChristmasTreeApp.Controllers
{

    [ApiController]
    [Route("api/[controller]")]
    public class OrdersController : ControllerBase
    {
        private readonly AppDbContext _context;

        public OrdersController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost]
        public async Task<IActionResult> CreateOrder([FromBody] OrderDto orderDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Create order
            var order = new Order
            {
                UserId = orderDto.UserId,
                OrderDate = DateTime.UtcNow,
                TotalAmount = orderDto.TotalAmount,
                Status = "Pending",
                ShippingAddressId = orderDto.ShippingAddressId,
                PaymentMethod = orderDto.PaymentMethod
            };

            _context.Orders.Add(order);
            await _context.SaveChangesAsync();

            // Add order items
            foreach (var item in orderDto.OrderItems)
            {
                var orderItem = new OrderItem
                {
                    OrderId = order.OrderId,
                    ProductId = item.ProductId,
                    Quantity = item.Quantity,
                    UnitPrice = item.UnitPrice,
                    CustomizationDetails = item.CustomizationDetails
                };
                _context.OrderItems.Add(orderItem);
            }

            // Add stylist booking if exists
            if (orderDto.StylistBooking != null)
            {
                var booking = new StylistBooking
                {
                    OrderId = order.OrderId,
                    StylistId = orderDto.StylistBooking.StylistId,
                    BookingDate = orderDto.StylistBooking.BookingDate,
                    AddressId = orderDto.StylistBooking.AddressId,
                    Notes = orderDto.StylistBooking.Notes,
                    Status = "Pending"
                };
                _context.StylistBookings.Add(booking);
            }

            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetOrderById), new { id = order.OrderId }, orderDto);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetOrderById(int id)
        {
            var order = await _context.Orders
                //.Include(o => o.OrderItems)
                    //.ThenInclude(oi => oi.Product)
                //.Include(o => o.StylistBooking)
                    //.ThenInclude(sb => sb.Stylist)
                //.Include(o => o.ShippingAddress)
                .FirstOrDefaultAsync(o => o.OrderId == id);

            if (order == null)
            {
                return NotFound();
            }

            var orderDto = new OrderDto
            {
                OrderId = order.OrderId,
                UserId = order.UserId,
                OrderDate = order.OrderDate,
                TotalAmount = order.TotalAmount,
                Status = order.Status,
                ShippingAddressId = order.ShippingAddressId,
                PaymentMethod = order.PaymentMethod,
                //OrderItems = order.OrderItems.Select(oi => new OrderItemDto
                //{
                //    ProductId = oi.ProductId,
                //    ProductName = oi.Product.Name,
                //    Quantity = oi.Quantity,
                //    UnitPrice = oi.UnitPrice,
                //    CustomizationDetails = oi.CustomizationDetails
                //}).ToList(),
                //StylistBooking = order.StylistBooking == null ? null : new StylistBookingDto
                //{
                //    StylistId = order.StylistBooking.StylistId,
                //    StylistName = order.StylistBooking.Stylist.Name,
                //    BookingDate = order.StylistBooking.BookingDate,
                //    AddressId = order.StylistBooking.AddressId,
                //    Notes = order.StylistBooking.Notes
                //}
            };

            return Ok(orderDto);
        }
    }
}
