From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v2] sparse: treat function pointers as pointers to const
 data
Date: Sun, 7 Sep 2014 10:14:44 -0700
Message-ID: <20140907171442.GA24467@thin>
References: <1410093413-3075-1-git-send-email-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38186 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbaIGROx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 7 Sep 2014 13:14:53 -0400
Content-Disposition: inline
In-Reply-To: <1410093413-3075-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: sparse@chrisli.org, linux-sparse@vger.kernel.org, will.deacon@arm.com

On Sun, Sep 07, 2014 at 02:36:53PM +0200, Ard Biesheuvel wrote:
> This code snippet:
> 
> static void bar(void const *arg)
> {
> 	int (*foo)(void) = arg;
> }
> 
> produces the following warning:
> 
> test.c:4:28: warning: incorrect type in initializer (different modifiers)
> test.c:4:28:    expected int ( *foo )( ... )
> test.c:4:28:    got void const *arg
> 
> which is caused by the fact that the function pointer 'foo' is not annotated
> as being a pointer to const data. However, dereferencing a function pointer
> does not produce an lvalue, so a function pointer points to const data by
> definition, and we should treat it accordingly.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

As a data point: gcc does not warn about this case either, whereas it
does warn about "int *foo = arg".  So, this seems fine to me.

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

> OK, so while my v1 did solve the example case, it turns out universally treating
> function pointers as pointers to const data produces so much fallout that it
> does more harm than good.

Can you elaborate on the fallout, and ideally provide that rationale in
the commit message?

- Josh Triplett
