From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] sparse, llvm: fix phi generation
Date: Thu, 16 May 2013 10:06:35 +0300
Message-ID: <CAOJsxLHmONQbhnRktv_r9kf_1xyeBAnjsfHyfnsjXdzHs76d+A@mail.gmail.com>
References: <1368686026-10206-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:59652 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949Ab3EPHGh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 May 2013 03:06:37 -0400
Received: by mail-wg0-f50.google.com with SMTP id m15so2382954wgh.5
        for <linux-sparse@vger.kernel.org>; Thu, 16 May 2013 00:06:36 -0700 (PDT)
In-Reply-To: <1368686026-10206-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>

On Thu, May 16, 2013 at 9:33 AM, Xi Wang <xi.wang@gmail.com> wrote:
> PHI in LLVM is different from that in sparse.  LLVM requires PHI "for
> each predecessor basic block of the current block" even if the curren=
t
> block doesn't use it.  It's tricky to correctly place PHI.
>
> This patch implements a simpler and safer strategy:
> 1) allocate an alloca for each phi, and
> 2) translate phi/phisrc to load/store alloca.
> LLVM optimizations will promote load/store to registers.
>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Jeff Garzik <jgarzik@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
> Signed-off-by: Xi Wang <xi.wang@gmail.com>

Jonathan, Jeff, comments?
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
