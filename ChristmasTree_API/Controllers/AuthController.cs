using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    //private readonly IAuthService _authService;

    //public AuthController(IAuthService authService)
    //{
    //    _authService = authService;
    //}

    //[HttpPost("register")]
    //public async Task<IActionResult> Register(UserRegisterDto registerDto)
    //{
    //    var response = await _authService.Register(registerDto);
    //    return Ok(response);
    //}

    //[HttpPost("login")]
    //public async Task<IActionResult> Login(UserLoginDto loginDto)
    //{
    //    var response = await _authService.Login(loginDto);
    //    return Ok(response);
    //}

    //[HttpPost("refresh-token")]
    //public async Task<IActionResult> RefreshToken(RefreshTokenRequest request)
    //{
    //    var response = await _authService.RefreshToken(request);
    //    return Ok(response);
    //}
}
