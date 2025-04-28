namespace ChristmasTreeApp.DTOs
{
    public class TreeDesignDto
    {
        public int DesignId { get; set; }
        public int UserId { get; set; }
        public string Name { get; set; }
        public string DesignData { get; set; }
        public DateTime CreatedDate { get; set; }
        public bool IsShared { get; set; }
    }
}
