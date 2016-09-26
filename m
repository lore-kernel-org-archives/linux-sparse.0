From: Lance Richardson <lrichard@redhat.com>
Subject: Re: dissect: teach do_expression() to handle EXPR_OFFSETOF
Date: Mon, 26 Sep 2016 13:52:15 -0400
Message-ID: <20160926175213.GA31182@thinkcentre>
References: <20160208132657.GA19007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161186AbcIZRwR (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 26 Sep 2016 13:52:17 -0400
Content-Disposition: inline
In-Reply-To: <20160208132657.GA19007@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

+++ Oleg Nesterov [08/02/16 14:26 +0100]:
>Starting from a194f3e0 "implement __builtin_offsetof()" sparse handles
>offsetof() internally but dissect.c wasn't updated.
>
>Test case:
>
>	struct S { int m; };
>
>	void func(void)
>	{
>		__builtin_offsetof(struct S, m);
>	}
>
>before this patch:
>
>	3:6   g def  func                             void ( ... )
>	T.c:5:38: warning: bad expr->type: 30
>
>after:
>
>	3:6   g def  func                             void ( ... )
>	1:8   s def  S
>	5:38  s ---  S.m                              int
>
>While at it, update my email.
>
>Signed-off-by: Oleg Nesterov <oleg@redhat.com>

LGTM, builds and test case works as expected.
Acked-by: Lance Richardson <lrichard@redhat.com>
