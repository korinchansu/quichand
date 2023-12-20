-module(quichand_serde_close_packet).
-export([deserialize_connection/1, deserialize_application/1, serialize_connection/1, serialize_application/1]).
-export_type([connection_close_packet/0, application_close_packet/0]).

-record(connection_close_packet, {
    packet_type,
    error_code,
    frame_type,
    reason_phrase_length,
    reason_phrase
}).
-record(application_close_packet, {
    packet_type,
    error_code,
    reason_phrase_length,
    reason_phrase
}).

deserialize_connection(Bin) ->
    <<PacketType:8, ErrorCode:32, FrameType:8, ReasonPhraseLength:8, ReasonPhrase:ReasonPhraseLength/binary>> = Bin,
    #connection_close_packet{
        packet_type = PacketType,
        error_code = ErrorCode,
        frame_type = FrameType,
        reason_phrase_length = ReasonPhraseLength,
        reason_phrase = ReasonPhrase
    }.

deserialize_application(Bin) ->
    <<PacketType:8, ErrorCode:32, ReasonPhraseLength:8, ReasonPhrase:ReasonPhraseLength/binary>> = Bin,
    #application_close_packet{
        packet_type = PacketType,
        error_code = ErrorCode,
        reason_phrase_length = ReasonPhraseLength,
        reason_phrase = ReasonPhrase
    }.

serialize_connection(#connection_close_packet{packet_type=PacketType, error_code=ErrorCode, frame_type=FrameType, reason_phrase_length=ReasonPhraseLength, reason_phrase=ReasonPhrase}) ->
    <<PacketType:8, ErrorCode:32, FrameType:8, ReasonPhraseLength:8, ReasonPhrase/binary>>.

serialize_application(#application_close_packet{packet_type=PacketType, error_code=ErrorCode, reason_phrase_length=ReasonPhraseLength, reason_phrase=ReasonPhrase}) ->
    <<PacketType:8, ErrorCode:32, ReasonPhraseLength:8, ReasonPhrase/binary>>.
