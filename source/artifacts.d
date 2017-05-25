/*
 * this file holds definitions of known artifact types
 */
import std.algorithm.iteration;
import std.outbuffer : OutBuffer;
import std.array : array;
import blockchain;

enum ArtifactType : uint {
    TYPE_REPLY,
    TYPE_INVITE
}

/*
 * an artifact that is not understood by the protocol but accepted anyways
 */
class UnknownArtifact : ArtifactData {

    uint type;
    uint ver;
    credit_t cost;
    ubyte[] raw;

    this(uint type, uint ver, credit_t cost, ubyte[] raw) {
        this.type = type;
        this.ver = ver;
        this.cost = cost;
        this.raw = raw;
    }

    uint getVersionNum() {
        return this.ver;
    }

    credit_t getCost() {
        return this.cost;
    }

    void hash(protocol_digest* dig) {
        dig.put(this.raw);
    }

}

/*
 * basic post mechanism: a reply to another post
 */
class ReplyArtifact : ArtifactData {

    addr_t replyTo;
    ubyte[] contents;

    this(addr_t to, string text) {
        this.replyTo = to;
        this.contents = cast(ubyte[]) text.dup;
    }

    uint getVersionNum() {
        return 0x0000;
    }

    credit_t getCost() {
        return 10;
    }

    void hash(protocol_digest* dig) {
        dig.put(this.replyTo);
        dig.put(this.contents);
    }
    
}
