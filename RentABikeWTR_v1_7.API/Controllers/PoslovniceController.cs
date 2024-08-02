using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PoslovniceController : ControllerBase
    {
        private readonly IPoslovniceService _service;
        //private readonly ILoginService xservice;

        public PoslovniceController(IPoslovniceService service)
        {
            _service = service;

        }

        [HttpGet]
        public List<Model.Poslovnice> Get([FromQuery] PoslovniceSearchRequest? request)
        {
            return _service.Get(request);
        }
        [HttpGet("{id}")]
        public Model.Poslovnice GetById(int id)
        {
            return _service.GetById(id);

        }
        [HttpPut("{id}")]
        public Model.Poslovnice Update(int id, [FromBody] PoslovniceUpsertRequest request)
        {
            return _service.Update(id, request);
        }
        [HttpPatch("{id}")]
        public Model.Poslovnice Patch(int id, [FromBody] PoslovniceUpsertRequest request)
        {
            return _service.Patch(id, request);
        }
        [HttpPost]
        public Model.Poslovnice Insert(PoslovniceUpsertRequest request)
        {
            return _service.Insert(request);
        }
    }
}
        