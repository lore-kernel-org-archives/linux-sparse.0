From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] sparse: add LLVM code generation backend
Date: Mon, 27 Apr 2009 18:04:41 -0700
Message-ID: <70318cbf0904271804i4b8a14cbqfa62f521dc7258a3@mail.gmail.com>
References: <20090426205806.GA20933@havoc.gtf.org>
	 <70318cbf0904271215o48ac3952ua0aca68a50cba16d@mail.gmail.com>
	 <49F6342B.30605@garzik.org>
	 <70318cbf0904271627w25df616di12e5b1454e89764f@mail.gmail.com>
	 <49F64E9A.2030009@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:12033 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758477AbZD1BEl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 21:04:41 -0400
Received: by yx-out-2324.google.com with SMTP id 3so161549yxj.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Apr 2009 18:04:41 -0700 (PDT)
In-Reply-To: <49F64E9A.2030009@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-sparse@vger.kernel.org

On Mon, Apr 27, 2009 at 5:32 PM, Jeff Garzik <jeff@garzik.org> wrote:
> Not true -- I can walk SYM_STRUCT of the function arguments' base_typ=
e
> passed to a SYM_FN. =A0Similarly so for struct-based variable declara=
tions.
>
> With that information, you can easily back-reference lvalue uses to t=
he
> original struct.

Let say I follow this route, isn't that you can apply the same trick fo=
r the
linearize instruction case? struct instruction has a type member give a
pointer to C type.

I still don't see a reason why you have to use your own AST recursive
code.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
