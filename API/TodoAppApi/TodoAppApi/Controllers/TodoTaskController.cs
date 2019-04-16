using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;


namespace TodoApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TodoTaskController : ControllerBase
    {
        
        public List<UserTask> _taskArray;
        // GET api/values
        [HttpGet]
        public ActionResult<IEnumerable<string>> Get()
        {

            var todoTask1 = new UserTask
            {
                Title = "Test Task 1",
                Description = "Do it now!",
                CreateDate = DateTime.Now,
                ReadDate = DateTime.Now,
                IsComplete = false

            };
            var todoTask2 = new UserTask
            {
                Title = "Test Task 2",
                Description = "Do it agin!",
                CreateDate = DateTime.Now,
                ReadDate = DateTime.Now,
                IsComplete = false

            };

            _taskArray = new List<UserTask>();
            _taskArray.Add(todoTask1);
            _taskArray.Add(todoTask2);

            return Ok(JsonConvert.SerializeObject(_taskArray));
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public ActionResult<string> Get(int id)
        {
            return "value";
        }

        // POST api/values
        [HttpPost]
        public void Post([FromBody] UserTask value)
        {            
            _taskArray.Add(value);
        }

        // PUT api/values/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/values/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }

    public class UserTask
    {
        public string Title;
        public string Description;
        public DateTime CreateDate;
        public DateTime? ReadDate;
        public bool IsComplete;
        public bool IsDeleted;
    }
}
