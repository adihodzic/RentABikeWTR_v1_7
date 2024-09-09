using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BicikliMobilnaController : ControllerBase
    {
        private readonly IBicikliMobilnaService _service;

        public BicikliMobilnaController(IBicikliMobilnaService service)
        {
            _service = service;
        }
        [HttpGet]
        public List<Model.BicikliPregled> Get([FromQuery] BicikliSearchRequest search)
        {
            return _service.Get(search);
        }
        [HttpGet("PretragaBicikli")]
        public List<Model.BicikliPregled> GetBicikli([FromQuery] BicikliSearchRequest? search)
        {
            return _service.GetBicikli(search);
        }
        [HttpGet("{id}")]
        public Model.Bicikli GetById(int id)
        {
            return _service.GetById(id);
        }

        [HttpGet("{biciklid}/Recommend")]
        [AllowAnonymous]
        public List<Model.Bicikli> Recommend(int biciklid)
        {
            return _service.Recommend(biciklid);
        }
    }
}
