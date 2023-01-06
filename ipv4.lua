local bit = require('bit')

local MAX_U32 = 0xFFFFFFFFULL

local function ip_to_u64(ip)
    local octets = string.split(ip, '.')
    if #octets ~= 4 then
        return nil
    end

    local result = 0ULL
    for _, octet in ipairs(octets) do
        octet = tonumber(octet)
        if
               octet == nil
            or octet < 0
            or octet > 255
        then
            return nil
        end

        result = result * 256ULL + octet
    end
    return result
end

local function u64_to_ip(u64)
    local octets = {}
    for i = 1, 4 do
        octets[i] = tostring(bit.band(u64, 0xFFULL))
        u64 = bit.rshift(u64, 8)
    end
    return table.concat(octets, '.')
end

local function cidr_network_to_u64_pair(network)
    local parts = string.split(network, '/')
    if #parts ~= 2 then
        return nil
    end

    local ip = ip_to_u64(parts[1])
    if ip == nil then
        return nil
    end

    local mask = tonumber(parts[2])
    if
           mask == nil
        or mask < 0
        or mask > 32
    then
        return nil
    end

    local mask_bits = 0
    for i = 1, mask do
        mask_bits = bit.bor(mask_bits, bit.lshift(1ULL, 32 - i))
    end

    local rev_mask_bits = bit.band(bit.bnot(mask_bits), MAX_U32)
    return bit.band(ip, mask_bits), bit.bor(ip, rev_mask_bits)
end

return {
    ip_to_u64                = ip_to_u64,
    u64_to_ip                = u64_to_ip,
    cidr_network_to_u64_pair = cidr_network_to_u64_pair,
}