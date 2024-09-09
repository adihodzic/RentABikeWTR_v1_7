using System;
using System.Text;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using Newtonsoft.Json;
using System.Net.Mail;
using RentABikeWTR.Subscriber;
using Org.BouncyCastle.Crypto.Generators;
using Microsoft.EntityFrameworkCore;
using RentABikeWTR_v1_7.Model;
using RentABikeWTR_v1_7.Services.Database;

public class EmailConsumer
{
    private readonly EmailSettings _emailSettings;
    private IConnection _connection;
    private IModel _channel;
    private readonly object _lock = new object();
    private readonly RentABikeWTR_v1_7Context _context;

    public EmailConsumer(EmailSettings emailSettings, RentABikeWTR_v1_7Context context)
    {
        _emailSettings = emailSettings;
        _context= context;
    }

    public void Start()
    {
        while (true) // Keep the application running
        {
            try
            {
                InitializeRabbitMQConnection();
                var consumer = new EventingBasicConsumer(_channel);
                consumer.Received += (sender, args) =>
                {
                    var body = args.Body.ToArray();
                    string message = Encoding.UTF8.GetString(body);

                    Console.WriteLine($"Message received: {message}");

                    // Deserialize and process the email
                    var emailAddresses = _context.Korisnici
                    .Where(u=>u.UlogaID==4)
                    .Select(c => c.Email)
                    .ToList();
                    foreach (var emailAddress in emailAddresses)
                    {
                        SendEmail(message, emailAddress);
                    }
                    

                    try
                    {
                        if (_channel != null && _channel.IsOpen)
                        {
                            _channel.BasicAck(args.DeliveryTag, false);
                        }
                        else
                        {
                            Console.WriteLine("Channel is not open. Recreating channel...");
                            InitializeRabbitMQConnection(); // Recreate connection and channel
                        }
                    }
                    catch (ObjectDisposedException ex)
                    {
                        Console.WriteLine("Channel was disposed: " + ex.Message);
                        InitializeRabbitMQConnection(); // Recreate connection and channel
                    }
                };

                _channel.BasicConsume(queue: "email-name", autoAck: false, consumer: consumer);

                Console.WriteLine("Waiting for messages. Press [enter] to exit.");
                Console.ReadLine(); // Block the application from exiting
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred: {ex.Message}");
                // Optionally add a delay before retrying
                Thread.Sleep(5000);
            }
        }
    }

    private void InitializeRabbitMQConnection()
    {
        var factory = new ConnectionFactory
        {
            HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost",
            Port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? "5672"),
            UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "admin",
            Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest",
        };

        lock (_lock)
        {
            _connection?.Dispose();
            _channel?.Dispose();

            _connection = factory.CreateConnection();
            _channel = _connection.CreateModel();

            string exchangeName = "direct";
            string routingKey = "email-key";
            string queueName = "email-name";

            _channel.ExchangeDeclare(exchange: exchangeName, type: ExchangeType.Direct);
            _channel.QueueDeclare(queueName, true, false, false, null);
            _channel.QueueBind(queueName, exchangeName, routingKey, null);
        }
    }


    private void SendEmail(string message, string recipientEmail)
    {
        // Create the email message
        var emailMessage = new MailMessage
        {
            //From = new MailAddress(_emailSettings.SenderEmail, _emailSettings.SenderName),
            From = new MailAddress("appadi172@gmail.com", "help-desk"),
            Subject = "New Message",
            Body = message,
            IsBodyHtml = true,
        };
        emailMessage.To.Add(recipientEmail); // Change this to recipient address as needed

        using (var smtpClient = new SmtpClient("smtp.gmail.com", 587))
        {
            //smtpClient.Credentials = new System.Net.NetworkCredential(_emailSettings.UserName, _emailSettings.Password);
            smtpClient.Credentials = new System.Net.NetworkCredential("appadi172@gmail.com", "tijxgzdzdzekrtie");

            smtpClient.EnableSsl = true; //_emailSettings.EnableSsl;

            try
            {
                smtpClient.Send(emailMessage);
                Console.WriteLine("Email sent successfully.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Failed to send email: {ex.Message}");
            }
        }
    }
}