From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 2/2] sparse, llvm: don't compile erroneous code
Date: Tue, 9 Oct 2012 09:30:07 +0300
Message-ID: <CAOJsxLFx+4cQdePY4GxC42Tq6Z9B4K=UKzH+wjDqQwV2=S00aQ@mail.gmail.com>
References: <1349738279-13253-1-git-send-email-j.neuschaefer@gmx.net>
	<1349738279-13253-2-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:41233 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab2JIGaI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Oct 2012 02:30:08 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so3020136wey.19
        for <linux-sparse@vger.kernel.org>; Mon, 08 Oct 2012 23:30:07 -0700 (PDT)
In-Reply-To: <1349738279-13253-2-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Oct 9, 2012 at 2:17 AM, Jonathan Neusch=E4fer
<j.neuschaefer@gmx.net> wrote:
> If sparse emits an error message while parsing a file, don't
> generate LLVM code, and also don't parse further files. This
> prevents a segfault when sparse-llvm is fed with certain junk.
>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Jeff Garzik <jgarzik@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>

Acked-by: Pekka Enberg <penberg@kernel.org>

Chris, this depends on the first patch so please just take this
directly to your tree.
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
