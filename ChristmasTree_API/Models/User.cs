using System.Net;

namespace ChristmasTreeApp.Models
{
    public class User
    {
        public int UserId { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string PasswordHash { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime CreatedDate { get; set; }
        public bool IsGuest { get; set; }
        public ICollection<Address> Addresses { get; set; }
        public ICollection<Order> Orders { get; set; }
        public ICollection<TreeDesign> TreeDesigns { get; set; }
        public ICollection<Referral> Referrals { get; set; }
    }
}
