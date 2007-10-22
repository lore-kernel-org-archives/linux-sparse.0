From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: segfaults in pathological cases from gcc testsuite
Date: Mon, 22 Oct 2007 09:38:51 -0700
Message-ID: <70318cbf0710220938l2ee6195cu85effcbc8f0e99c9@mail.gmail.com>
References: <20071022152459.GE6271@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:50110 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbXJVQiw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Oct 2007 12:38:52 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1222599rvb
        for <linux-sparse@vger.kernel.org>; Mon, 22 Oct 2007 09:38:52 -0700 (PDT)
In-Reply-To: <20071022152459.GE6271@localhost.sw.ru>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Dobriyan <adobriyan@sw.ru>
Cc: linux-sparse@vger.kernel.org, adobriyan@gmail.com

On 10/22/07, Alexey Dobriyan <adobriyan@sw.ru> wrote:
> FWIW, I fed full gcc tree to sparse not only testsuite. Suprisingly it
> crashed only in two places:
>
>
> --------------------------------------------------------
> gcc/testsuite/gcc.c-torture/compile/limits-exprparen.c

I can't  reproduce it for me. What command line
are you using?

> --------------------------------------------------------
> gcc/testsuite/gcc.c-torture/compile/limits-caselabels.c
>

This is cause by too deep recursive label statement chain.
Let me see what I can do about it.

Chris
