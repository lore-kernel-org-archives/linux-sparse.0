From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/2] fix result type of relational and logical operators
Date: Mon, 27 May 2013 01:07:55 -0700
Message-ID: <20130527080701.GA2872@gmail.com>
References: <1369402236-16871-1-git-send-email-xi.wang@gmail.com>
 <CAOJsxLE9AEcAJwnPvPozpMDpzkgAgJex9qAYGPUT5XiwyWfr9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:65529 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756862Ab3E0IIN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 May 2013 04:08:13 -0400
Received: by mail-pa0-f41.google.com with SMTP id rl6so6634704pac.14
        for <linux-sparse@vger.kernel.org>; Mon, 27 May 2013 01:08:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOJsxLE9AEcAJwnPvPozpMDpzkgAgJex9qAYGPUT5XiwyWfr9A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Xi Wang <xi.wang@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>

On Mon, May 27, 2013 at 09:33:42AM +0300, Pekka Enberg wrote:
> On Fri, May 24, 2013 at 4:30 PM, Xi Wang <xi.wang@gmail.com> wrote:
> > The result type of relational operators (e.g., x < y) and logical
> > operators (e.g., x && y) in C should be int, rather than bool.
> 
> Looks good to me. Chris, are you OK with me picking this up in the llvm tree?

Acked-By: Christopher Li <sparse@chrisli.org>

Chris

