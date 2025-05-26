package Levels with SPARK_Mode
is
   type Power is (On, Off);
   type Battery is range 0..100;
   type BatteryDegradation is range 0..100;
   type Speed is range 0..200;
   type Maintenance is (On, Off);
   type Passengers is range 0..5;
   type Gear is range -1..5;
   type MaxSpeed is range 30..30;
   type Object is (On, Off);
   type MinimumBatteryLevel is range 0..100;
   type ParkingMode is (On, Off);
   type ChargingMode is (On, Off);

   type Car is record
      PowerLevel: Power;
      BatteryLevel: Battery;
      BatteryDegradationLevel: BatteryDegradation;
      CarSpeed: Speed;
      GearInserted: Gear;
      MaintenanceMode: Maintenance;
      NumberOfPassengers: Passengers;
      ObjectDetected: Object;
      MinimumBattery : MinimumBatteryLevel;
      Parking: ParkingMode;
      Charging: ChargingMode;
   end record;

   type RoadRule is record
      SpeedLimit: MaxSpeed;
   end record;
   Str : String(1..2);

   RoadLimitation : RoadRule := (
                                 SpeedLimit=> 30);

   TeslaCar : Car := (PowerLevel=> Off,
                      BatteryLevel=>100,
                      BatteryDegradationLevel=>0,
                      CarSpeed=>0,
                      GearInserted=>0,
                      MaintenanceMode=> Off,
                      ObjectDetected=>Off,
                      MinimumBattery => 5,
                      Parking => On,
                      Charging => On,
                      NumberOfPassengers=> 0);

   procedure TurnEngineOn with
     Global => (In_Out => TeslaCar),
     Pre => (TeslaCar.PowerLevel = Off and
             TeslaCar.BatteryDegradationLevel >=0 and
             TeslaCar.BatteryDegradationLevel <=99 and
             TeslaCar.GearInserted=0 and
             TeslaCar.Parking = On and
             TeslaCar.MaintenanceMode = Off),

     Post => TeslaCar.PowerLevel = On and
     TeslaCar.GearInserted=0 and
     TeslaCar.BatteryDegradationLevel >=0 and
     TeslaCar.BatteryDegradationLevel <=100 and
     TeslaCar.MaintenanceMode = Off and TeslaCar.Parking=On;

   procedure TurnEngineOff with
     Global => (In_Out => TeslaCar),
     Pre => (TeslaCar.PowerLevel = On),
     Post => TeslaCar.PowerLevel = Off and TeslaCar.BatteryDegradationLevel = 0;

   procedure UnsetParkingMode with
     Global => (In_Out => TeslaCar),
     Pre => (TeslaCar.Parking = On  and TeslaCar.CarSpeed = 0 and TeslaCar.GearInserted = 0),
     Post => TeslaCar.CarSpeed = 0;

   procedure SetParkingMode with
     Global => (In_Out => TeslaCar),
     Pre => (TeslaCar.Parking = Off and TeslaCar.CarSpeed = 0 and TeslaCar.GearInserted = 0),
     Post => TeslaCar.CarSpeed = 0;

   procedure AddPassenger with
     Global => (In_Out => TeslaCar),
     Pre => TeslaCar.NumberOfPassengers >= 0 and
     TeslaCar.NumberOfPassengers <= 4 and
     TeslaCar.CarSpeed = 0 and
     TeslaCar.BatteryDegradationLevel >=0 and
     TeslaCar.BatteryDegradationLevel <=99,
     Post =>
     TeslaCar.BatteryDegradationLevel >=0 and
     TeslaCar.BatteryDegradationLevel <=100;

   procedure RemovePassenger with
     Global => (In_Out => TeslaCar),
     Pre => TeslaCar.NumberOfPassengers >= 1 and
     TeslaCar.BatteryDegradationLevel >=1 and TeslaCar.BatteryDegradationLevel <= 100 and
     TeslaCar.NumberOfPassengers <= 5 and TeslaCar.CarSpeed = 0,
     Post => TeslaCar.NumberOfPassengers >=0 and TeslaCar.NumberOfPassengers <=5;

   procedure EnableDiagosticMode with
     Global => (In_Out => TeslaCar),
     Pre => TeslaCar.MaintenanceMode = Off,
     Post => TeslaCar.MaintenanceMode = On;

   procedure DisableDiagosticMode with
     Global => (In_Out => TeslaCar),
     Pre => TeslaCar.MaintenanceMode = On,
     Post => TeslaCar.MaintenanceMode = Off;

   function InvariantSpeedLimit return Boolean is
      (TeslaCar.CarSpeed < 30);


   function InvariantAcceleration return Boolean is
     (TeslaCar.NumberOfPassengers >=1 and then TeslaCar.PowerLevel = On
      and then TeslaCar.BatteryLevel > 5 and then TeslaCar.MaintenanceMode = Off and then TeslaCar.Parking = Off);

   procedure IncreaseSpeed with
     Global => (In_Out => TeslaCar),
     Pre => InvariantAcceleration and TeslaCar.MaintenanceMode = Off and
     TeslaCar.BatteryDegradationLevel > 0 and TeslaCar.BatteryDegradationLevel <=99 and
     TeslaCar.GearInserted >=-1 and TeslaCar.GearInserted <= 4,
     Post => InvariantAcceleration and
     TeslaCar.BatteryDegradationLevel > 0 and TeslaCar.BatteryDegradationLevel <=100 and
     TeslaCar.GearInserted <=5 and
     TeslaCar.MaintenanceMode = Off;

   function InvariantDeceleration return Boolean is
      (TeslaCar.MaintenanceMode = Off);

   procedure DecreaseSpeed with
     Global => (In_Out => TeslaCar),
     Pre => TeslaCar.Parking = Off and
     TeslaCar.GearInserted >= 0 and TeslaCar.GearInserted <=5 and
     TeslaCar.MaintenanceMode = Off and TeslaCar.CarSpeed >5 and
     TeslaCar.BatteryDegradationLevel >=1 and TeslaCar.BatteryDegradationLevel < 99,
     Post => TeslaCar.Parking = Off and TeslaCar.MaintenanceMode = Off and TeslaCar.GearInserted >= -1
     and TeslaCar.GearInserted <=5 and TeslaCar.BatteryDegradationLevel >=0 and TeslaCar.BatteryDegradationLevel <=100;

   procedure Turn with
     Global => (In_Out => TeslaCar),
     Pre=> TeslaCar.PowerLevel = On and  TeslaCar.BatteryLevel > 0 and TeslaCar.GearInserted >=1
     and TeslaCar.NumberOfPassengers >=1 and
     TeslaCar.ObjectDetected = Off and
     TeslaCar.CarSpeed >=0 and TeslaCar.CarSpeed <= 195 and
     TeslaCar.MaintenanceMode = Off and
     TeslaCar.BatteryDegradationLevel >= 0 and TeslaCar.BatteryDegradationLevel <= 99 and
     TeslaCar.GearInserted >=0 and TeslaCar.GearInserted <=4,
     Post => TeslaCar.PowerLevel = On and  TeslaCar.BatteryLevel > 0 and TeslaCar.GearInserted >=1
     and  TeslaCar.NumberOfPassengers >=1 and
     TeslaCar.CarSpeed >=0 and TeslaCar.CarSpeed <=200 and
     TeslaCar.BatteryDegradationLevel >= 0 and TeslaCar.BatteryDegradationLevel <= 100 and
     TeslaCar.GearInserted >=1 and TeslaCar.GearInserted <=5 and
     TeslaCar.ObjectDetected = Off and  TeslaCar.MaintenanceMode = Off;

   procedure GearUp with
     Global => (In_Out => TeslaCar),
     Pre => TeslaCar.CarSpeed = 0 and TeslaCar.GearInserted <=4 and TeslaCar.MaintenanceMode = Off,
       Post => TeslaCar.CarSpeed = 0 and TeslaCar.GearInserted <=5 and TeslaCar.MaintenanceMode = Off;

   procedure GearDown with
     Global => (In_Out => TeslaCar),
       Pre => TeslaCar.CarSpeed = 0 and TeslaCar.GearInserted >=0 and TeslaCar.MaintenanceMode = Off,
         Post => TeslaCar.CarSpeed = 0 and TeslaCar.GearInserted >= -1 and TeslaCar.MaintenanceMode = Off;

   procedure EnableChargeBattery with
     Global => (In_Out => TeslaCar),
     Pre => TeslaCar.CarSpeed = 0 and TeslaCar.PowerLevel = Off and TeslaCar.Charging = Off and TeslaCar.Parking=On,
     Post => TeslaCar.CarSpeed = 0 and TeslaCar.PowerLevel = Off and TeslaCar.Charging = On and TeslaCar.Parking = On;

   procedure DisableChargeBattery with
     Global => (In_Out => TeslaCar),
     Pre => TeslaCar.CarSpeed = 0 and TeslaCar.PowerLevel = Off and TeslaCar.Charging = On,
     Post => TeslaCar.CarSpeed = 0 and TeslaCar.PowerLevel = Off and TeslaCar.Charging = Off;

end Levels;
