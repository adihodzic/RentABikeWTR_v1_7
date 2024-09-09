// See https://aka.ms/new-console-template for more information

//using EasyNetQ;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using RentABikeWTR_v1_7.Services;
using System.Text;
using Newtonsoft.Json;
//using RentABikeWTR_v1_7.Model;
using Microsoft.Extensions.Options;
using System.Net.Mail;
using RentABikeWTR.Subscriber;
using RentABikeWTR_v1_7.Services.Database;
using Microsoft.EntityFrameworkCore;

class Program
{
    static void Main(string[] args)
    {
        
        var connectionString = Environment.GetEnvironmentVariable("ConnectionStrings:konekcija")
            ?? "Server=localhost,1439;TrustServerCertificate=true;Database=IB210282;User=sa;Password=Renta101!;Encrypt=true;ConnectRetryCount=0";

        // Define options for DbContext using the connection string
        var optionsBuilder = new DbContextOptionsBuilder<RentABikeWTR_v1_7Context>();
        optionsBuilder.UseSqlServer(connectionString);

        // Initialize the DbContext
        var context = new RentABikeWTR_v1_7Context(optionsBuilder.Options);

        var emailSettings = new EmailSettings
        {
            SmtpServer = Environment.GetEnvironmentVariable("SMTP_SERVER") ?? "smtp.gmail.com",
            SmtpPort = int.Parse(Environment.GetEnvironmentVariable("SMTP_PORT") ?? "587"),
            SenderEmail = Environment.GetEnvironmentVariable("SENDER_EMAIL") ?? "appadi172@gmail.com",
            SenderName = Environment.GetEnvironmentVariable("SENDER_NAME") ?? "help-desk",
            UserName = Environment.GetEnvironmentVariable("SMTP_USERNAME") ?? "appadi172@gmail.com",
            Password = Environment.GetEnvironmentVariable("SMTP_PASSWORD") ?? "tijxgzdzdzekrtie",
            EnableSsl = bool.Parse(Environment.GetEnvironmentVariable("ENABLE_SSL") ?? "true")
        };

        var emailConsumer = new EmailConsumer(emailSettings,context);
        emailConsumer.Start();

        Console.WriteLine("Press [enter] to exit.");
        Console.ReadLine();
    }
}



//var emailSettings = new EmailSettings
//{
//    SmtpServer = Environment.GetEnvironmentVariable("SMTP_SERVER") ?? "smtp.gmail.com",
//    SmtpPort = int.Parse(Environment.GetEnvironmentVariable("SMTP_PORT") ?? "587"),
//    SenderEmail = Environment.GetEnvironmentVariable("SENDER_EMAIL") ?? "appadi172@gmail.com",
//    SenderName = Environment.GetEnvironmentVariable("SENDER_NAME") ?? "help-desk",
//    UserName = Environment.GetEnvironmentVariable("USERNAME") ?? "appadi172@gmail.com",
//    Password = Environment.GetEnvironmentVariable("EMAIL_PASSWORD") ?? "Rentacar101!",
//    EnableSsl = bool.Parse(Environment.GetEnvironmentVariable("ENABLE_SSL") ?? "true")
//};

//// Pass the email settings directly into EmailService
//var emailService = new EmailService(Options.Create(emailSettings));
///////////////////////////////////////////////////////////////////////////////////////////////////
//string exchangeName = "direct";
//        string routingK = "email-key";
//        string queueName = "email-name";

//        var factory = new ConnectionFactory
//        {
//            HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost",
//            Port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? "5672"),
//            UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "admin",
//            Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest",
//        };
//        {
//            using (IConnection connection = factory.CreateConnection())
//            using (IModel channel = connection.CreateModel())
//            {
//                // Declare exchange, queue, and binding
//                channel.ExchangeDeclare(exchange: exchangeName, ExchangeType.Direct);
//                channel.QueueDeclare(queue: queueName, durable: true, exclusive: false, autoDelete: false, arguments: null);
//                channel.QueueBind(queue: queueName, exchange: exchangeName, routingKey: routingK);

//                var consumer = new EventingBasicConsumer(channel);
//                consumer.Received += (sender, args) =>
//                {
//                    var body = args.Body.ToArray();
//                    string message = Encoding.UTF8.GetString(body);

//                    Console.WriteLine($"Message received: {message}");
//                    // Deserialize and process the email

//                    Console.WriteLine($"Email sent: {message}");
//                    EmailModel emailModel = JsonConvert.DeserializeObject<EmailModel>(message);
//                    if (emailModel != null)
//                    {
//                        var emailService = new EmailService(Options.Create(emailSettings));
//                        emailService.SendEmail(emailModel);
//                    }


//                };

//                channel.BasicConsume(queue: queueName, autoAck: true, consumer: consumer);
//                Console.WriteLine("Waiting for messages. Press Q to quit.");
//                Console.ReadLine();
//            }
//        }

