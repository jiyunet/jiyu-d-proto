import std.outbuffer : OutBuffer;
import std.bitmanip : nativeToBigEndian;
import std.container.array : Array;
import std.digest.sha : SHA256;

alias hash_function = SHA256;
alias addr = ubyte[32]; // This is the hash size.
alias signature = ubyte[32]; // This is also the hash size but for different reasons.
alias timestamp = ulong;

struct ArtifactEntry {
    signature sig;
    Artifact artifact;
}

struct Artifact {
    ushort type;
    timestamp time;
    addr authorDeclAddr;
    ArtifactContents contents;
}

interface ArtifactContents {
    ubyte[] getBytes();
}

class UnknownArtifact : ArtifactContents {

    ubyte[] raw;

    ubyte[] getBytes() {
        return raw;
    }

}
