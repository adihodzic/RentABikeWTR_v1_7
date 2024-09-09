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
    public class DrzaveMobilnaController : ControllerBase
    {
        private readonly IDrzaveMobilnaService _service;

        public DrzaveMobilnaController(IDrzaveMobilnaService service)
        {
            _service = service;
        }
        [HttpGet]
        public List<Model.Drzave> Get([FromQuery] DrzaveSearchRequest search)
        {
            return _service.Get(search);
        }
        [HttpGet("{id}")]
        public Model.Drzave GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
