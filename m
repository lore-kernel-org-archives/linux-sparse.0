From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linearize bug?
Date: Sat, 27 Aug 2011 10:27:45 -0700
Message-ID: <CA+55aFxK95i6AaDhgEteFsL8W_jRkxY93FQ-Z6FVJXix1g5DkA@mail.gmail.com>
References: <4E588EB8.80808@garzik.org> <4E590F22.6030800@garzik.org>
 <CA+55aFxGwAXRWVcv_Qx6C4B_PKqzVVbc8O_znwUt_D6g1iDJvQ@mail.gmail.com>
 <201108271854.40694.kdudka@redhat.com> <CA+55aFyD7d3hNP4JJL+0yE3ZB-M-65iYT_ay0uH_i-wrBR49Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48385 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750974Ab1H0R2g (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 13:28:36 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7RHS6mw024743
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 10:28:08 -0700
Received: by wyg24 with SMTP id 24so3161191wyg.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 10:28:05 -0700 (PDT)
In-Reply-To: <CA+55aFyD7d3hNP4JJL+0yE3ZB-M-65iYT_ay0uH_i-wrBR49Ww@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Pekka J Enberg <penberg@cs.helsinki.fi>

On Sat, Aug 27, 2011 at 10:13 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But your patch is fine too.

Hmm. There's badness going on with that patch: I can't check the
kernel source tree, I get a

  CHECK   arch/x86/kernel/process_64.c
  sparse: simplify.c:82: if_convert_phi: Assertion `br->cond' failed.

so clearly something is screwed up. It happens with your version too,
it seems to have gotten triggered by the loop rewriting change.

Which *should* have been semantically no difference what-so-ever. But
it's been so long, I can't recall all the rules. It may be that trying
to linearize the same expression twice (once for the entry condition,
once for the loop end) was just something invalid.

So the patch is just broken. Never mind.

                        Linus
