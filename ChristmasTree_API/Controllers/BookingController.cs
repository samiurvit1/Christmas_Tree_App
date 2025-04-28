using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class BookingController : ControllerBase
{
    //private readonly IBookingService _bookingService;

    //public BookingController(IBookingService bookingService)
    //{
    //    _bookingService = bookingService;
    //}

    //[HttpGet("available-stylists")]
    //public async Task<IActionResult> GetAvailableStylists([FromQuery] DateTime date, [FromQuery] int durationHours)
    //{
    //    var stylists = await _bookingService.GetAvailableStylists(date, durationHours);
    //    return Ok(stylists);
    //}

    //[HttpPost("create")]
    //public async Task<IActionResult> CreateBooking(CreateBookingDto bookingDto)
    //{
    //    var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);
    //    var booking = await _bookingService.CreateBooking(userId, bookingDto);
    //    return CreatedAtAction(nameof(GetBooking), new { id = booking.BookingId }, booking);
    //}

    //[HttpGet("user-bookings")]
    //public async Task<IActionResult> GetUserBookings()
    //{
    //    var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);
    //    var bookings = await _bookingService.GetUserBookings(userId);
    //    return Ok(bookings);
    //}

    //[HttpPost("{id}/cancel")]
    //public async Task<IActionResult> CancelBooking(int id)
    //{
    //    var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);
    //    await _bookingService.CancelBooking(userId, id);
    //    return NoContent();
    //}

    //[HttpPost("{id}/complete")]
    //[Authorize(Roles = "Stylist")]
    //public async Task<IActionResult> CompleteBooking(int id)
    //{
    //    await _bookingService.CompleteBooking(id);
    //    return NoContent();
    //}
}
