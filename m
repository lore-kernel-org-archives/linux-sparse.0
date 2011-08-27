From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linearize bug?
Date: Sat, 27 Aug 2011 12:26:17 -0700
Message-ID: <CA+55aFyBvAOVXevPhRC2+LgFJR4SNxqYZ2X36kW+Z0rpb=s1mQ@mail.gmail.com>
References: <4E588EB8.80808@garzik.org> <4E590F22.6030800@garzik.org>
 <CA+55aFxGwAXRWVcv_Qx6C4B_PKqzVVbc8O_znwUt_D6g1iDJvQ@mail.gmail.com>
 <201108271854.40694.kdudka@redhat.com> <CA+55aFyD7d3hNP4JJL+0yE3ZB-M-65iYT_ay0uH_i-wrBR49Ww@mail.gmail.com>
 <CA+55aFxK95i6AaDhgEteFsL8W_jRkxY93FQ-Z6FVJXix1g5DkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42186 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751216Ab1H0T0j (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 15:26:39 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7RJQbGH032157
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 12:26:38 -0700
Received: by wyg24 with SMTP id 24so3199572wyg.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 12:26:37 -0700 (PDT)
In-Reply-To: <CA+55aFxK95i6AaDhgEteFsL8W_jRkxY93FQ-Z6FVJXix1g5DkA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Pekka J Enberg <penberg@cs.helsinki.fi>

On Sat, Aug 27, 2011 at 10:27 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Which *should* have been semantically no difference what-so-ever. But
> it's been so long, I can't recall all the rules. It may be that trying
> to linearize the same expression twice (once for the entry condition,
> once for the loop end) was just something invalid.
>
> So the patch is just broken. Never mind.

Yes indeed.

The reason we cannot linearize the same expression twice is that we
associate some state with the expression. For example, label symbols
in statement expressions are associated with the basic block they get
linearized to. If you linearize the same expression twice, that kind
of thing will completely screw things up..

So throw away my patch to linearize.c. It was fundamentally broken. I
suspect we don't want to duplicate the conditional for anything but
simple expressions anyway, so if I get a big spurt of energy, I might
add some logic to say "if it's a really simple conditional, then
duplicate it", since then we won't have issues with statement
expressions etc anyway.

                    Linus
