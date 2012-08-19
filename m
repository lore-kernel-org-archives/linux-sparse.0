From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] sparse, llvm: convert the condition of branch/select to bool
Date: Sun, 19 Aug 2012 18:13:51 +0300
Message-ID: <CAOJsxLH-FMjNxPweYw0Kwfr61FJ2nU6zj1tEuW-_O3+5QXCA6g@mail.gmail.com>
References: <1345387936-25817-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:50771 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab2HSPNx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 Aug 2012 11:13:53 -0400
Received: by wgbdr13 with SMTP id dr13so4683385wgb.1
        for <linux-sparse@vger.kernel.org>; Sun, 19 Aug 2012 08:13:51 -0700 (PDT)
In-Reply-To: <1345387936-25817-1-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Aug 19, 2012 at 5:52 PM, Jonathan Neusch=E4fer
<j.neuschaefer@gmx.net> wrote:
> LLVM expects the first argument of "br" and "select" to be of type i1=
,
> so add an "icmp ne <srcty> %src, 0" for other types.
>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Jeff Garzik <jgarzik@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>

Applied, thanks Jonathan!
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
