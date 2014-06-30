From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Staging/comedi: Fixes static analysis warning raised by sparse
Date: Mon, 30 Jun 2014 10:49:18 -0700
Message-ID: <CANeU7QmOq7iqy8--A3srr0yMQ4f92BRi9wrLT1pYAHYstwsToA@mail.gmail.com>
References: <53965E53.5080504@gmail.com>
	<20140610054741.GE5500@mwanda>
	<DC148C5AA1CEBA4E87973D432B1C2D8825E9AE6A@P3PWEX4MB008.ex4.secureserver.net>
	<20140611065612.GQ5015@mwanda>
	<DC148C5AA1CEBA4E87973D432B1C2D8825E9CBD6@P3PWEX4MB008.ex4.secureserver.net>
	<20140611212425.GW5015@mwanda>
	<20140611214529.GB16940@cloud>
	<CANeU7Qki9Fg=Vz8gryT1bL+BMnjuvWZTH7uNvyk-HjdSPsiiyg@mail.gmail.com>
	<20140628192020.GA2501@thin>
	<CANeU7QkKnh-Xq4CVAkNFs54KieNrDqD93uuWijCOYwj0iorHvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:37314 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbaF3RtS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 Jun 2014 13:49:18 -0400
Received: by mail-qg0-f44.google.com with SMTP id j107so2327626qga.17
        for <linux-sparse@vger.kernel.org>; Mon, 30 Jun 2014 10:49:18 -0700 (PDT)
In-Reply-To: <CANeU7QkKnh-Xq4CVAkNFs54KieNrDqD93uuWijCOYwj0iorHvg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Hartley Sweeten <HartleyS@visionengravers.com>, "Marcos A. Di Pietro" <marcosadp@gmail.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jun 28, 2014 at 8:09 PM, Christopher Li <sparse@chrisli.org> wrote:
> So if there is a bug, It is sparse did not know exactly which part
> of the code is dead on AST level. If you enable the "#if 0" inside

I am thinking about how to fix the dead code issue. Try to do more
than trivial dead code analyses is really not the right place for AST.

Actually, there is a simple way out. We can just move the warning
to the linearize instruction level.

 $ ./test-linearize /tmp/test_shift.c
/tmp/test_shift.c:8:26: warning: shift too big (4294967295) for type int
main:
.L0x7f8f490e5010:
    <entry-point>
    # call      %r1 <- filter, $0xffffffff
    ret.32      $0

You see, once drop into the instruction level, sparse already
know that code is dead.

Since the sparse is already linearizing instruction to perform
the context check. We just need to move the warning from AST
to instruction level.

The warning should be trivial in instruction level. We are looking
for an instruction has larger than type size constant shift
value.

Comments and feed backs, even patches?

Chris
