-module(quichand_serde_one_rtt_packet).
-export([parse_quic_short_header_packet/1, encode_quic_short_header_packet/1]).
-export_type([short_header_packet/0]).

-record(short_header_packet, {
    packet_type,
    dcid_len,
    dcid,
    packet_number,
    payload
}).

parse_quic_short_header_packet(Bin) ->
    <<PacketType:8, DCIDLen:8, DCID:DCIDLen/binary, PacketNumber:32, Payload/binary>> = Bin,
    #short_header_packet{
        packet_type = PacketType,
        dcid_len = DCIDLen,
        dcid = DCID,
        packet_number = PacketNumber,
        payload = Payload
    }.

encode_quic_short_header_packet(#short_header_packet{packet_type=PacketType, dcid_len=DCIDLen, dcid=DCID, packet_number=PacketNumber, payload=Payload}) ->
    <<PacketType:8, DCIDLen:8, DCID/binary, PacketNumber:32, Payload/binary>>.
