using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicModelsLibrary
{
    public class User
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Password { get; set; }
        public int Age { get; set; }
        public string Type { get; set; }


        public void TakeDetails()
        {
            Console.WriteLine("Please enter ID:");
            Id = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Please enetr Name:");
            Name = Console.ReadLine();
            Console.WriteLine("Please enter Password:");
            Password = Console.ReadLine();
            Console.WriteLine("Please enter Age:");
            Age = Convert.ToInt32(Console.ReadLine());
        }

        public void PrintDetails()
        {
            Console.WriteLine("ID: {0} Name: {1} Password: {2} Age: {2}", Id, Name, Password,Age);
        }

        public override string ToString()
        {
            return "ID: " + Id + "\nName: " + Name + "\nPassword: " + Password + "\nAge: " + Age;
        }

    }
}

    
