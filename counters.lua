obs = obslua

-- Variables
counter1 = 0
counter2 = 0
chase = "chases"
floor = "floors"

function script_description()
    return "Een script om twee counters bij- en af te plussen om zo de chase en floor aantallen bij te houden"
end

function update_counter1()
    local source = obs.obs_get_source_by_name(chase)
    if source ~= nil then
        local settings = obs.obs_data_create()
        obs.obs_data_set_string(settings, "text", tostring(counter1))
        obs.obs_source_update(source, settings)
        obs.obs_data_release(settings)
        obs.obs_source_release(source)
    end
end

function update_counter2()
    local source = obs.obs_get_source_by_name(floor)
    if source ~= nil then
        local settings = obs.obs_data_create()
        obs.obs_data_set_string(settings, "text", tostring(counter2))
        obs.obs_source_update(source, settings)
        obs.obs_data_release(settings)
        obs.obs_source_release(source)
    end
end

-- Increment chase
function increment_counter1(pressed)
    if pressed then
        counter1 = counter1 + 1
        update_counter1()
    end
end

-- Decrement chase
function decrement_counter1(pressed)
    if pressed then
        counter1 = counter1 - 1
        update_counter1()
        counter2 = counter2 - 1
        update_counter2()
    end
end

-- Increment floor
function increment_counter2(pressed)
    if pressed then
        counter2 = counter2 + 1
        update_counter2()
    end
end

-- Decrement floor
function decrement_counter2(pressed)
    if pressed then
        counter2 = counter2 - 1
        update_counter2()
    end
end

function script_properties()
    return nil
end

function script_load(settings)
    obs.obs_hotkey_register_frontend("increment_counter1", "Increment Counter 1", increment_counter1)
    obs.obs_hotkey_register_frontend("decrement_counter1", "Decrement Counter 1", decrement_counter1)
    obs.obs_hotkey_register_frontend("increment_counter2", "Increment Counter 2", increment_counter2)
    obs.obs_hotkey_register_frontend("decrement_counter2", "Decrement Counter 2", decrement_counter2)
end
