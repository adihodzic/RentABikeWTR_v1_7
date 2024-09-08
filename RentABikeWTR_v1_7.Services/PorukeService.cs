using Azure.Core;
//using EasyNetQ;
using MapsterMapper;
using Newtonsoft.Json;
using RabbitMQ.Client;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{


    public class PorukeService : IPorukeService
    {
        private readonly RentABikeWTR_v1_7Context _context;
        private readonly IMapper _mapper;

        public PorukeService(RentABikeWTR_v1_7Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public List<Model.Poruke> Get(PorukeSearchRequest? request)
        {
            var query = _context.Poruke.AsQueryable();

            var lista = query.ToList();
            return _mapper.Map<List<Model.Poruke>>(lista);


        }


        


        public Model.Poruke Insert(PorukeUpsertRequest request)
        {

            try
            {
                var entity = _mapper.Map<Database.Poruke>(request);
                _context.Poruke.Add(entity);
                _context.SaveChanges();

                var tekst = request.Tekst;
                SendMessageToQueue(tekst);



                return _mapper.Map<Model.Poruke>(entity);
            }
            catch (Exception ex)
            {

                //Log the exception(use a proper logging framework, e.g., Serilog, NLog)
                        Console.WriteLine($"An error occurred: {ex.Message}");
                Console.WriteLine($"Stack Trace: {ex.StackTrace}");

                // Optionally, rethrow the exception or return an error response
                throw new InvalidOperationException("An error occurred while inserting and publishing the message", ex);
            }
        }
        ///////////////////////////////////////////////////////////
        private void SendMessageToQueue(string message)
        {
            ////////////////////////////////////
            Console.WriteLine("Hello, World Producer!");
            var factory = new ConnectionFactory
            {
                HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rentabikewtr-rabbitmq",
                Port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? "5672"),
                UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "admin",
                Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest",
            };
            factory.ClientProvidedName = "Rabbit Testiranje";

            using (IConnection connection = factory.CreateConnection())
            using (IModel channel = connection.CreateModel())
            {
                string exchangeName = "direct";
                string routingKey = "email-key";
                string queueName = "email-name";

                // Declare exchange, queue, and binding
                channel.ExchangeDeclare(exchange: exchangeName, type: ExchangeType.Direct);
                channel.QueueDeclare(queueName, true, false, false, null);
                channel.QueueBind(queueName, exchangeName, routingKey, null);
                //var message = "Probni tekst";
                // Publish message
                string emailModelJson = JsonConvert.SerializeObject(message);
                byte[] messageBodyBytes = Encoding.UTF8.GetBytes(emailModelJson);
                channel.BasicPublish(exchange: exchangeName, routingKey: routingKey, basicProperties: null, body: messageBodyBytes);

                Console.WriteLine("Message published to exchange");
            }
            ////////////////////////////////////////
            //    var factory = new ConnectionFactory();
            //    //{
            //    //    HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost",
            //    //    Port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? "5672"),
            //    //    UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "admin",
            //    //    Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest",
            //    //};
            //    factory.ClientProvidedName = "Rabbit Test";

            //    using (IConnection connection = factory.CreateConnection())
            //    using (IModel channel = connection.CreateModel())
            //    {
            //        string exchangeName = "direct-exchange";
            //        string routingK = "email-key";
            //        //string queueName = "EmailQueue";

            //        // Declare exchange, queue, and binding
            //        channel.ExchangeDeclare(exchange:exchangeName, type:ExchangeType.Direct);
            //        //channel.QueueDeclare(queueName, true, false, false, null);
            //        //channel.QueueBind(queueName, exchangeName, routingKey, null);

            //        // Publish message
            //        string emailModelJson = JsonConvert.SerializeObject(message);
            //        byte[] messageBodyBytes = Encoding.UTF8.GetBytes(emailModelJson);
            //        channel.BasicPublish(exchange:exchangeName, routingKey:routingK, basicProperties:null, body:messageBodyBytes);

            //        Console.WriteLine("Message published to exchange");
        }
    }
    ///////////

    /// </summary>
    /// <param name="message"></param>
    //private void SendMessageToQueue(string message)
    //{
    //    var factory = new ConnectionFactory
    //    {
    //        HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost",
    //        Port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? "5672"),
    //        UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest",
    //        Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest",
    //    };
    //    factory.ClientProvidedName = "Rabbit Test";

    //    using IConnection connection = factory.CreateConnection();
    //    using IModel channel = connection.CreateModel();

    //    string exchangeName = "EmailExchange";            
    //    string queueName = "EmailQueue";
    //    string routingKey = "email";

    //    // Declare the exchange and queue
    //    channel.ExchangeDeclare(exchangeName, ExchangeType.Direct);
    //    channel.QueueDeclare(queueName, true, false, false, null);
    //    channel.QueueBind(queueName, exchangeName, "email", null);

    //    string emailModelJson = JsonConvert.SerializeObject(message);
    //    byte[] messageBodyBytes = Encoding.UTF8.GetBytes(emailModelJson);

    //    // Publish the message to the exchange using the routing key
    //    channel.BasicPublish(exchangeName, "email", null, messageBodyBytes);

    //    Console.WriteLine("Message published to exchange");
    //}

    //public Model.Poruke Insert(PorukeUpsertRequest request)
    //{
    //    try
    //    {
    //        // Map the request to the database entity
    //        var entity = _mapper.Map<Database.Poruke>(request);

    //        // Add the entity and save it to the database
    //        _context.Poruke.Add(entity);
    //        _context.SaveChanges();

    //        // Map the saved entity back to the model
    //        var result = _mapper.Map<Model.Poruke>(entity);
    //        var tekst = request.Tekst;
    //        // Publish the message to RabbitMQ
    //        var bus = RabbitHutch.CreateBus("host=localhost:5672");
    //        bus.PubSub.Publish(tekst);


    //        return result;
    //    }
    //    catch (Exception ex)
    //    {
    //        // Log the exception (use a proper logging framework, e.g., Serilog, NLog)
    //        Console.WriteLine($"An error occurred: {ex.Message}");
    //        Console.WriteLine($"Stack Trace: {ex.StackTrace}");

    //        // Optionally, rethrow the exception or return an error response
    //        throw new InvalidOperationException("An error occurred while inserting and publishing the message", ex);
    //    }
    //}




}




