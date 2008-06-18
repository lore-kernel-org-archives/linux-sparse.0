From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Writing compilers, and example.c vs compile-i386.c
Date: Tue, 17 Jun 2008 17:41:40 -0700
Message-ID: <70318cbf0806171741g4d099e92vf0c0e9d7588fd7d6@mail.gmail.com>
References: <4856F196.8020403@cowlark.com>
	 <70318cbf0806161749u543fa338sf43a2ab787297eaa@mail.gmail.com>
	 <48584A33.7080602@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:18816 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757480AbYFRAll (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 17 Jun 2008 20:41:41 -0400
Received: by yw-out-2324.google.com with SMTP id 9so7546ywe.1
        for <linux-sparse@vger.kernel.org>; Tue, 17 Jun 2008 17:41:40 -0700 (PDT)
In-Reply-To: <48584A33.7080602@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On Tue, Jun 17, 2008 at 4:35 PM, David Given <dg@cowlark.com> wrote:

> Christopher Li wrote:
> However: I notice that the code seems to make use of OP_DEATHNOTE
> instructions to mark hardregs as being dead. However, these are only
> generated if track_pseudo_death(ep) is called --- and example.c never
> calls this. It *is*, however, called if -vdead is specified on the
> command line. Is this a bug in example.c or am I just misunderstanding
> things?

You understands it correctly. The example.c should call track_pseudo_death(ep).
It is a bug that I disable the dead node by default and forget to enable it for
example.c. For normal checking, death node is not needed, and if it is needed,
you can always generates it.

We should add the death node back for example.c. Patches are welcome
as well.

BTW, you shouldn't take example.c too seriously per Linus' suggestion.

> (Also, the OP_DEATHNOTE instructions appear to occur *before* the
> instruction that uses them last --- is this so that the instruction can
> reuse the register is the code generator sees fit to do so?)

I think so, it just let the code generator know that they don't need to preserve
that register any more for the next instruction they emit. It is a very naive
register allocations any way. Feel free to roll your own if you see fits.

> (In addition, I notice that once liveness tracking has been done phisrc
> nodes get annotated with the desired shared register that the phi should
> occupy; suddenly, the phi stuff all makes sense.)

Glad to hear that.


> (PS. Please don't cc me if you're also mailing the list --- I only need
> one copy!)

You mean your email client is not smart enough to realize that is the
same email :-)  I prefer to get CC directly to get a sense of being part of
the discussion. My email will filter differently if I am directly addressed.

Chris
