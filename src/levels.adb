package body Levels with SPARK_Mode

is
   procedure TurnEngineOn is begin
      if TeslaCar.PowerLevel = Off and TeslaCar.Parking=On
      and TeslaCar.MaintenanceMode = Off then
         TeslaCar.PowerLevel := On;
         if TeslaCar.BatteryDegradationLevel >=0 and TeslaCar.BatteryDegradationLevel <=100 then
            TeslaCar.BatteryDegradationLevel := TeslaCar.BatteryDegradationLevel +1;
         end if;
      end if;
   end TurnEngineOn;


   procedure TurnEngineOff is begin
      if TeslaCar.PowerLevel = On then
         TeslaCar.PowerLevel :=  Off;
         TeslaCar.BatteryDegradationLevel := 0;
      end if;
      end TurnEngineOff;

   procedure SetParkingMode is begin
      if TeslaCar.CarSpeed = 0 and TeslaCar.MaintenanceMode = Off
         and TeslaCar.Parking = Off and TeslaCar.GearInserted = 0 then
            TeslaCar.Parking := On;
      end if;
         end SetParkingMode;

   procedure UnsetParkingMode is begin
            if TeslaCar.CarSpeed = 0 and TeslaCar.MaintenanceMode = Off
              and TeslaCar.Parking = On and TeslaCar.GearInserted = 0 then
               TeslaCar.Parking := Off;
      end if;
      end UnsetParkingMode;

   procedure AddPassenger is begin
       if TeslaCar.NumberOfPassengers >=0 and TeslaCar.MaintenanceMode = Off
          and TeslaCar.NumberOfPassengers < 5
          and TeslaCar.CarSpeed = 0 then
            TeslaCar.NumberOfPassengers := TeslaCar.NumberOfPassengers + 1;
            TeslaCar.BatteryDegradationLevel := TeslaCar.BatteryDegradationLevel +1;
       end if;
   end AddPassenger;

   procedure RemovePassenger is begin
               if TeslaCar.NumberOfPassengers >=1 and TeslaCar.MaintenanceMode = Off and TeslaCar.CarSpeed = 0 then
         TeslaCar.BatteryDegradationLevel := TeslaCar.BatteryDegradationLevel -1;
         TeslaCar.NumberOfPassengers := TeslaCar.NumberOfPassengers -1;
      end if;
   end RemovePassenger;


   procedure EnableDiagosticMode is begin
      TeslaCar.MaintenanceMode := On;
   end EnableDiagosticMode;

   procedure DisableDiagosticMode is begin
               if TeslaCar.MaintenanceMode = On then
                  TeslaCar.MaintenanceMode := Off;
                  end if;
   end DisableDiagosticMode;

   procedure IncreaseSpeed is begin
      if (TeslaCar.CarSpeed < 30 and TeslaCar.Parking = Off
          and TeslaCar.PowerLevel = on and TeslaCar.NumberOfPassengers >=1 and TeslaCar.BatteryLevel > 5) then
         TeslaCar.CarSpeed := TeslaCar.CarSpeed +5;
         TeslaCar.BatteryDegradationLevel := TeslaCar.BatteryDegradationLevel + 1;
         TeslaCar.GearInserted := TeslaCar.GearInserted + 1;
      end if;
   end IncreaseSpeed;


   procedure DecreaseSpeed is begin
    if TeslaCar.MaintenanceMode = Off and TeslaCar.CarSpeed> 5  then
      TeslaCar.CarSpeed := TeslaCar.CarSpeed -5;
      TeslaCar.GearInserted := TeslaCar.GearInserted -1;
      TeslaCar.BatteryDegradationLevel := TeslaCar.BatteryDegradationLevel -1;
   end if;
      end DecreaseSpeed;


   procedure Turn is
   begin
      if TeslaCar.PowerLevel = On and TeslaCar.MaintenanceMode = Off
      and TeslaCar.ObjectDetected = Off
      then
       TeslaCar.CarSpeed := TeslaCar.CarSpeed +5;
       TeslaCar.BatteryDegradationLevel := TeslaCar.BatteryDegradationLevel + 1;
       TeslaCar.GearInserted := TeslaCar.GearInserted + 1;
   end if;
      end Turn;

   procedure GearUp is
   begin
      if TeslaCar.CarSpeed = 0 and TeslaCar.MaintenanceMode = Off and TeslaCar.GearInserted <=4 then
         TeslaCar.GearInserted := TeslaCar.GearInserted +1;
      end if;
   end GearUp;

   procedure GearDown is
   begin
      if TeslaCar.CarSpeed =0 and TeslaCar.MaintenanceMode = Off and TeslaCar.GearInserted >= 0 then
         TeslaCar.GearInserted := TeslaCar.GearInserted - 1;
      end if;
   end GearDown;

   procedure EnableChargeBattery is begin
         if TeslaCar.CarSpeed = 0 and TeslaCar.Parking=On and  TeslaCar.PowerLevel = Off and TeslaCar.Charging =Off then
            TeslaCar.Charging := On;
         end if;
   end EnableChargeBattery;

   procedure DisableChargeBattery is begin
      if TeslaCar.CarSpeed = 0 and TeslaCar.PowerLevel = Off and TeslaCar.Charging = On then
         TeslaCar.Charging := Off;
      end if;
   end DisableChargeBattery;

end Levels;
