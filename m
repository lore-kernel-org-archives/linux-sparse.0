From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: segfaults in pathological cases from gcc testsuite
Date: Sun, 28 Oct 2007 02:01:29 +0400
Message-ID: <20071027220129.GG9816@martell.zuzino.mipt.ru>
References: <20071022152459.GE6271@localhost.sw.ru> <70318cbf0710220938l2ee6195cu85effcbc8f0e99c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:6517 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbXJ0WBj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Oct 2007 18:01:39 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2021312mue
        for <linux-sparse@vger.kernel.org>; Sat, 27 Oct 2007 15:01:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <70318cbf0710220938l2ee6195cu85effcbc8f0e99c9@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Alexey Dobriyan <adobriyan@sw.ru>, linux-sparse@vger.kernel.org

On Mon, Oct 22, 2007 at 09:38:51AM -0700, Christopher Li wrote:
> On 10/22/07, Alexey Dobriyan <adobriyan@sw.ru> wrote:
> > FWIW, I fed full gcc tree to sparse not only testsuite. Suprisingly it
> > crashed only in two places:
> >
> >
> > --------------------------------------------------------
> > gcc/testsuite/gcc.c-torture/compile/limits-exprparen.c
> 
> I can't  reproduce it for me. What command line
> are you using?

ulimit -s 8192 actually. With 16384 it passes.
