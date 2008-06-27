From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: multiple source files [was four sparse patches]
Date: Fri, 27 Jun 2008 11:47:57 -0700
Message-ID: <1214592477.5189.7.camel@josh-work.beaverton.ibm.com>
References: <32e600e90805021158vb6be3c9jbb75c3a61345448@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:44192 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753609AbYF0SsC (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 14:48:02 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5RIlxGd029300
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 14:47:59 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m5RIlxSe234310
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 14:47:59 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m5RIlwQN013446
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 14:47:59 -0400
In-Reply-To: <32e600e90805021158vb6be3c9jbb75c3a61345448@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Geoff Johnstone <geoffsheep.johnstonefrog@googlemail.com>
Cc: Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

On Fri, 2008-05-02 at 19:58 +0100, Geoff Johnstone wrote:
> Take three files:
> 
> /* test.h */
> typedef struct foo *Foo;
> 
> void a (Foo foo);
> void b (Foo foo);
> 
> 
> /* test1.c */
> #include "test.h"
> void a (Foo foo) { }
> 
> 
> /* test2.c */
> #include "test.h"
> void b (Foo foo) { }
> 
> 
> With sparse 0.4.1:
> 
> $ sparse test1.c
> $ sparse test2.c
> $ sparse test[12].c
> test2.c:3:6: error: symbol 'b' redeclared with different type
> (originally declared at test.h:4) - incompatible argument 1 (different
> base types)
> 
> ...i.e. the problem only occurs with multiple source files on the
> sparse command line. (The userland project mentioned above has a build
> system that invokes the compiler once, passing all necessary source
> files, because it also builds on Windows, where process creation is
> remarkably slow so invoking cl.exe once per source file is prohibitive).

I've observed this problem as well, and I would like to see it fixed.
Many other legitimate reasons exist to run the compiler on many files at
once.  For example, consider GCC's --combine and -fwhole-program
options.

> I think that the problem may be rooted in main():
>   // Expand, linearize and show it.
>   check_symbols(sparse_initialize(argc, argv, &filelist));
>   FOR_EACH_PTR_NOTAG(filelist, file) {
>     check_symbols(sparse(file));
>   } END_FOR_EACH_PTR_NOTAG(file);
> 
> i.e. sparse doesn't reinitialize for each source file.
> 
> My patch a few weeks ago silences the error, but in the light of this
> I think that it's working around rather than fixing the problem. The
> "correct" fix would seem to be to re-initialise sparse for each source
> file. However, sparse's data structures weren't written with this in
> mind, so a patch would be rather invasive. It might be simpler to say
> that sparse must only be invoked on one source file and to modify cgcc
> instead?

I'd like Sparse to handle multiple files on the same command line.  I
don't mind invasive patches, though as always I'd like to see them
broken up into incremental patches when possible.

I don't necessarily want Sparse fully re-initialized to the point where
it forgets what it learned from the previous source files.  Remembering
the contents of previous files can only help with cross-module analysis.
However, Sparse needs to isolate symbols by file, and avoid carrying
over the visible symbols from one file to the next.

- Josh Triplett


