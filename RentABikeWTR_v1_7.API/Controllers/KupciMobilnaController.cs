using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class KupciMobilnaController : ControllerBase
    {
        private readonly IKupciMobilnaService _service;

        public KupciMobilnaController(IKupciMobilnaService service)
        {
            _service = service;
        }
        [HttpGet]
        public List<Model.Kupci> Get([FromQuery] KupciSearchRequest search)
        {
            return _service.Get(search);
        }
        [HttpGet("{id}")]
        public Model.Kupci GetById(int id)
        {
            return _service.GetById(id);
        }
        [HttpPut("{id}")]
        public Model.Kupci Update(int id, [FromBody] KupciUpdateRequest request)
        {
            return _service.Update(id, request);
        }
    }
}
