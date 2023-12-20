-module(quichand_serde_initial_packet).
-export([deserialize/1, serialize/1]).
-export_type([initial_packet/0]).

-record(initial_packet, {
    packet_type,
    version,
    dcid_len,
    dcid,
    scid_len,
    scid,
    token_len,
    token,
    payload
}).

deserialize(Bin) ->
    <<PacketType:8, Version:32, DCIDLen:8, DCID:DCIDLen/binary, SCIDLen:8, SCID:SCIDLen/binary, TokenLen:8, Token:TokenLen/binary, Payload/binary>> = Bin,
    #initial_packet{
        packet_type = PacketType,
        version = Version,
        dcid_len = DCIDLen,
        dcid = DCID,
        scid_len = SCIDLen,
        scid = SCID,
        token_len = TokenLen,
        token = Token,
        payload = Payload
    }.

serialize(#initial_packet{packet_type=PacketType, version=Version, dcid_len=DCIDLen, dcid=DCID, scid_len=SCIDLen, scid=SCID, token_len=TokenLen, token=Token, payload=Payload}) ->
    <<PacketType:8, Version:32, DCIDLen:8, DCID/binary, SCIDLen:8, SCID/binary, TokenLen:8, Token/binary, Payload/binary>>.
