From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] fix casting constant to _Bool
Date: Sat, 16 Jun 2012 09:32:50 -0700
Message-ID: <CA+55aFwTyqQ5WBL7b8fbCeBhM_sumQXc-SaKSzwOcwk431Vf9g@mail.gmail.com>
References: <1339829720-2069-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:57675 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755835Ab2FPQdL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 Jun 2012 12:33:11 -0400
Received: by wibhj8 with SMTP id hj8so577218wib.1
        for <linux-sparse@vger.kernel.org>; Sat, 16 Jun 2012 09:33:10 -0700 (PDT)
In-Reply-To: <1339829720-2069-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>

On Fri, Jun 15, 2012 at 11:55 PM, Xi Wang <xi.wang@gmail.com> wrote:
> Casting to _Bool requires a zero test rather than truncation.

Ack. _Bool is very special (and rather non-C-like).

> BTW, this patch also disables the warning "cast truncates bits from
> constant value". =A0Does that sound good?

=46or cast to _Bool, that is correct. Since it doesn't truncate the
value, the upper bits are not ignored as they are with other casts.

               Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
