class CfgVehicles {
    class StaticWeapon;
    class ssl_proxy_base: StaticWeapon {
        class HeadLimits;
        author = "Ampersand";
        mapSize = 1;
        _generalMacro = "ssl_proxy_base";
        scope = 0;
        scopeCurator = 0;
        displayName = "Static Line Standing";
        model = "";
        castDriverShadow = 1;
        driverAction = "passenger_boat_holdleft";
        hideWeaponsDriver = 0;
        ejectDeadDriver = 0;
        hasDriver = 1;
        icon = "iconObject_1x1";
        editorSubcategory = "EdSubcat_Storage";
        vehicleClass = "Support";
        class Turrets {};
        ace_cargo_canLoad = 0;
        ace_Cargo_hasCargo = 0;
        ace_cargo_size = -1;
        ace_dragging_canCarry = 0;
        ace_dragging_canDrag = 0;
        magazines[] = {};
    };
    class ssl_proxy_stand: ssl_proxy_base {
        class HeadLimits: HeadLimits {
            initAngleX = 0;
            initAngleY = 0;
            maxAngleX = 89;
            maxAngleY = 90;
            maxAngleZ = 45;
            minAngleX = -89;
            minAngleY = -90;
            minAngleZ = -45;
            rotZRadius = 0.2;
        };
        model = "\z\ssl\addons\main\models\stand.p3d";
        class VehicleTransport
        {
            class Cargo {
                parachuteClass = ""; // Type of parachute used when dropped in air. When empty then parachute is not used.
                parachuteHeightLimit = 40; // Minimal height above terrain when parachute is used.
                canBeTransported = 1; // 0 (false) / 1 (true)
                dimensions[] = { "BBox_1_1_pos", "BBox_1_2_pos" }; // Memory-point-based override of automatic bounding box
            };
            class Carrier {
                cargoBayDimensions[] = {"VTV_limit_1", "VTV_limit_2"};	// Memory points in model defining cargo space
                disableHeightLimit = 1; // If set to 1 disable height limit of transported vehicles
                maxLoadMass = 20000; // Maximum cargo weight (in Kg) which the vehicle can transport
                cargoAlignment[] = {"front", "center"}; // Array of 2 elements defining alignment of vehicles in cargo space. Possible values are left, right, center, front, back. Order is important.
                cargoSpacing[] = {0, 0.15, 0}; // Offset from X,Y,Z axes (in metres)
                exits[] = {"VTV_exit_1"}; // Memory points in model defining loading ramps, could have multiple
                unloadingInterval = 2; // Time between unloading vehicles (in seconds)
                loadingDistance = 10; // Maximal distance for loading in exit point (in meters).
                loadingAngle = 60; // Maximal sector where cargo vehicle must be to for loading (in degrees).
                parachuteClassDefault = ""; // Type of parachute used when dropped in air. Can be overridden by parachuteClass in Cargo.
                parachuteHeightLimitDefault = 50; // Minimal height above terrain when parachute is used. Can be overriden by parachuteHeightLimit in Cargo.
            };
        };
        author = "Ampersand";
        mapSize = 1;
        editorPreview = "";
        _generalMacro = "ssl_proxy_stand";
        displayName = "Static Line Standing";

        scope = 1;
        scopeCurator = 1;
        picture = "\A3\Air_F_Heli\Heli_Transport_04\Data\UI\Pod_Heli_Transport_04_bench_CA.paa";
        disableInventory = 1;
        //DLC = "Heli";
        icon = "iconObject_1x1";
        accuracy = 1000;
        //waterLeakiness = 500;
    };
    class ssl_proxy_stand_l1: ssl_proxy_stand {
        driverAction = "passenger_boat_holdleft";
    };
    class ssl_proxy_stand_l2: ssl_proxy_stand {
        driverAction = "passenger_boat_holdleft2";
    };
    class ssl_proxy_stand_r1: ssl_proxy_stand {
        driverAction = "passenger_boat_holdright";
    };
    class ssl_proxy_stand_r2: ssl_proxy_stand {
        driverAction = "passenger_boat_holdright2";
    };

    class ace_fastroping_helper;
    class ssl_helper: ace_fastroping_helper {};

    class VTOL_Base_F;
    class VTOL_01_base_F: VTOL_Base_F {
        SSL_AnchorCablesInfo[] = {
            {{-0.6  ,6.5,-3.5},{-0.6  ,-3.5,-3.5},9.99},
            {{0.2   ,6.5,-3.5},{0.2   ,-3.5,-3.5},9.99},
            {{1     ,6.5,-3.5},{1     ,-3.5,-3.5},9.99}
        };
    };
};
