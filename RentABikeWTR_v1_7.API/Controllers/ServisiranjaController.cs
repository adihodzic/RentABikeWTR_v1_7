using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class ServisiranjaController : ControllerBase
    {
        private readonly IServisiranjaService _service;
        //private readonly ILoginService xservice;

        public ServisiranjaController(IServisiranjaService service)
        {
            _service = service;

        }

        [HttpGet]
        public List<Model.Servisiranja> Get([FromQuery] int? biciklid)
        {
            return _service.Get(biciklid);
        }
        [HttpGet("{id}")]
        public Model.Servisiranja GetById(int id)
        {
            return _service.GetById(id);

        }
        [HttpPut("{id}")]
        public Model.Servisiranja Update(int id, [FromBody] ServisiranjaUpsertRequest request)
        {
            return _service.Update(id, request);
        }
        [HttpPatch("{id}")]
        public Model.Servisiranja Patch(int id, [FromBody] ServisiranjaUpsertRequest request)
        {
            return _service.Patch(id, request);
        }
        [HttpPost]
        public Model.Servisiranja Insert(ServisiranjaUpsertRequest request)
        {
            return _service.Insert(request);
        }
        [HttpGet("Pregled")]
        public List<Model.ServisiranjaPregled> GetServisiranjaPregled(int? id)
        {
            return _service.GetServisiranjaPregled(id);
        }
    }
}
