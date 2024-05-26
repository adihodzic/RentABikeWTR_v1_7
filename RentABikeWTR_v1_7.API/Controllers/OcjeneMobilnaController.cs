using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OcjeneMobilnaController : ControllerBase
    {
        private readonly IOcjeneMobilnaService _service;

        public OcjeneMobilnaController(IOcjeneMobilnaService service)
        {
            _service = service;
        }
        [HttpGet]
        public List<Model.Ocjene> Get([FromQuery] OcjeneSearchRequest search)
        {
            return _service.Get(search);
        }
        [HttpGet("{id}")]
        public Model.Ocjene GetById(int id)
        {
            return _service.GetById(id);
        }
        [HttpPost]
        public Model.Ocjene Insert(OcjeneUpsertRequest request)
        {
            return _service.Insert(request);
        }
    }
}
