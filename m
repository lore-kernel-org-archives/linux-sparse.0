From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] sparse: add LLVM code generation backend
Date: Mon, 27 Apr 2009 16:27:01 -0700
Message-ID: <70318cbf0904271627w25df616di12e5b1454e89764f@mail.gmail.com>
References: <20090426205806.GA20933@havoc.gtf.org>
	 <70318cbf0904271215o48ac3952ua0aca68a50cba16d@mail.gmail.com>
	 <49F6342B.30605@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:24940 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbZD0X1C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 19:27:02 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1555384rvb.5
        for <linux-sparse@vger.kernel.org>; Mon, 27 Apr 2009 16:27:01 -0700 (PDT)
In-Reply-To: <49F6342B.30605@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-sparse@vger.kernel.org

On Mon, Apr 27, 2009 at 3:39 PM, Jeff Garzik <jeff@garzik.org> wrote:
> You can see the above code was taken verbatim from show-parse.c, and =
is
> probably nothing more than a check the original author (Linus?) felt
> appropriate at the time, for show-parse.c. =A0I wouldn't read too muc=
h into
> its presence in s2l-gen.c -- maybe those checks can simply be deleted=
=2E

I did not explain it clear it enough. It is not about the code is not
used. My point is:

1) linearize instruction does not lose the information you care about
   generating better LLVM code. The evaluation does.

2) By writing your own AST recursive code, it does not gain more
   information than what you can already do with current linearize
   instruction. The EXPR_DEREF is processed in evaluation stage.
   The structure laid you care about is already gone by the time your
   s2l-gen about to emit LLVM byte codes. You did not generate any
   GET_ELEMENT_PTR in your LLVM byte code, right?

I still think you should write your LLVM back end base on linearized
instructions. Avoiding it right now does not gain your new features, bu=
t
duplicate a lot of complexity. I am not convinced those complexity is
justifiable yet.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
