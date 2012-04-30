From: Christopher Li <sparse@chrisli.org>
Subject: Re: dependency tee from c parser entities downto token
Date: Mon, 30 Apr 2012 15:58:30 -0700
Message-ID: <CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42598 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757099Ab2D3W6a (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 Apr 2012 18:58:30 -0400
Received: by ghrr11 with SMTP id r11so1768617ghr.19
        for <linux-sparse@vger.kernel.org>; Mon, 30 Apr 2012 15:58:30 -0700 (PDT)
In-Reply-To: <4F967865.60809@gaisler.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <konrad@gaisler.com>
Cc: linux-sparse@vger.kernel.org

On Tue, Apr 24, 2012 at 2:54 AM, Konrad Eisele <konrad@gaisler.com> wrote:
> Hi, I'd like to extend sparse so that I can preserve a
> dependency tree that goes from c parse entities all
> the way down to single tokens. There are several places
> this can be useful:

Sorry for the delay. I take a some time to think about this problem.

May I ask some high level questions? I am trying to understand why
this this token level dependency is useful. One alternative is that,
you do a per-processor stage on the source file. Then you have one
big post processed source. The current sparse can run on that processed
source file and get all the symbol dependency.

Because each symbol has "pos" and "endpos" member. You only need
to recursively walk the ctype of the symbols you can get the shrink version
of the source code. The draw back with that is, all the macro has been
expended, you will not able to see the macro names etc.

Also, if you change the source file, the shrinking process has to be redone
because it might use new macros. So the shrinking + compiling is not
necessary a saving compare to directly compiling without the shrinking.
I figure you might have a slightly different usage module in mind to justify
the shrinking. Please help me understand how you intend to use it.

I think if the source file doesn't need pre-processing. Sparse can do symbol
dependency already. What you really want is actually being able to back
trace in the pre-processing stage, what macro has been expand and what
is the original form on the expanded value.

Chris
