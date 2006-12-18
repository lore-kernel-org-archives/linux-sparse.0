From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH] dissect: fix multidimensional array initializer
Date: Tue, 19 Dec 2006 01:54:27 +0300
Message-ID: <20061218225427.GA592@tv-sign.ru>
References: <20061214213547.GA422@tv-sign.ru> <20061218215051.GB28336@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.sgg.ru ([217.23.135.1]:38974 "EHLO mail.sgg.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754728AbWLRXAN (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Dec 2006 18:00:13 -0500
Content-Disposition: inline
In-Reply-To: <20061218215051.GB28336@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

On 12/18, Christopher Li wrote:
>
> I did not test it myself, but it looks seasonable to me.

Thanks.

> BTW, did you look at the show-parse series of function?
> It is a good example of how to traverse the symbol tree.
> I would love to see dissect using similar structure. 

dissect is quite different, please look at
	http://marc.theaimsgroup.com/?l=linux-sparse&m=112585110531119

And it is (I hope) complete. Note also it doesn't use evaluate.c,
it calls __sparse(). I am still waiting somebody will implement
sparse based cscope using dissect :)

What exactly you don't like in how it traverses the tree?
Actually, the structure is similar, but diisect has to track
"usage_t mode".

Oleg.
