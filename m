From: Rob Taylor <rob.taylor@codethink.co.uk>
Subject: Re: GObject introspection patches
Date: Wed, 05 Sep 2007 20:21:51 +0100
Message-ID: <46DF01CF.1090600@codethink.co.uk>
References: <1188940117.10888.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 208-78-103-131.slicehost.net ([208.78.103.131]:43073 "EHLO
	mail.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275AbXIETSJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 5 Sep 2007 15:18:09 -0400
In-Reply-To: <1188940117.10888.17.camel@localhost>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mathias Hasselmann <mathias.hasselmann@gmx.de>
Cc: linux-sparse@vger.kernel.org

Mathias Hasselmann wrote:
> Hello,
> 
> For GObject introspection c2xml has to be extended to output information
> about custom attributes like this:
> 
>           GList* create_list() __attribute__((element_type(char*)))
> 
> Attached patch set adds support for custom attributes to c2xml. It also
> changes c2xml to provide command line options and to output initializer
> expressions. The patchset also is available via git:
> 
> http://taschenorakel.de/gitweb/?p=sparse;a=shortlog;h=gobject-introspection
> 
> Ciao,
> Mathias

> From 98fae4f8d2d1f375a18aeaf1e0a0c71107fbeba8 Mon Sep 17 00:00:00 2001
> From: Mathias Hasselmann <mathias.hasselmann@gmx.de>
> Date: Tue, 4 Sep 2007 22:26:47 +0200
> Subject: [PATCH] Introduce attribute structure for storing custom attributes in symbol nodes.
> 
> Signed-off-by: Mathias Hasselmann <mathias.hasselmann@gmx.de>

This patch looks good to me, from my (albeit limited) knowledge of
sparse internals. It would be good to have someone with deeper
understanding comment.

From 124215ffb5ba8ae28028588e1f12d2a586d21e20 Mon Sep 17 00:00:00 2001
From: Mathias Hasselmann <mathias.hasselmann@gmx.de>
Date: Tue, 4 Sep 2007 22:30:14 +0200
Subject: [PATCH] Extract init_keyword_table from init_parser for usage
in c2xml.

Signed-off-by: Mathias Hasselmann <mathias.hasselmann@gmx.de>

Again, this looks fine to me.

> From 42a4d680b17d6ed4d0cc1108cef5d1b299495f01 Mon Sep 17 00:00:00 2001
> From: Mathias Hasselmann <mathias.hasselmann@gmx.de>
> Date: Tue, 4 Sep 2007 22:34:15 +0200
> Subject: [PATCH] c2xml: Add support for custom attributes and omit end position information when
> equal to start position. Custom attributes are needed for GObject introspection
> to express details like this:
> 
>       GList* create_list() __attribute__((element_type(char*)))
> 
> Signed-off-by: Mathias Hasselmann <mathias.hasselmann@gmx.de>

This looks mostly fine, though I'm not sure about defining
attribute_table inside c2xml. Either these are generally useful and so
should be in (say) sparse.c, or they're specific to
Gobject-introspection, and so there should be a way of providing them as
input to c2xml, perhaps defined in an input xml document, and
namespacing them in the output appropriately?

> From be96d3c60e9e52e6448bf90444eb1e8bb3a48d5c Mon Sep 17 00:00:00 2001
> From: Mathias Hasselmann <mathias.hasselmann@gmx.de>
> Date: Tue, 4 Sep 2007 22:44:58 +0200
> Subject: [PATCH] c2xml: Implement command line options:
> 
>     -d           include document type declaration
>     -p           output position information for symbols
>     -o FILENAME  write the document to FILENAME
>     -h           display usage information - this page
> 
> Signed-off-by: Mathias Hasselmann <mathias.hasselmann@gmx.de>

This looks like it breaks commandline parsing, Mathias has already told
me on irc it needs fixing :) The options it gives could be useful
though, if refactored to work correctly with the sparse commandline parsing.

> From 1605b862637aecd54cfd5b159c96415bdddf46c3 Mon Sep 17 00:00:00 2001
> From: Mathias Hasselmann <mathias.hasselmann@gmx.de>
> Date: Tue, 4 Sep 2007 22:47:50 +0200
> Subject: [PATCH] c2xml: Output initializer expressions, needed for instance for enum values.
> 
> Signed-off-by: Mathias Hasselmann <mathias.hasselmann@gmx.de>

The second hunk of this patch looks unnecessary, and I think the first
hunk should be included in 42a4d680.

Thanks,
Rob Taylor



-- 
Rob Taylor, Codethink Ltd. -  http://codethink.co.uk
