class CfgVehicles {
    class Tank_F;
    class vurtual_seat: Tank_F {
        class CargoTurret;
    };
    class tft_proxy_stand: tft_proxy_base
    {
        class AnimationSources {};
        displayName = "Stand";
        model = "\tft_seat_proxies\data\floorhatch.p3d";
        hideWeaponsDriver = "false";
        class VehicleTransport
        {
            class Cargo
            {
                parachuteClass = "";	// Type of parachute used when dropped in air. When empty then parachute is not used.
                parachuteHeightLimit	= 40;				// Minimal height above terrain when parachute is used.
                canBeTransported = 1;				// 0 (false) / 1 (true)
                dimensions[] = { "BBox_1_1_pos", "BBox_1_2_pos" }; // Memory-point-based override of automatic bounding box
            };
        };
    };
};
