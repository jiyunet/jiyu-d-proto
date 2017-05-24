/*
  this file holds definitions of known artifact types
*/
import std.algorithm.iteration;
import std.outbuffer : OutBuffer;
import std.array : array;
import blockchain;

class ReplyArtifact : ArtifactData
{
    addr_t replyTo;
    ubyte[] contents;

    this(addr_t to, string text)
    {
        this.replyTo = to;
        this.contents = cast(ubyte[]) text.dup;
    }
    
    uint versionNum()
    {
        return 0x0000;
    }

    void hash(BLOCKCHAIN_SHA* dig)
    {
        dig.put(this.replyTo);
        dig.put(this.contents);
    }

    credit_t cost()
    {
        return 10;
    }

    void serialize(OutBuffer ob)
    {
        ob.write(this.replyTo);
        ob.write(cast(int) this.contents.length);
        ob.write(this.contents);
    }
}
