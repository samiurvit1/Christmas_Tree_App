using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class DesignController : ControllerBase
{
    //private readonly IDesignService _designService;

    //public DesignController(IDesignService designService)
    //{
    //    _designService = designService;
    //}

    //[HttpGet("user-designs")]
    //public async Task<IActionResult> GetUserDesigns()
    //{
    //    var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);
    //    var designs = await _designService.GetUserDesigns(userId);
    //    return Ok(designs);
    //}

    //[HttpPost("create")]
    //public async Task<IActionResult> CreateDesign(CreateDesignDto designDto)
    //{
    //    var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);
    //    var design = await _designService.CreateDesign(userId, designDto);
    //    return CreatedAtAction(nameof(GetDesign), new { id = design.DesignId }, design);
    //}

    //[HttpGet("{id}")]
    //public async Task<IActionResult> GetDesign(int id)
    //{
    //    var design = await _designService.GetDesignById(id);
    //    return Ok(design);
    //}

    //[HttpPost("{id}/save-image")]
    //public async Task<IActionResult> SaveDesignImage(int id, IFormFile imageFile)
    //{
    //    var imageUrl = await _designService.SaveDesignImage(id, imageFile);
    //    return Ok(new { imageUrl });
    //}

    //[HttpPost("{id}/calculate-sustainability")]
    //public async Task<IActionResult> CalculateSustainability(int id)
    //{
    //    var score = await _designService.CalculateSustainabilityScore(id);
    //    return Ok(new { sustainabilityScore = score });
    //}
}
