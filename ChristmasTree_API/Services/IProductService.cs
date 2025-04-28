using ChristmasTreeApp.DTOs;

namespace ChristmasTreeApp.Services
{
    public interface IProductService
    {
        Task<List<ProductDto>> GetAllProducts();
        Task<List<ProductDto>> GetProductsByCategory(int categoryId);
        Task<ProductDto> GetProductById(int productId);
        Task<List<ProductDto>> GetEcoFriendlyProducts();
        Task<List<ProductDto>> GetFeaturedProducts();
        Task<List<CategoryDto>> GetCategories();
    }
}
