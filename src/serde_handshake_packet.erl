-module(quichand_serde_handshake_packet).
-export([deserialize/1, serialize/1]).
-export_type([handshake_packet/0]).

-record(handshake_packet, {
    packet_type,
    version,
    dcid_len,
    dcid,
    scid_len,
    scid,
    payload
}).

deserialize(Bin) ->
    <<PacketType:8, Version:32, DCIDLen:8, DCID:DCIDLen/binary, SCIDLen:8, SCID:SCIDLen/binary, Payload/binary>> = Bin,
    #handshake_packet{
        packet_type = PacketType,
        version = Version,
        dcid_len = DCIDLen,
        dcid = DCID,
        scid_len = SCIDLen,
        scid = SCID,
        payload = Payload
    }.

serialize(#handshake_packet{packet_type=PacketType, version=Version, dcid_len=DCIDLen, dcid=DCID, scid_len=SCIDLen, scid=SCID, payload=Payload}) ->
    <<PacketType:8, Version:32, DCIDLen:8, DCID/binary, SCIDLen:8, SCID/binary, Payload/binary>>.
