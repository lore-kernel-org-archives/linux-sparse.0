From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Staging/comedi: Fixes static analysis warning raised by sparse
Date: Sat, 28 Jun 2014 20:09:25 -0700
Message-ID: <CANeU7QkKnh-Xq4CVAkNFs54KieNrDqD93uuWijCOYwj0iorHvg@mail.gmail.com>
References: <53965E53.5080504@gmail.com>
	<20140610054741.GE5500@mwanda>
	<DC148C5AA1CEBA4E87973D432B1C2D8825E9AE6A@P3PWEX4MB008.ex4.secureserver.net>
	<20140611065612.GQ5015@mwanda>
	<DC148C5AA1CEBA4E87973D432B1C2D8825E9CBD6@P3PWEX4MB008.ex4.secureserver.net>
	<20140611212425.GW5015@mwanda>
	<20140611214529.GB16940@cloud>
	<CANeU7Qki9Fg=Vz8gryT1bL+BMnjuvWZTH7uNvyk-HjdSPsiiyg@mail.gmail.com>
	<20140628192020.GA2501@thin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:48823 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbaF2DJ0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 28 Jun 2014 23:09:26 -0400
Received: by mail-qc0-f169.google.com with SMTP id c9so5915079qcz.28
        for <linux-sparse@vger.kernel.org>; Sat, 28 Jun 2014 20:09:25 -0700 (PDT)
In-Reply-To: <20140628192020.GA2501@thin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Hartley Sweeten <HartleyS@visionengravers.com>, "Marcos A. Di Pietro" <marcosadp@gmail.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jun 28, 2014 at 12:20 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> Except that "filter" has an "int channel" (signed), so it can
> successfully test "channel < 0" and return early; it'll never call
> ni_stc_dma_channel_select_bitfield(channel) with a negative number.
>
> I do agree that this code should sort out the signedness of its types,
> but in this case I don't think the bad shift can actually happen, making
> this a false positive.

Ah, I see. I agree that the warning happen on the dead code.

However, the root cause for the warning is not because sparse can not
figure out the value of "channel". Sparse actually correctly does the
inline and figure out "channel" is 4294967295. The root cause
of your complain against sparse is that it happen on the dead code.

I don' think the patch is the right fix for this problem though.
This patch try to silence a warning purely because it can happen
on dead code, otherwise perfectly valid warning.

My point is that, it can happen on dead code is not a valid reason
to weaken the warning. Sparse can give any possible warning on
dead code. e.g. On the dead code path, you can construct an address
space warning. Do we weakling the address space warning purely
because it can happen on the dead code as well? Of course not.
The same apply to any other sparse warnings.

So if there is a bug, It is sparse did not know exactly which part
of the code is dead on AST level. If you enable the "#if 0" inside
expand_if_statement(), sparse can actually correctly expand
"if (channel < 0)" into "return". Of course, it still can't handle jump
into dead code situation, which is the reason that piece of code
is not enabled in the first place. It needs more work. I think that is
a better approach than just random weakening some warnings
on dead code path.

Chris
