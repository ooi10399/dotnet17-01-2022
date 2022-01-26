using System;

namespace UnderstandingInterfaceApplication
{
    internal class Program
    {
        void CheckSky(IFlying flying)
        {
            flying.TakeOff();
            flying.Fly();
            flying.Land();
        }
        void ExploreForest(ILiving living)
        {
            living.Breathe();
            living.Eat();
            living.Sleep();
        }
        static void Main(string[] args)
        {
            Bird bird = new Bird();
            Program program = new Program();
            //program.ExploreForest(bird);
            program.CheckSky(bird);
            Console.ReadKey();
        }
    }
}
