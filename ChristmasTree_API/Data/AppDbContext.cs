namespace ChristmasTreeApp.Data
{
    using ChristmasTreeApp.Models;
    using Microsoft.EntityFrameworkCore;
    using System.Collections.Generic;
    using System.Reflection.Emit;

    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<Address> Addresses { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<TreeStylist> TreeStylists { get; set; }
        public DbSet<StylistAvailability> StylistAvailabilities { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderItem> OrderItems { get; set; }
        public DbSet<StylistBooking> StylistBookings { get; set; }
        public DbSet<TreeDesign> TreeDesigns { get; set; }
        public DbSet<Referral> Referrals { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Configure relationships and constraints
            //modelBuilder.Entity<Address>()
            //    .HasOne(a => a.User)
            //    .WithMany(u => u.Addresses)
            //    .HasForeignKey(a => a.UserId);

            // Add other configurations as needed

            modelBuilder.Entity<StylistAvailability>(entity =>
            {
                entity.HasNoKey(); // Mark as keyless
            });

            //modelBuilder.Entity<StylistAvailability>()
            //.HasOne(sa => sa.Stylist) // Define the navigation property
            //.WithMany(ts => ts.Availabilities) // Define the inverse navigation property
            //.HasForeignKey(sa => sa.StylistId); // Define the foreign key


            base.OnModelCreating(modelBuilder);
        }
    }
}
