with Levels; use Levels;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

procedure Main is
   Str : String(1..2);
   Last : Natural;
    task Start;
   RNG : Generator;
   X : Float;
   task body Start is
   begin
      Put_Line("Welcome to your Tesla Management system!");
      Put_Line("Tesla managemnt menu: ");
      Put_Line("Command => Description");
      Put_Line("1 => Turn On Engine");
      Put_Line("2 => Turn off Engine");
      Put_Line("3 => Load Passenger");
      Put_Line("4 => Unload Passengers");
      Put_Line("5 => Speed up ");
      Put_Line("6 => Slow Down");
      Put_line("7 => Enable Maintenance Mode");
      Put_Line("8 => Disable Maintenance Mode");
      Put_Line("B => Get Battery status");
      Put_Line("D => Get Battery decration Level");
      Put_Line("P => Enable / Disable Parking Mode");
      Put_Line("R => Turn Right ");
      Put_Line("L => Turn Left");
      Put_Line("I => Get Car Diagostic information");
      Put_Line("M => Print again commands menu");
      Put_Line("C => Charge Car");
      Put_Line("S => Stop charging");
      Put_Line("Press ANY other key to exit");
      loop
         if TeslaCar.BatteryLevel < 5 and TeslaCar.PowerLevel = On then
            Put_Line("Battery level is low...Charge the batteries");
            exit;
         end if;
         if TeslaCar.BatteryLevel < 15 and TeslaCar.PowerLevel = On then
            Put_Line("Running low of battery, reach a charge point immeditaly");
         end if;

         if TeslaCar.PowerLevel = On then
            TeslaCar.BatteryLevel := TeslaCar.BatteryLevel - 1; -- Todo: Fix with Battery degradation Level
         end if;

         Put_Line("Please enter what you would like to do:");
         Get_Line(Str,Last);
         case Str(1) is
         when '1' =>
            Put_Line("Turning on Car...");
            TurnEngineOn;
            Put_Line("Engine status:");
            Put_Line(TeslaCar.PowerLevel'Image);
         when '2' =>
            Put_Line("Turning Car off...");
            TurnEngineOff;
            Put_Line("Engine Status:");
            Put_Line(TeslaCar.PowerLevel'Image);
         when '3' =>
            Put_Line("Check passenger availability...");
            AddPassenger;
            Put_Line("Number of passenger inside the car:");
            Put_Line(TeslaCar.NumberOfPassengers'Image);
         when '4' =>
            Put_Line("OffLoading a passenger...");
            RemovePassenger;
            Put_Line("Number of passenger inside the car:");
            Put_Line(TeslaCar.NumberOfPassengers'Image);
         when '5' =>
            if TeslaCar.PowerLevel = Off then
               Put_Line("Turn the engine before to move off");
            else
               Put_Line("Check roads contidition before speeding up...");
               Put("Current speed: ");
               Put_Line(TeslaCar.CarSpeed'Image);
               IncreaseSpeed;
               Put("New speed: ");
               Put_Line(TeslaCar.CarSpeed'Image);
               Put("Battery Degradation level: ");
               Put_Line(TeslaCar.BatteryDegradationLevel'Image);
               Put("Battery left: ");
               Put_Line(TeslaCar.BatteryLevel'Image);
               end if;
         when '6' =>
            Put_Line("Check traffic conditions to slow down...");
            Put("Current speed: ");
            Put_Line(TeslaCar.CarSpeed'Image);
            DecreaseSpeed;
            Put("Current speed: ");
            Put_Line(TeslaCar.CarSpeed'Image);
            Put_Line("Battery Degradation level: ");
            Put(TeslaCar.BatteryDegradationLevel'Image);
            Put_Line("Battery left: ");
               Put_Line(TeslaCar.BatteryLevel'Image);
         when '7' =>
            Put_Line("Enabling diagnostic mode... ");
            EnableDiagosticMode;
            Put_Line("Diagnostic mode:");
            Put_Line(TeslaCar.MaintenanceMode'Image);
         when '8' =>
            Put_Line("Disabling diagnostic mode...");
            DisableDiagosticMode;
            Put_Line("Diagnostic mode:");
            Put_Line(TeslaCar.MaintenanceMode'Image);
         when 'R' =>
            Put_Line("Checking if it possible to turn right...");
            X := Random(RNG);
            Put_Line(X'Image);
            -- if X < 3.49685E-01 then
            -- Implement probability of object detection
         when 'L' =>
            Put_Line("Check if possible to turn left...");
            -- Implement probability ob object detection
         when 'P' =>
            Put("Current Parking mode status: ");
            Put_Line(TeslaCar.Parking'Image);
            if TeslaCar.Parking = On then
               UnsetParkingmode;
            else
               SetParkingMode;
            Put("Current Parking mode status: ");
               Put_Line(TeslaCar.Parking'Image);
            end if;
         when 'M' =>
             Put_Line("Tesla managemnt menu: ");
             Put_Line("Command => Description");
             Put_Line("1 => Turn On Engine");
             Put_Line("2 => Turn off Engine");
             Put_Line("3 => Load Passenger");
              Put_Line("4 => Unload Passengers");
      Put_Line("5 => Speed up ");
      Put_Line("6 => Slow Down");
      Put_line("7 => Enable Maintenance Mode");
      Put_Line("8 => Disable Maintenance Mode");
      Put_Line("B => Get Battery status");
      Put_Line("D => Get Battery decration Level");
      Put_Line("P => Enable / Disable Parking Mode");
      Put_Line("R => Turn Right ");
      Put_Line("L => Turn Left");
      Put_Line("I => Get Car Diagostic information");
      Put_Line("M => Print again commands menu");
      Put_Line("C => Charge Car");
      Put_Line("S => Stop charging");
      Put_Line("Press ANY other key to exit");
         when 'B' =>
            Put("Battery level: ");
            Put_Line(TeslaCar.BatteryLevel'Image);
         when 'D' =>
            Put("Battery degration Level: ");
            Put_Line(TeslaCar.BatteryDegradationLevel'Image);
            Put_Line("Mind that degration level may change in according to car load and speed");
         when 'I' =>
            Put("Engine status: ");
            Put_Line(TeslaCar.PowerLevel'Image);
            Put("Battery percentage level: ");
            Put_Line(TeslaCar.BatteryLevel'Image);
            Put("Parking inserted: ");
            Put_Line(TeslaCar.Parking'Image);
            Put("Maintenance status: ");
            Put_Line(TeslaCar.MaintenanceMode'Image);
            Put("Car Sspeed: ");
            Put_Line(TeslaCar.CarSpeed'Image);
            Put("Minimum battery charge allwed: ");
            Put_Line(TeslaCar.MinimumBattery'Image);
         when 'C' =>
            if TeslaCar.Charging = Off and TeslaCar.CarSpeed = 0 then
               EnableChargeBattery;
               Put("Charging status: ");
               Put_Line(TeslaCar.Charging'Image);
            end if;
         when 'S' =>
            DisableChargeBattery;
            Put("Charging status: ");
            Put_Line(TeslaCar.Charging'Image);
         when others => exit;
         end case;
      end loop;
      delay 0.1;
   end Start;


begin
   null;
end Main;
