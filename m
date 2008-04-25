From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: confusing shift warning
Date: Fri, 25 Apr 2008 20:26:07 +0300
Message-ID: <e51f66da0804251026y4c6fbc25scedf04ab6c7dd6a0@mail.gmail.com>
References: <e51f66da0804250053x2ec991dbu9a5a54fdcbea2a2a@mail.gmail.com>
	 <33544769883882222@unknownmsgid>
	 <e51f66da0804250134g7f05cc8fp9011d508f49295e3@mail.gmail.com>
	 <e51f66da0804250158o333eb371nbc0f810076c274cb@mail.gmail.com>
	 <-3423297637585954490@unknownmsgid>
	 <e51f66da0804250637i4dff4c64p9d22a1162df14eb4@mail.gmail.com>
	 <-8184754938437793631@unknownmsgid>
	 <e51f66da0804250737r38582879s7dd41ee792756753@mail.gmail.com>
	 <1209139485.11744.25.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:35973 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbYDYR0J (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Apr 2008 13:26:09 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1494779nfb.21
        for <linux-sparse@vger.kernel.org>; Fri, 25 Apr 2008 10:26:07 -0700 (PDT)
In-Reply-To: <1209139485.11744.25.camel@dv>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On 4/25/08, Pavel Roskin <proski@gnu.org> wrote:
> On Fri, 2008-04-25 at 17:37 +0300, Marko Kreen wrote:
>  > >  I mean, they are both 0 unless -m32 or -m64 is specified.
>  >
>  > No, see other sections - they assume one of them is set unless overrided.
>
> If you are fixing a bug, you cannot rely on the code being correct.  Try
>  printing those variables:
>
>  printf("m32=%d, m64=%d\n", $m32, $m64);
>
>  It will be two zeroes.

I think you have misunderstood the point of the variables - they
only signify whether either argument was given on command line,
nothing more.  Each arch defaults implicitly to either of them,
so it needs to check if the other one was given, overriding the default.

>  > > > Or do you mean I cannot assume one of them as set, unless
>  > > > overrided on command line?  But other sections (spact, i86, ppc)
>  > > > do exactly that?
>  > >
>  > >  You cannot assume either of them to be 1 until cgcc is fixed.
>  >
>  > But how should the fix look like if you don't like mine?
>
> Well, it looks like cgcc is seriously broken.  In particular, it would
>  define x86_64 even if -m32 is specified, but it should define i386
>  instead.

You may be right here.  Seems like the x86_64 arch was tested only
with kernel compiles with -m64 always given.

>  Also, cgcc looks at uname output to determine the target CPU.  That
>  would default to 64 bit if a 32-bit system runs on a 64-bit kernel.  I
>  think cgcc should be running gcc instead to dump the machine settings.
>  I realize that it might be slower, but correctness is important here.
>  On the other hand, I'm not sure if we can rely on having gcc installed.
>
>  I would probably introduce a variable that would hold the memory model.
>  It could be ILP32 or LP64, but we could eventually support LLP64 (win64)
>  and even LP32 (win16).  It could be determined based on -m32/-m64
>  switches and uname output, but be could switch to "gcc -dumpmachine"
>  later.
>
>  The architecture would be adjusted based on the selected memory model.
>  And then it would be passed to add_specs().

Ok, this is somewhat of out my league.  But I think that having good
default and forcing user to use -mX for non-default case is good enough.

-- 
marko
