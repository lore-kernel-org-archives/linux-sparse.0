From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Tue, 1 Aug 2017 22:33:58 +0200
Message-ID: <20170801203357.4ywboptvr6tlytab@ltop.local>
References: <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
 <CAExDi1Tkws5eRO1APi6tOdhGTzvaCpuHQ8k9h+T7odD5Yx3W3Q@mail.gmail.com>
 <CANeU7QnHbCmpTmD7ckokE7XezHB6-ZAFzX-h+J8cPe=wWxx3VA@mail.gmail.com>
 <CAMHZB6FjKnPojtirh0csQMXhZC-TT=hHRPne+z7q74joDHYdbg@mail.gmail.com>
 <CANeU7QnRQG84w+e-gTjp2yOZYdwq+itgExg_UTG-zUuRT8FYLg@mail.gmail.com>
 <CAMHZB6E8PwoeofUFRB_zdVx=HqqHM72UhcqwH1QPDa_U+4V-DQ@mail.gmail.com>
 <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
 <20170730151254.xlnz7c4zphhnhump@ltop.local>
 <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
 <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36945 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbdHAUeC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 1 Aug 2017 16:34:02 -0400
Received: by mail-wm0-f44.google.com with SMTP id t201so24902202wmt.0
        for <linux-sparse@vger.kernel.org>; Tue, 01 Aug 2017 13:34:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sun, Jul 30, 2017 at 06:16:03PM +0200, Luc Van Oostenryck wrote:
> On Sun, Jul 30, 2017 at 5:49 PM, Christopher Li <sparse@chrisli.org> wrote:
> 
> >>> >> In the memops finding dominating store is doing a lot worse. That is
> >>> >> why gcc complete that file almost instantly. Sparse takes 30 seconds
> >>> >> on my machine. One big problem is it did not cache the dominating
> >>> >> result. It is redoing the finding again and again.
> >>>
> >>> > Uh?
> >>> > Which input file your talking about?
> >>>
> >>> This ptrlist testing wine source file that takes  23 second for sparse to run.
> >>> I take a brief look at it, it is doing a lot of dominating search.
> >>
> >> Is it possible to have a pathname or a link?
> >
> > It is the very first email I send out:
> >
> >
> > git clone git://source.winehq.org/git/wine.git
> > cd win/dlls/usp10/tests
> >
> > The test command:
> >
> > time sparse -m64 -c -o usp10.o usp10.c -I. -I../../../include
> > -D__WINESRC__ -D_REENTRANT -fPIC -Wall -pipe -fno-strict-aliasing
> > -Wdeclaration-after-statement -Wempty-body -Wignored-qualifiers
> > -Wshift-overflow=2 -Wstrict-prototypes -Wtype-limits
> > -Wunused-but-set-parameter -Wvla -Wwrite-strings -Wpointer-arith
> > -Wlogical-op -gdwarf-2 -gstrict-dwarf -g -O2
> 
> OK, thanks. I'll take a look once the infinite loop problem will be closed.
> 
> > I think gcc compile this file very fast but sparse spend a lot of time on it.
> 
> Interesting.
> On most input sparse is much faster than gcc, often by a factor or 10
> or even more. But of course, if there is a problem with sparse ...
> 
> > My impression it is spending time repeat finding dominating stores.
> Possible indeed.

When I try the command you gave with -rc4 sparse I get:
	real	0m3.281s
	user	0m3.175s
	sys	0m0.097s
wich is very far from the 23-30s you got. Dunno what the difference could be.

For comparison, with the new 7 patches the time is now:
	real	0m2.146s
	user	0m1.928s
	sys	0m0.214s
wich is significatively faster.

And with gcc I get:
	real	0m2.153s
	user	0m2.080s
	sys	0m0.078s

Also, the result of the preprocessing is a 13K lines, 788K bytes file.

I would still expect that sparse is (much) faster than gcc, but
with the number I have here, I'm not sure I can say something is wrong.
But we should first find why you got 23-30s while I got 3.3.

-- Luc
