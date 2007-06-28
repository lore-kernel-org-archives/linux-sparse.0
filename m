From: Rob Taylor <rob.taylor@codethink.co.uk>
Subject: Re: [PATCH] c2xml
Date: Thu, 28 Jun 2007 12:00:59 +0100
Message-ID: <468394EB.5070608@codethink.co.uk>
References: <46826B68.5040302@codethink.co.uk> <1182970187.8970.145.camel@josh-work.beaverton.ibm.com> <46834AE1.8010107@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 208-78-103-131.slicehost.net ([208.78.103.131]:58952 "EHLO
	mail.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757641AbXF1K7d (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 06:59:33 -0400
In-Reply-To: <46834AE1.8010107@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Josh Triplett <josht@linux.vnet.ibm.com>, linux-sparse@vger.kernel.org

Josh Triplett wrote:
> Josh Triplett wrote:
>> On Wed, 2007-06-27 at 14:51 +0100, Rob Taylor wrote:
>>> Here's something I've hacked up for my work on gobject-introspection
>>> [1]. It basically dumps the parse tree for a given file as simplistic
>>> xml, suitable for further transformation by something else (in my case,
>>> some python).
>>>
>>> I'd expect this to also be useful for code navigation in editors and c
>>> refactoring tools, but I've really only focused on my needs for c api
>>> description.
>>>
>>> There are 3 patches here. The first introduces a field in the symbol
>>> struct for the end position of the symbol. I've added this in my case
>>> for documentation generation, but again I think it'd be useful in other
>>> cases. The next introduces a sparse_keep_tokens, which parses a file,
>>> but doesn't free the tokens after parsing. The final one adds c2xml and
>>> the DTD for the xml format. It builds conditionally on whether libxml2
>>> is available.
>>>
>>> All feedback appreciated!
>> Wow.  Very nice.  I can already think of several other uses for this.
> [...]
>>       * Please consider including information from the context and
>>         address space attributes.
> 
> Actually, don't worry about that one; we can always add it later, and I'd love
> to see this get merged as soon as possible.

Yes, I was about to say I deliberately left this out as I don't need it
for my use case, but it shouldn't be difficult to add if the need arises
for it.

>>       * Rather than the current base-type and base-type-builtin
>>         mechanism, you might consider having designated IDs for the base
>>         types and using those in base-type.  You could even output the
>>         builtin types if you want.  I don't know if this makes things
>>         easier or harder for consumers of the output; what do you think?
> 
> On second thought, ignore this.  We can always change it later, but having a
> special syntax for the base types makes sense to me.  Anything that cares
> about types will need to understand the base types.

Agreed.

>>       * I don't know if sparse_keep_symbols seems like the right API.
>>         Sparse's approach to memory management (or lack thereof) bugs me
>>         a bit.  More importantly, though, it makes the hierarchy of
>>         functions sparse(), then __sparse(), then sparse_keep_symbols(),
>>         which seems strange.  I don't know a better solution offhand,
>>         though; don't worry too much about addressing this.
> 
> Ignore this too.  The API you propose will work fine for now, and I don't want
> to hold up merging the patch on trying to think of the perfect API for
> something not directly related to the point of your patch.

Heh, yeah, sorting out memory management is quite a scary prospect :) I
think we'd basically need to go for some sort of reference counting
scheme, but that'd need some very careful work to deal with potential
cycles.

>> Thanks again for this work; it looks great, and highly useful.

Thanks!

Rob
Rob
