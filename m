From: Christopher Li <sparse@chrisli.org>
Subject: [0/4] inspector for sparse
Date: Fri, 2 Apr 2010 11:36:45 -0700
Message-ID: <u2n70318cbf1004021136t65b4d8acmf8bfd7e18b410dfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.211.172]:41080 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab0DBSgp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Apr 2010 14:36:45 -0400
Received: by ywh2 with SMTP id 2so1519611ywh.33
        for <linux-sparse@vger.kernel.org>; Fri, 02 Apr 2010 11:36:45 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Kamil Dudka <kdudka@redhat.com>, Josh Triplett <josh@joshtriplett.org>

Hi,

When I debug the enum int patch, some times I wish I have a better tools
to help me understand what is going on with the internal sprase data structure.
There is debug_symbol() to help in some degree, but it does not show anything
other than symbol type. E.g. expression and statments.

test-parsing's output is more like assembly rather than a syntax tree.
There is debug_symbol() but it only print out the symbol type. It does not
go into expression. So the interesting stuff like expression  is hard to see.

I want some thing it can display different types of C structure with expandable
sub node for its member. Some thing like a file folder you can expand it see its
content.

I first look at the GtkTreeView. It seems capable of doing what I want.
The interface is cumbersome to use and I am really not a GUI person.
So I build some custom tree model to simplify the interaction with GTK.
That is the first patch in the series.

The second patch of the series try to inspect C structure one at time.
It is driven by the gtk tree model. It use a some glib function but it does
not have any GTK knowledge.

The interface is generic enough that you should be able to do a cursor
version from it without changing the code.

The third patch adds the test-inspect program which launch a gtk window.
Oh, I did not bother to make the first two patches compile itself
until this one.

Please play with it. As always, feed back are welcome.

The C structure inspection is rather incomplete currently. It is very easy to
expand it to show additional types and members. The last patch is an example.
It is going to be very rewarding to extend the inspector. It does not
require you have deep understanding of the sparse AST tree, it helps
*you* to understand how sparse internal AST works.

So patches are very welcome as well. Any one want to help?

Chris
