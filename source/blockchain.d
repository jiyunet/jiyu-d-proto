/*
 * this file holds data definitions for the components of the blockchain
 */
import std.outbuffer : OutBuffer;
import std.bitmanip : nativeToBigEndian;
import std.container.array : Array;
import std.digest.sha : SHA256;

alias protocol_digest = SHA256;

/*
 * I don't know what the naming conventions for D are.
 * I'm using _t for aliases, but is this good?
 */
alias credit_t = uint;
alias sign_t = ubyte[]; // SHA-256 -> 32 bytes

/*
 * what are addresses? are they just hashes?
 * why don't we use signatures as addresses, since they're basically
 * the same thing? something to think about...
 */
alias addr_t = ubyte[];

/*
 * an artifact created by some identity in the blockchain
 */
struct Artifact {

    sign_t signature;
    ArtifactHeader header;
    ArtifactData data;

    /* updates the digest with this data */
    void hash(protocol_digest* dig) {
        this.header.hash(dig);
        this.data.hash(dig);
    }

}

/*
 * the header information contained in all artifacts
 */
struct ArtifactHeade {

    addr_t author;
    ulong timestamp; // ulong = 8 bytes

    /* updates the digest with this data */
    void hash(protocol_digest* dig) {
        dig.put(this.author);
        dig.put(nativeToBigEndian(this.timestamp));
    }

}

/*
 * an interface for any types of artifacts
 */
interface ArtifactData
{
    /* returns the lowest version of the protocol that supports this kind of artifact */
    uint getVersionNum();

    /* returns the credit cost the author payed to publish this artifact */
    credit_t getCost();

    /* updates the digest with this data */
    void hash(protocol_digest* dig);
}


/*
 * a PoS block in the chain
 */
struct Block {

    sign_t signature;
    addr_t author;
    ulong timestamp;
    addr_t prev;
    Array!(addr_t) artifacts;

    /* updates the digest with this data */
    void hash(protocol_digest* dig) {
        dig.put(this.author);
        dig.put(nativeToBigEndian(this.timestamp));
        dig.put(this.prev);
        foreach(addr_t a; artifacts) {
            dig.put(a);
        }
    }

}
