From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Running sparse on the Wine code (Was: Re: Ignore the cdecl and stdcall
 attributes for now.)
Date: Wed, 23 May 2007 01:44:13 +0200
Message-ID: <4653804D.3040306@redhat.com>
References: <20070515220536.GA23923@redhat.com> <464AA57B.3010205@freedesktop.org> <46520647.9090802@redhat.com> <4652819D.4040101@freedesktop.org> <46530112.2030105@redhat.com> <46535373.3020109@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:49455 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757911AbXEVXoT (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 19:44:19 -0400
In-Reply-To: <46535373.3020109@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

Josh Triplett wrote:
> Michael Stefaniuc wrote:
>> Josh Triplett wrote:
>>> Don't pass -Wall to sparse unless you really mean it.  cgcc filters it out for
>>> a reason; just because you have -Wall in CFLAGS for GCC doesn't mean you want
>>> -Wall for sparse.  Sparse -Wall includes some warnings with high false
>>> positive rates that you probably don't want.
>> Ok good to know. I went the easy way just duplicating the gcc command 
>> line and replacing gcc with sparse and adding -D__i386___ as Wine won't 
>> build without a processor type defined.
> 
> cgcc will define the processor type too.
> 
> I highly recommend trying a build with CC=cgcc.  You can then pass sparse
> flags in CFLAGS, and cgcc will filter them out before calling CC; you can
> also specify CHECK="sparse -Wfoo -Wno-bar" if you prefer not to change
> CFLAGS.
Hmm ... somehow i have confused cgcc with the code generating backend
that Jeff Garzik planned to write for sparse. With cgcc i won't need my
Wine build hack anymore and makes things even easier for me.

>> I'm still trying to figure out 
>> if sparse is useful (signal to noise ratio) for Wine.
> 
> It will likely take some time and Sparse modifications in order to parse
> Wine; however, I want Sparse to handle as much code as it can, not just
With cgcc Wine builds just fine (I didn't try yet the configure and make
depend stage of the build process). The only nitpick is that the ccache
cache from a normal build isn't valid anymore for the CC=cgcc run. I'll
have a look into it the next time i'll have to wait for the build to finish.

> Linux.  I appreciate you trying it on Wine; I think working on this will
> help both Wine and Sparse.
> 
>> Wine has some 
>> constraints (having to follow an existing old grown API; compatibility 
>> with other C processors on non Linux OSes) that aren't a burden for the 
>> Linux Kernel. E.g. a patch to move to C99 struct initializer was 
>> recently rejected due to compatibility concerns with other C compilers.
> 
> I just committed support for a -Wno-old-initializer flag to turn off the
> sparse warning on non-C99 initializers.
That was fast and I didn't even request it :)

>>> The undefined preprocessor identifiers from limits.h come from not using cgcc,
>>> which defines them.  Sparse should ideally define those itself.  You can work
>>> around the problem by using cgcc or by defining the symbols on the sparse
>>> command line as cgcc does.
>> I'll do a run with cgcc tonight instead of sparse and check the difference.
Updated
http://people.redhat.com/mstefani/wine/download/wine+sparse-make.output.bz2
That is the result of:
make clean; CHECK='sparse -Wno-transparent-union -Wno-old-initializer'
make CC=cgcc > make.out 2>&1
The output is with latest git sparse including the fix for the typedefs
to functions with a stdcall attribute.
I didn't look at the output yet as it is past bed time around here.

bye
	michael
-- 
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
Red Hat GmbH                    Email: mstefani@redhat.com
Hauptstaetterstr. 58            http://www.redhat.de/
D-70178 Stuttgart
