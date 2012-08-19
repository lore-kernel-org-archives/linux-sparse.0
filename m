From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sparse, llvm: convert the condition of branch/select
 to bool
Date: Sun, 19 Aug 2012 12:50:15 -0400
Message-ID: <50311947.7080700@pobox.com>
References: <1345387936-25817-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:58068 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab2HSQuS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 Aug 2012 12:50:18 -0400
Received: by ggdk6 with SMTP id k6so4746206ggd.19
        for <linux-sparse@vger.kernel.org>; Sun, 19 Aug 2012 09:50:18 -0700 (PDT)
In-Reply-To: <1345387936-25817-1-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: =?UTF-8?B?Sm9uYXRoYW4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 08/19/2012 10:52 AM, Jonathan Neusch=C3=A4fer wrote:
> LLVM expects the first argument of "br" and "select" to be of type i1=
,
> so add an "icmp ne <srcty> %src, 0" for other types.
>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Jeff Garzik <jgarzik@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>   sparse-llvm.c                 |   13 +++++++++++--
>   validation/backend/int-cond.c |   30 ++++++++++++++++++++++++++++++
>   2 files changed, 41 insertions(+), 2 deletions(-)
>   create mode 100644 validation/backend/int-cond.c

Nice -- and I wonder if this fixes the loop bug Pekka noted in private=20
email on 2011/11/23?

Pekka, do you mind if I forward your email to the list?

	Jeff



--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
