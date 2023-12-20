-module(quichand_serde_retry_packet).
-export([deserialize/1, serialize/1]).
-export_type([retry_packet/0]).

-record(retry_packet, {
    packet_type,
    version,
    dcid_len,
    dcid,
    scid_len,
    scid,
    original_dcid_len,
    original_dcid,
    retry_token
}).

deserialize(Bin) ->
    <<PacketType:8, Version:32, DCIDLen:8, DCID:DCIDLen/binary, SCIDLen:8, SCID:SCIDLen/binary, OriginalDCIDLen:8, OriginalDCID:OriginalDCIDLen/binary, RetryToken/binary>> = Bin,
    #retry_packet{
        packet_type = PacketType,
        version = Version,
        dcid_len = DCIDLen,
        dcid = DCID,
        scid_len = SCIDLen,
        scid = SCID,
        original_dcid_len = OriginalDCIDLen,
        original_dcid = OriginalDCID,
        retry_token = RetryToken
    }.

serialize(#retry_packet{packet_type=PacketType, version=Version, dcid_len=DCIDLen, dcid=DCID, scid_len=SCIDLen, scid=SCID, original_dcid_len=OriginalDCIDLen, original_dcid=OriginalDCID, retry_token=RetryToken}) ->
    <<PacketType:8, Version:32, DCIDLen:8, DCID/binary, SCIDLen:8, SCID/binary, OriginalDCIDLen:8, OriginalDCID/binary, RetryToken/binary>>.
