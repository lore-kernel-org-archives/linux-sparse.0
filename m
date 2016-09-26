From: Lance Richardson <lrichard@redhat.com>
Subject: Re: dissect: teach do_initializer() to handle the nested
 EXPR_IDENTIFIER's
Date: Mon, 26 Sep 2016 13:54:52 -0400
Message-ID: <20160926175450.GA31313@thinkcentre>
References: <20160208151328.GA24783@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161042AbcIZRyy (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 26 Sep 2016 13:54:54 -0400
Content-Disposition: inline
In-Reply-To: <20160208151328.GA24783@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

+++ Oleg Nesterov [08/02/16 16:13 +0100]:
>do_initializer() is very limited/buggy but it was able to parse the kernel
>code until ftrace started to use ".a.b = x" rather than ".a = { .b = x }"
>in initializers.
>
>Test-case:
>
>	struct O {
>		struct I {
>			int mem;
>		} inn;
>		int end;
>	} var = {
>		.inn.mem = 0,
>		0,
>	};
>
>before the patch:
>
>	1:8   s def  O
>	2:16  s def  I
>	6:3   g def  var                              struct O
>	6:3   g -w-  var                              struct O
>	7:10  s -w-  O.inn                            struct I
>	7:10  s -w-  I.*                              struct I
>	I.c:7:14: warning: bad expr->type: 25
>	8:9   s -w-  O.end                            int
>
>after:
>
>	1:8   s def  O
>	2:16  s def  I
>	6:3   g def  var                              struct O
>	6:3   g -w-  var                              struct O
>	7:10  s -w-  O.inn                            struct I
>	7:14  s -w-  I.mem                            int
>	8:9   s -w-  O.end                            int
>
>Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>---
LGTM, builds and test case works as expected.
Acked-by: Lance Richardson <lrichard@redhat.com>
