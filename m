From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [PATCH] c2xml
Date: Wed, 27 Jun 2007 11:49:47 -0700
Message-ID: <1182970187.8970.145.camel@josh-work.beaverton.ibm.com>
References: <46826B68.5040302@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:47774 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673AbXF0Str (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 14:49:47 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5RInkC3025798
	for <linux-sparse@vger.kernel.org>; Wed, 27 Jun 2007 14:49:46 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5RInkAx248558
	for <linux-sparse@vger.kernel.org>; Wed, 27 Jun 2007 12:49:46 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5RInjZe027127
	for <linux-sparse@vger.kernel.org>; Wed, 27 Jun 2007 12:49:46 -0600
In-Reply-To: <46826B68.5040302@codethink.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Rob Taylor <rob.taylor@codethink.co.uk>
Cc: linux-sparse@vger.kernel.org

On Wed, 2007-06-27 at 14:51 +0100, Rob Taylor wrote:
> Here's something I've hacked up for my work on gobject-introspection
> [1]. It basically dumps the parse tree for a given file as simplistic
> xml, suitable for further transformation by something else (in my case,
> some python).
> 
> I'd expect this to also be useful for code navigation in editors and c
> refactoring tools, but I've really only focused on my needs for c api
> description.
> 
> There are 3 patches here. The first introduces a field in the symbol
> struct for the end position of the symbol. I've added this in my case
> for documentation generation, but again I think it'd be useful in other
> cases. The next introduces a sparse_keep_tokens, which parses a file,
> but doesn't free the tokens after parsing. The final one adds c2xml and
> the DTD for the xml format. It builds conditionally on whether libxml2
> is available.
> 
> All feedback appreciated!

Wow.  Very nice.  I can already think of several other uses for this.

A few suggestions:

      * Please sign off your patches.  See
        http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;hb=HEAD;f=Documentation/SubmittingPatches , section "Sign your work", for details on the Developer's Certificate of Origin and the Signed-off-by convention.  I really need to include some documentation in the Sparse source tree, though.
      * Rather than specifying start="line:col" end="line:col", how
        about splitting those up into start-line, start-col, end-line,
        and end-col?  That would avoid the need to do string parsing
        after reading the XML.
      * Positions have file information associated with them.  A symbol
        might potentially start in one file and end in another, if
        people play crazy games with #include.  start-file and end-file?
      * Typo in examine_namespace: "Unregonized namespace".
      * get_type_name seems generally useful, and several other parts of
        Sparse (such as in evaluate.c and show-parse.c) could become
        simpler by using it.  How about putting it in symbol.c and
        exposing it via symbol.h?  Can you do that in a separate patch,
        please?
      * Also, should get_type_name perhaps look up the string in an
        array rather than using switch?  (I don't know which makes more
        sense.)
      * I don't know how much work this would require, but it doesn't
        seem like c2xml gets much value out of using libxml, so would it
        make things very painful to just print XML directly?  It would
        certainly make things like BAD_CAST and having to snprintf to
        local buffers go away.  If you count on libxml for some form of
        escaping or similar, please ignore this; however, as far as I
        can tell, all of the strings that c2xml works with (such as
        identifiers) can't have unusual characters in them.
      * Please don't include vim modelines in source files.  (Same goes
        for emacs and similar.)
      * Please explicitly limit the possible values of the type
        attribute to those that Sparse produces, rather than allowing
        any arbitrary CDATA.  The same goes for a few other 
      * Please consider including information from the context and
        address space attributes.
      * In examine_modifiers, please use C99-style designated assignment
        for the modifiers array, for clarity and robustness.
      * I suspect several of the modifiers in examine_modifiers don't
        need to generate output; I think you want to ignore everything
        in MOD_IGNORE.
      * Rather than the current base-type and base-type-builtin
        mechanism, you might consider having designated IDs for the base
        types and using those in base-type.  You could even output the
        builtin types if you want.  I don't know if this makes things
        easier or harder for consumers of the output; what do you think?
      * I don't know if sparse_keep_symbols seems like the right API.
        Sparse's approach to memory management (or lack thereof) bugs me
        a bit.  More importantly, though, it makes the hierarchy of
        functions sparse(), then __sparse(), then sparse_keep_symbols(),
        which seems strange.  I don't know a better solution offhand,
        though; don't worry too much about addressing this.

Note that you don't need to address all of these before resending.  In
particular, I'd love to merge the first patch, and I just need a signoff
for it.

Thanks again for this work; it looks great, and highly useful.

- Josh Triplett
