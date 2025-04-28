namespace ChristmasTreeApp.Models
{
    public class Referral
    {
        public int ReferralId { get; set; }
        public int ReferrerId { get; set; }
        public User Referrer { get; set; }
        public string ReferredEmail { get; set; }
        public string ReferredPhone { get; set; }
        public DateTime ReferralDate { get; set; }
        public bool IsCompleted { get; set; }
    }
}
