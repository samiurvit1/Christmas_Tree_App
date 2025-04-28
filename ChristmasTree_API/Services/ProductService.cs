using ChristmasTreeApp.Data;
using ChristmasTreeApp.DTOs;
using Microsoft.EntityFrameworkCore;

namespace ChristmasTreeApp.Services
{
    public class ProductService : IProductService
    {
        private readonly AppDbContext _context;

        public ProductService(AppDbContext context)
        {
            _context = context;
        }

        public async Task<List<ProductDto>> GetAllProducts()
        {
            return await _context.Products
                .Include(p => p.Category)
                .Select(p => new ProductDto
                {
                    ProductId = p.ProductId,
                    CategoryId = p.CategoryId,
                    CategoryName = p.Category.Name,
                    Name = p.Name,
                    Description = p.Description,
                    Price = p.Price,
                    ImageUrl = p.ImageUrl,
                    IsEcoFriendly = p.IsEcoFriendly,
                    StockQuantity = p.StockQuantity
                })
                .ToListAsync();
        }

        public async Task<List<ProductDto>> GetProductsByCategory(int categoryId)
        {
            return await _context.Products
                .Where(p => p.CategoryId == categoryId)
                .Include(p => p.Category)
                .Select(p => new ProductDto
                {
                    ProductId = p.ProductId,
                    CategoryId = p.CategoryId,
                    CategoryName = p.Category.Name,
                    Name = p.Name,
                    Description = p.Description,
                    Price = p.Price,
                    ImageUrl = p.ImageUrl,
                    IsEcoFriendly = p.IsEcoFriendly,
                    StockQuantity = p.StockQuantity
                })
                .ToListAsync();
        }

        public async Task<ProductDto> GetProductById(int productId)
        {
            var product = await _context.Products
                .Include(p => p.Category)
                .FirstOrDefaultAsync(p => p.ProductId == productId);

            if (product == null) return null;

            return new ProductDto
            {
                ProductId = product.ProductId,
                CategoryId = product.CategoryId,
                CategoryName = product.Category.Name,
                Name = product.Name,
                Description = product.Description,
                Price = product.Price,
                ImageUrl = product.ImageUrl,
                IsEcoFriendly = product.IsEcoFriendly,
                StockQuantity = product.StockQuantity
            };
        }

        public async Task<List<ProductDto>> GetEcoFriendlyProducts()
        {
            return await _context.Products
                .Where(p => p.IsEcoFriendly)
                .Include(p => p.Category)
                .Select(p => new ProductDto
                {
                    ProductId = p.ProductId,
                    CategoryId = p.CategoryId,
                    CategoryName = p.Category.Name,
                    Name = p.Name,
                    Description = p.Description,
                    Price = p.Price,
                    ImageUrl = p.ImageUrl,
                    IsEcoFriendly = p.IsEcoFriendly,
                    StockQuantity = p.StockQuantity
                })
                .ToListAsync();
        }

        public async Task<List<ProductDto>> GetFeaturedProducts()
        {
            return await _context.Products
                .Where(p => p.StockQuantity>=50)
                .Include(p => p.Category)
                .Select(p => new ProductDto
                {
                    ProductId = p.ProductId,
                    CategoryId = p.CategoryId,
                    CategoryName = p.Category.Name,
                    Name = p.Name,
                    Description = p.Description,
                    Price = p.Price,
                    ImageUrl = p.ImageUrl,
                    IsEcoFriendly = p.IsEcoFriendly,
                    StockQuantity = p.StockQuantity
                })
                .ToListAsync();
        }

        public async Task<List<CategoryDto>> GetCategories()
        {
            return await _context.Categories
                .Select(c => new CategoryDto
                {
                    CategoryId = c.CategoryId,
                    Name = c.Name,
                    Description = c.Description,
                    Icon = c.Icon
                })
                .ToListAsync();
        }
    }
}
