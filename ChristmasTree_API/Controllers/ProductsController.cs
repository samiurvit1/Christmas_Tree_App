using ChristmasTreeApp.Data;
using ChristmasTreeApp.DTOs;
using ChristmasTreeApp.Models;
using ChristmasTreeApp.Services;
using Microsoft.AspNetCore.Mvc;

namespace ChristmasTreeApp.Controllers
{

    [ApiController]
    [Route("api/[controller]")]
    public class ProductsController : ControllerBase
    {
        private readonly IProductService _productService;

        public ProductsController(IProductService productService)
        {
            _productService = productService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllProducts()
        {
            var products = await _productService.GetAllProducts();
            return Ok(products);
        }

        [HttpGet("category/{categoryId}")]
        public async Task<IActionResult> GetProductsByCategory(int categoryId)
        {
            var products = await _productService.GetProductsByCategory(categoryId);
            return Ok(products);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetProductById(int id)
        {
            var product = await _productService.GetProductById(id);
            if (product == null) return NotFound();
            return Ok(product);
        }

        [HttpGet("eco-friendly")]
        public async Task<IActionResult> GetEcoFriendlyProducts()
        {
            var products = await _productService.GetEcoFriendlyProducts();
            return Ok(products);
        }


        [HttpGet("featured")]
        public async Task<IActionResult> GetFeaturedProducts()
        {
            var products = await _productService.GetFeaturedProducts();
            return Ok(products);
        }
        [HttpGet("categories")]
        public async Task<IActionResult> GetCategories()
        {
            var categories = await _productService.GetCategories();
            return Ok(categories);
        }
    }
}
