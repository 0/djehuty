module codecs.codec;

import interfaces.stream;

import core.time;
import core.string;

class BaseCodecProgress
{
}

// Description: Base class for all codecs
class Codec
{
public:

	String getName()
	{
		return new String("Unknown Codec");
	}

protected:

	int decoderState = 0;
	int decoderNextState = 0;

	int decoderSubState = 0;
	int decoderNextSubState = 0;

	int decoderFrameState = 0;
}