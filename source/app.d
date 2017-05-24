/*
  this file has the main entry point to the CLI
 */
import std.stdio;
import blockchain;

void main()
{
    auto someArtifact = Artifact([], ArtifactHeader([], 0u), null);
    write("hello, world.\n");
}
