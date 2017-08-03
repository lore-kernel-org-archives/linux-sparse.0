From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Thu, 3 Aug 2017 23:49:08 +0200
Message-ID: <20170803214906.dvvyibtf53j3ah6m@ltop.local>
References: <CAMHZB6E8PwoeofUFRB_zdVx=HqqHM72UhcqwH1QPDa_U+4V-DQ@mail.gmail.com>
 <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
 <20170730151254.xlnz7c4zphhnhump@ltop.local>
 <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
 <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
 <20170801203357.4ywboptvr6tlytab@ltop.local>
 <CANeU7QkShNBJ2nWh0wvTN3fTvwX710BT-g=aFf+GS1upnD_Gxw@mail.gmail.com>
 <CAExDi1R9QZJorwhMq4=nRLvMet+S0RCpeiMurko=rNYLpu8c2A@mail.gmail.com>
 <CANeU7QmzundH7qpdYhQqDJgBv+5pPemwft+1uH5oVQ1POnoQDw@mail.gmail.com>
 <CAMHZB6E0NYy_bNJftB5n4BFZ4-fNf___n0RN1OPb+jkV4Ry-Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37606 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbdHCVtP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 3 Aug 2017 17:49:15 -0400
Received: by mail-wm0-f52.google.com with SMTP id t201so5871672wmt.0
        for <linux-sparse@vger.kernel.org>; Thu, 03 Aug 2017 14:49:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMHZB6E0NYy_bNJftB5n4BFZ4-fNf___n0RN1OPb+jkV4Ry-Dw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Thu, Aug 03, 2017 at 12:50:20AM +0200, Luc Van Oostenryck wrote:
> On Wed, Aug 2, 2017 at 3:17 AM, Christopher Li <sparse@chrisli.org> wrote:
> > On Tue, Aug 1, 2017 at 5:46 PM, Luc Van Oostenryck
> > <luc.vanoostenryck@gmail.com> wrote:
> >> has any effects for sparse and the only effect of -O2 is
> >> to define __OPTIMIZE__.
> >
> > Yes, indeed. It is the -O2 make the difference.
> >
> > I recently upgrade to Fedora 26. I think it is the system header file
> > making a difference
> > on the __OPTIMIZE__. I attach two files here. O2.c is the one with -O2 flag
> > after processor. The 0.c is the one without.
> >
> > There is huge difference in them.
> >
> > I confirm with O2.c I am seeing the 24 second delay. And 0.c 4 seconds.
> >
> > I attach the two files with gzip.
> 
> It seems that the email was rejected on the mailing list.
> 
> > I think you should be able to reproduce it with O2.c now.
> 
> Yes, I can reproduce it now.
> The differences in the two file are not big. Basically, in -O2 there is
> - a bunch of small functions which have now an inline definition
> - a set of strcmp(winetest_platform, "wine") which are replaced
>   by a macro of hell.
> It's, of course, the last one which creates the problem.
> The macro seems to try to optimize the compare using the fact
> that the compiler will statically evaluate things like:
> - strlen("wine")
> - "wine"[0], "wine"[1], ...
> but sparse doesn't do this kind of simplification (yet) and this result
> in much much more code.
> 
> A first inspection of the generated code doesn't show anything
> obviously wrong but I don't exclude there is another problem.

I looked a bit more at this and the problem is not really because of this
evaluation sparse doesn't do. Also I work on a simplified version of the
files keeping nothing after test_ScriptItemize().

1) some numbers:
- GCC compile both preprocessed files in .9s with -O2.
- sparse check the O0 file in 1.93s and O2 file in 13s.
Thus even on the O0 file, the time is already too high because generaly
sparse is roughly 10 times faster than gcc -O2, here is twice as slow.

sparse emits roughly 5 times more BBs for the O2 file than for the O0 one,
it also emits roughly 5 times more instructions and take roughly 5 more
time to generate them (ok, 7 times more).
Thus the processing time and the number of instructions scale well
with the number of BBs emitted (and these BBs are emitted before any
simplification are made), so there is no sign of any non-linearity
nor any oddities with simplification/optimization that would run crazy.

2) I don't think that the lack of static evaluation of strlen("wine") or
   "wine"[0] is a problem here because where present this code is preceded
   by a test __builtin_constant_p(winetest_platform) wich fail.
   All this code is then quickly optimized away (but have first been
   generated as linearized code).

3) the situation with the macro from hell is even worse than I thought:
   it's present 7 times but is in a inline function which is itself
   used 292 times. Thus this code is present 2044 times!
   Some tests show that the time is (roughly) proportional to the
   number of time this inline function is used.

4) if we replace 'inline' by 'inline __attribute__((always_inline))'
   GCC needs roughly 58s to compile the O0 or O2 file.

My conclusion is that most of the problem here comes from the fact that:
   - sparse always inlines function marked as inline
   - and does so very early, before any optimizations (so the extra macro
     code is inlined 2044 times and need to be processed 2044 times).
GCC needs the same time for both file because it inlines functions after
a first optimization pass (I'm guessing here).

-- Luc
