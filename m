From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] jffs2: fix sparse errors: directive in argument list
Date: Sun, 17 Nov 2013 14:45:05 -0800
Message-ID: <1384728305.14335.4.camel@joe-AO722>
References: <1384719513-27386-1-git-send-email-nunes.erico@gmail.com>
	 <1384724403.2727.22.camel@joe-AO722>
	 <CAK4VdL2nKEE+xb=HtMGNsMGNR_ivUn_WnLi7X-rrXT0fpGbSTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:52916 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751377Ab3KQWpK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 17 Nov 2013 17:45:10 -0500
In-Reply-To: <CAK4VdL2nKEE+xb=HtMGNsMGNR_ivUn_WnLi7X-rrXT0fpGbSTw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Erico Nunes <nunes.erico@gmail.com>
Cc: linux-sparse@vger.kernel.org, dwmw2 <dwmw2@infradead.org>, linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Sun, 2013-11-17 at 20:34 -0200, Erico Nunes wrote:
> Do you mean it as an error in the sparse tool?

Yes.  I think it's a defect in how sparse
treats string concatenation.

That style:

	printk("%s\n",
#ifdef FOO
	"foo"
#endif
#ifdef BAR
	"bar"
#endif
	"string");

is pretty common in the kernel sources.

The patch itself is otherwise fine, but
perhaps unnecessary.


