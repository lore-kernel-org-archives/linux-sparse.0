From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] sparse: add LLVM code generation backend
Date: Mon, 27 Apr 2009 12:15:14 -0700
Message-ID: <70318cbf0904271215o48ac3952ua0aca68a50cba16d@mail.gmail.com>
References: <20090426205806.GA20933@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:30579 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760713AbZD0TPP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 15:15:15 -0400
Received: by yw-out-2324.google.com with SMTP id 5so61498ywb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Apr 2009 12:15:14 -0700 (PDT)
In-Reply-To: <20090426205806.GA20933@havoc.gtf.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-sparse@vger.kernel.org

On Sun, Apr 26, 2009 at 1:58 PM, Jeff Garzik <jeff@garzik.org> wrote:
>
>+       case EXPR_DEREF:
>+       case EXPR_SIZEOF:
>+       case EXPR_ALIGNOF:
>+               warning(expr->pos, "invalid expression after evaluation");
>+               return NULL;

Regarding using liniearize instruction vs rolling your own.

I don't think you can get more information than linearize instruction
here. EXPR_DEREF has already been processed during evaluation.

As far as I can see, what you do in this patch can be done using
linearized instructions.

Chris
