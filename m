From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/3] Make 'linearize_switch()' helper function
Date: Sun, 28 Aug 2011 00:31:35 -0700
Message-ID: <CANeU7Q=23KfP6LmdKFaM4yjobAsD-gx287BAnJu9JM-z_HL+Ag@mail.gmail.com>
References: <alpine.LFD.2.02.1108271424400.18733@i5.linux-foundation.org>
	<alpine.LFD.2.02.1108271427260.18733@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38624 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab1H1Hbg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 03:31:36 -0400
Received: by qyk15 with SMTP id 15so305894qyk.19
        for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 00:31:35 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1108271427260.18733@i5.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

On Sat, Aug 27, 2011 at 2:27 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Sat, 27 Aug 2011 11:41:35 -0700
> Subject: [PATCH 2/3] Make 'linearize_switch()' helper function
>
> Rather than do it in that huge 'linearize_statement()' function, spli=
t
> out the switch generation case. =A0Avoids one level of indentation, a=
nd
> makes for simpler and more straightforward functions.

I apply the series already.

BTW, I want to mention this, the current implementation of linearize sw=
itch
statement is wrong. This is not about this patch. It is there at the ve=
ry first
linearization of switch statement.

The current implementation works fine if the case statement does not ov=
erlap.
If the case statement overlap like "Duff's device", the linearization
will generate
repeated code.

The better way to do it should be linearize from "stmt->switch_statemen=
t"
instead of "switch_case->symbol_list". In other words, "stmt->switch_st=
atement"
contain the full body of the switch statement.
"switch_case->symbol_list" is just
a list of case statement in the switch statement, like a list of
labels. Some of those
case statement can be embedded in other case statement. Linearization
will emit the
inner case statement twice. The code it emit will function currently,
but it is not
optimal because it has duplicate blocks.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
