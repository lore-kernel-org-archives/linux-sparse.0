From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/3 v2] Handle all enum members in case statements
Date: Tue, 4 Aug 2015 19:31:04 -0400
Message-ID: <CANeU7Qk7Xvs6RQuzDxq-9BrqCg-6VXnDUxmgwkREpWVX4Y2ynQ@mail.gmail.com>
References: <1438216001-8862-3-git-send-email-tcamuso@redhat.com>
	<1438689994-30940-1-git-send-email-tcamuso@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35362 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbbHDXbF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 4 Aug 2015 19:31:05 -0400
Received: by ykcq64 with SMTP id q64so16946164ykc.2
        for <linux-sparse@vger.kernel.org>; Tue, 04 Aug 2015 16:31:04 -0700 (PDT)
In-Reply-To: <1438689994-30940-1-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tony Camuso <tcamuso@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, nicstange@gmail.com

On Tue, Aug 4, 2015 at 8:06 AM, Tony Camuso <tcamuso@redhat.com> wrote:
> Missing enum members in case statements in c2xml.c and parse.c were
> causing compile time complaints by gcc 5.1.1. Better to explicitly
> handle all enum members of the switch variable in case statements,
> even if they just break.
>                 break;
> +       case SYM_PREPROCESSOR:
> +       case SYM_BASETYPE:
> +       case SYM_NODE:
> +       case SYM_PTR:
> +       case SYM_ARRAY:
> +       case SYM_ENUM:
> +       case SYM_TYPEDEF:
> +       case SYM_TYPEOF:
> +       case SYM_MEMBER:
> +       case SYM_BITFIELD:
> +       case SYM_LABEL:
> +       case SYM_RESTRICT:
> +       case SYM_FOULED:
> +       case SYM_KEYWORD:
> +       case SYM_BAD:
> +               break;

I think adding a "default: break" should work. I like your previous patch
better, except maybe adding a line break after default.


>                         case SYM_ENUM:
>                         case SYM_RESTRICT:
>                                 base_type->ident = ident;
> +                       case SYM_PREPROCESSOR:
> +                       case SYM_BASETYPE:

I notice this has the follow through behavior. It is not a bug.
But if some one append some new case there, it is easy to
cause unintended follow through. It is better add a break there.

Chris