//        ////////////////////////////////////////////////////////////////////////////////////
//        //string exchangeName = "direct-exchange";
//        //string routingK = "email-key";
//        //string queueName = "email-name";

//        //var factory = new ConnectionFactory();
//        ////{
//        ////    HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost",
//        ////    Port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? "5672"),
//        ////    UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest",
//        ////    Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest",
//        ////};
//        //{
//        //    using (IConnection connection = factory.CreateConnection())
//        //    using (IModel channel = connection.CreateModel())
//        //    {
//        //        // Declare exchange, queue, and binding
//        //        channel.ExchangeDeclare(exchange:exchangeName, ExchangeType.Direct);
//        //        channel.QueueDeclare(queue:queueName, durable:true, exclusive:false, autoDelete:false, arguments:null);
//        //        channel.QueueBind(queue:queueName, exchange:exchangeName, routingKey:routingK);

//        //        var consumer = new EventingBasicConsumer(channel);
//        //        consumer.Received += (sender, args) =>
//        //        {
//        //            var body = args.Body.ToArray();
//        //            string message = Encoding.UTF8.GetString(body);

//        //            Console.WriteLine($"Message received: {message}");

//        //            // Deserialize and process the email
//        //            EmailModel emailModel = JsonConvert.DeserializeObject<EmailModel>(message);
//        //            if (emailModel != null)
//        //            {
//        //                var emailService = new EmailService(Options.Create(emailSettings));
//        //                emailService.SendEmail(emailModel);
//        //            }
//        //            //channel.BasicAck(args.DeliveryTag, false);
//        //        };

//        //        channel.BasicConsume(queue:queueName, autoAck:true, consumer:consumer);
//        //        Console.WriteLine("Waiting for messages. Press Q to quit.");
//        //        Console.ReadLine();
//        //    }
//        //}







//        //var factory = new ConnectionFactory
//        //{
//        //    HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost",
//        //    Port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? "5672"),
//        //    UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest",
//        //    Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest",
//        //};
//        //factory.ClientProvidedName = "Rabbit Test Consumer";
//        //IConnection connection = factory.CreateConnection();
//        //IModel channel = connection.CreateModel();

//        //string exchangeName = "EmailExchange";
//        //string routingKey = "email_queue";
//        //string queueName = "EmailQueue";

//        //channel.ExchangeDeclare(exchangeName, ExchangeType.Direct);
//        //channel.QueueDeclare(queueName, true, false, false, null);
//        //channel.QueueBind(queueName, exchangeName, routingKey, null);

//        //var consumer = new EventingBasicConsumer(channel);

//        //consumer.Received += (sender, args) =>
//        //{
//        //    var body = args.Body.ToArray();
//        //    string message = Encoding.UTF8.GetString(body);

//        //    Console.WriteLine($"Message received: {message}");

//        //    // Deserialize message to EmailModel (assuming message contains email details)
//        //    EmailModel emailModel = JsonConvert.DeserializeObject<EmailModel>(message);

//        //    if (emailModel == null)
//        //    {
//        //        Console.WriteLine("Failed to deserialize the email model.");
//        //        return;
//        //    }

//        //    // Send the email using EmailService
//        //    var emailService = new EmailService(Options.Create(emailSettings));
//        //    //EmailService emailService = new EmailService();
//        //    emailService.SendEmail(emailModel);

//        //    channel.BasicAck(args.DeliveryTag, false);
//        //};

//        //channel.BasicConsume(queueName, false, consumer);

//        //Console.WriteLine("Waiting for messages. Press Q to quit.");
//        //Thread.Sleep(Timeout.Infinite);







//////////////////////////////////////////////////////////////////

////ConnectionFactory factory = new();
////factory.Uri = new Uri(uriString: "amqp://guest:guest@localhost:5672");
////factory.ClientProvidedName = "Rabbit Sender App";
////IConnection cnn= factory.CreateConnection();
////IModel channel=cnn.CreateModel();





////var bus = RabbitHutch.CreateBus("host=localhost:5672");
////await bus.PubSub.SubscribeAsync<Poruke>("console_printer", msg=> { 
////    Console.WriteLine($"Poruka za korisnike: {msg.Tekst}");
////});

////await bus.PubSub.SubscribeAsync<ProizvodiActivated>("console_printer", msg =>
////{
////    Console.WriteLine($"Product activated 2: {msg.Proizvod.Naziv}");
////});


////await bus.PubSub.SubscribeAsync<ProizvodiActivated>("mail_sender", msg =>
////{
////    Console.WriteLine($"Sending email for: {msg.Proizvod.Naziv}");
////    //todo send email
////});




////Console.WriteLine("Listening for messages, press <return> key to close!");
////Console.ReadLine();


////Console.WriteLine("Hello, World!");

