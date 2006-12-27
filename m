From: "Chris Li" <sparse@chrisli.org>
Subject: Re: Sparse and LLVM
Date: Wed, 27 Dec 2006 03:15:33 -0800
Message-ID: <70318cbf0612270315p483df383l6d91ca0280a0af27@mail.gmail.com>
References: <5b0248170612270101o14ad99e0r897fbffdb41e3009@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:52700 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbWL0LPf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Dec 2006 06:15:35 -0500
Received: by nf-out-0910.google.com with SMTP id o25so5165591nfa
        for <linux-sparse@vger.kernel.org>; Wed, 27 Dec 2006 03:15:34 -0800 (PST)
In-Reply-To: <5b0248170612270101o14ad99e0r897fbffdb41e3009@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sanghyeon Seo <sanxiyn@gmail.com>
Cc: llvmdev@cs.uiuc.edu, linux-sparse@vger.kernel.org

It is on my todo list, I even have some half baked patches try to do
that.

Converting from sparse linearized code to llvm byte code should
be very straight forward. Like llvm, the sparse pesudo stay in SSA
from. The only tricky part is GEP, sparse convert member deference
to ptr + constant + type cast on the symbol expand stage. Even before
linearization. It is still doable by guesting the type plus offset. I have
some idea how to preserve that information in sparse but I haven't complete
it.

If you try to write a sparse to llvm byte code converter, please start
from the linearized instructions. It will save you a lot of work.

Chris

On 12/27/06, Sanghyeon Seo <sanxiyn@gmail.com> wrote:
> I can't be the first person to think of this, can I? But I couldn't
> locate any reference on this combination. If you know of one, please
> tell me.
>
> Sparse: http://kernel.org/pub/linux/kernel/people/josh/sparse/
> LLVM: http://llvm.org/
>
> So, you may expect compile-llvm.c in a few days. :)
>
> --
> Seo Sanghyeon
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
