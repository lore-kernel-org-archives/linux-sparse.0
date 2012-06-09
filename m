From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [RFC][PATCH 0/3] implement pseudo->ctype
Date: Sat, 9 Jun 2012 13:42:34 +0300
Message-ID: <CAOJsxLGcqYO_H7vYB9Oku1s_3Nz9txytaB6ZjKCQ58o5G82Wag@mail.gmail.com>
References: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
	<AE56D25F-20CE-49E3-90F8-2D80CA8CE4C9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44889 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab2FIKmf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jun 2012 06:42:35 -0400
Received: by obbtb18 with SMTP id tb18so3733460obb.19
        for <linux-sparse@vger.kernel.org>; Sat, 09 Jun 2012 03:42:34 -0700 (PDT)
In-Reply-To: <AE56D25F-20CE-49E3-90F8-2D80CA8CE4C9@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Jun 9, 2012 at 4:35 AM, Xi Wang <xi.wang@gmail.com> wrote:
> I played with the new ->ctype in pseudo a little bit to generate LLVM=
 IR.
> It seems much easier to emit correct type at backend using ->ctype.
>
> The code is available at:
>
> git clone --recursive https://github.com/xiw/splay.git
>
> Try `make' and `make check' if you have LLVM.
>
> See example inputs in `test'. =A0Currently the generator works for si=
mple
> programs like md5.c (with -D_FORTIFY_SOURCE=3D0).
>
> You can also find patches to sparse at:
>
> https://github.com/xiw/sparse/compare/splay

Interesting. What are you planning to do with "splay"? Is there
something that prevents fixing the current LLVM backend in master?
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
