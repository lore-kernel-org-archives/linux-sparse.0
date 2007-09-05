From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: GObject introspection patches
Date: Wed, 05 Sep 2007 13:36:51 -0700
Message-ID: <1189024611.16411.11.camel@josh-work.beaverton.ibm.com>
References: <1188940117.10888.17.camel@localhost>
	 <46DF01CF.1090600@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:43494 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756097AbXIEUhP (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 5 Sep 2007 16:37:15 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l85KbElO020517
	for <linux-sparse@vger.kernel.org>; Wed, 5 Sep 2007 16:37:14 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l85KbEUX667144
	for <linux-sparse@vger.kernel.org>; Wed, 5 Sep 2007 16:37:14 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l85KbDYG025764
	for <linux-sparse@vger.kernel.org>; Wed, 5 Sep 2007 16:37:14 -0400
In-Reply-To: <46DF01CF.1090600@codethink.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Rob Taylor <rob.taylor@codethink.co.uk>
Cc: Mathias Hasselmann <mathias.hasselmann@gmx.de>, linux-sparse@vger.kernel.org

Thanks for reviewing these, Rob.  Further comments below.

On Wed, 2007-09-05 at 20:21 +0100, Rob Taylor wrote:
> Mathias Hasselmann wrote:
> > Hello,
> > 
> > For GObject introspection c2xml has to be extended to output information
> > about custom attributes like this:
> > 
> >           GList* create_list() __attribute__((element_type(char*)))
> > 
> > Attached patch set adds support for custom attributes to c2xml. It also
> > changes c2xml to provide command line options and to output initializer
> > expressions. The patchset also is available via git:
> > 
> > http://taschenorakel.de/gitweb/?p=sparse;a=shortlog;h=gobject-introspection
> > 
> > Ciao,
> > Mathias
> 
> > From 98fae4f8d2d1f375a18aeaf1e0a0c71107fbeba8 Mon Sep 17 00:00:00 2001
> > From: Mathias Hasselmann <mathias.hasselmann@gmx.de>
> > Date: Tue, 4 Sep 2007 22:26:47 +0200
> > Subject: [PATCH] Introduce attribute structure for storing custom attributes in symbol nodes.
> > 
> > Signed-off-by: Mathias Hasselmann <mathias.hasselmann@gmx.de>
> 
> This patch looks good to me, from my (albeit limited) knowledge of
> sparse internals. It would be good to have someone with deeper
> understanding comment.

Looks reasonable to me too; I wonder if this generalization could cover
some other things like contexts, particularly with appropriate
factored-out functions to combine attributes from symbols.

I'd like to hear any comments from others as well.

> From 124215ffb5ba8ae28028588e1f12d2a586d21e20 Mon Sep 17 00:00:00 2001
> From: Mathias Hasselmann <mathias.hasselmann@gmx.de>
> Date: Tue, 4 Sep 2007 22:30:14 +0200
> Subject: [PATCH] Extract init_keyword_table from init_parser for usage
> in c2xml.
> 
> Signed-off-by: Mathias Hasselmann <mathias.hasselmann@gmx.de>
> 
> Again, this looks fine to me.

Goes with the next change; seems OK, though I'd also like to hear
further comments from other people.

> > From 42a4d680b17d6ed4d0cc1108cef5d1b299495f01 Mon Sep 17 00:00:00 2001
> > From: Mathias Hasselmann <mathias.hasselmann@gmx.de>
> > Date: Tue, 4 Sep 2007 22:34:15 +0200
> > Subject: [PATCH] c2xml: Add support for custom attributes and omit end position information when
> > equal to start position. Custom attributes are needed for GObject introspection
> > to express details like this:
> > 
> >       GList* create_list() __attribute__((element_type(char*)))
> > 
> > Signed-off-by: Mathias Hasselmann <mathias.hasselmann@gmx.de>
> 
> This looks mostly fine, though I'm not sure about defining
> attribute_table inside c2xml. Either these are generally useful and so
> should be in (say) sparse.c, or they're specific to
> Gobject-introspection, and so there should be a way of providing them as
> input to c2xml, perhaps defined in an input xml document, and
> namespacing them in the output appropriately?

At a minimum, Sparse should know about these attributes in order to
ignore them.  In theory, Sparse should ignore any attributes it doesn't
know about, like GCC's -Wno-attributes, but that seems error-prone.
Alternatively, we could introduce some new builtin for testing for
available attributes; feature testing seems better than version testing,
and Sparse does develop new features over time, so that might help for
new Sparse features as well.  That would allow something like
conditional compilation based on individual attributes:
#if defined(__CHECKER__) && __attribute_exists__(element_type)
#define element_type(x) __attribute__((element_type(x)))
#endif

> > From be96d3c60e9e52e6448bf90444eb1e8bb3a48d5c Mon Sep 17 00:00:00 2001
> > From: Mathias Hasselmann <mathias.hasselmann@gmx.de>
> > Date: Tue, 4 Sep 2007 22:44:58 +0200
> > Subject: [PATCH] c2xml: Implement command line options:
> > 
> >     -d           include document type declaration
> >     -p           output position information for symbols
> >     -o FILENAME  write the document to FILENAME
> >     -h           display usage information - this page
> > 
> > Signed-off-by: Mathias Hasselmann <mathias.hasselmann@gmx.de>
> 
> This looks like it breaks commandline parsing, Mathias has already told
> me on irc it needs fixing :) The options it gives could be useful
> though, if refactored to work correctly with the sparse commandline parsing.

Just to clarify something: feel free to refactor Sparse's command-line
handling itself, which I think needs some work to make it usable by
anything other than the sparse backend.

- Josh Triplett
