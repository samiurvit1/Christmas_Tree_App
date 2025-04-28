namespace ChristmasTreeApp.Models
{
    public class TreeDesign
    {
        public int TreeDesignId { get; set; }
        public int UserId { get; set; }
        //public User User { get; set; }
        public string Name { get; set; }
        public string DesignData { get; set; }
        public DateTime CreatedDate { get; set; }
        public bool IsShared { get; set; }
    }
}
