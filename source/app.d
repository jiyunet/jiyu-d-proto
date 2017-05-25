/*
 * this file has the main entry point to the CLI // FIXME This shouldn't be right.
 */
import std.stdio;
import std.digest.digest : toHexString;
import blockchain;
import artifacts;

void main() {
    ubyte[] sig = [1, 2, 3, 4, 5, 6];

    auto a1 = Artifact(sig, ArtifactHeader([], 0u),
                       new ReplyArtifact([1,2,3], "Hello, world!"));

    auto a2 = Artifact(sig, ArtifactHeader([], 0u),
                       new ReplyArtifact([1,2,4], "Hello, world!"));

    auto a3 = Artifact(sig, ArtifactHeader([], 0u),
                       new ReplyArtifact([1,2,3], "Hello, world!!"));

    protocol_digest sha;

    foreach (Artifact art; [a1, a2, a3]) {
        sha.start();
        art.hash(&sha);
        writeln(sha.finish().toHexString());
    }
}
