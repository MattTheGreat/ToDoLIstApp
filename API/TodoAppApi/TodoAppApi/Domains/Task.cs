using System;
namespace TodoAppApi.Domains
{
    public class Task
    {
        public string Title;
        public string Description;
        public DateTime CreateDate;
        public DateTime? ReadDate;
        public bool IsComplete;
        public bool IsDeleted;
    }
}
