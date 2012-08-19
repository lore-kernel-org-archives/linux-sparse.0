From: Jeff Garzik <jgarzik@pobox.com>
Subject: Fwd: [problem] sparse llvm loop conditions
Date: Sun, 19 Aug 2012 13:21:23 -0400
Message-ID: <50312093.5050207@pobox.com>
References: <CAOJsxLF351XvYE6Av3hxMsqXeu2nT4vRjbLgwNAguNLEfgLQvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42747 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab2HSRV1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 Aug 2012 13:21:27 -0400
Received: by yhmm54 with SMTP id m54so4742721yhm.19
        for <linux-sparse@vger.kernel.org>; Sun, 19 Aug 2012 10:21:27 -0700 (PDT)
In-Reply-To: <CAOJsxLF351XvYE6Av3hxMsqXeu2nT4vRjbLgwNAguNLEfgLQvQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>
Cc: Pekka Enberg <penberg@kernel.org>, =?ISO-8859-1?Q?Jonathan_Neusch=E4?= =?ISO-8859-1?Q?fer?= <j.neuschaefer@gmx.net>

Here is a testcase that should get into the mailing list archives...

	Jeff




-------- Original Message --------
Subject: [problem] sparse llvm loop conditions
Date: Wed, 23 Nov 2011 08:56:25 +0200
From: Pekka Enberg <penberg@kernel.org>
To: Jeff Garzik <jeff@garzik.org>

Hi Jeff,

Have you seen this already?

[penberg@tux sparse]$ cat loop.c
struct list_node {
	struct list_node *next;
};

int foo(struct list_node *node)
{
	int ret = 0;
	while (node) {
		node = node->next;
		ret++;
	}
	return ret;
}
[penberg@tux sparse]$ ./sparse-llvm loop.c
loop.c:5:5: warning: symbol 'foo' was not declared. Should it be static?
sparse-llvm: Instructions.cpp:730: void llvm::BranchInst::AssertOK():
Assertion `getCondition()->getType()->isIntegerTy(1) && "May only
branch on boolean predicates!"' failed.
Aborted

                                 Pekka



