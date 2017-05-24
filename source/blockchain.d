/*
  this file holds data definitions for the components of the blockchain
*/
import core.time;
import std.digest.sha;

alias BLOCKCHAIN_SHA = SHA256;

// I don't know what the naming conventions for D are.
// I'm using _t for aliases, but is this good?
alias credit_t = uint;
alias sign_t = ubyte[]; // SHA-256 -> 32 bytes

// what are addresses? are they just hashes?
// why don't we use signatures as addresses, since they're basically
// the same thing? something to think about...
alias addr_t = ubyte[];



struct Artifact
{
    sign_t signature;
    ArtifactHeader header;
    ArtifactData data;
}

struct ArtifactHeader
{
    addr_t author;
    ulong timestamp; // ulong = 64 bytes
}

interface ArtifactData
{
    credit_t cost();
    uint versionNum();
    void hashContents(BLOCKCHAIN_SHA* dig);
    // void serialize
}

