From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: Fwd: [problem] sparse llvm loop conditions
Date: Sun, 19 Aug 2012 21:48:15 +0200
Message-ID: <20120819194815.GA2952@debian.debian>
References: <CAOJsxLF351XvYE6Av3hxMsqXeu2nT4vRjbLgwNAguNLEfgLQvQ@mail.gmail.com>
 <50312093.5050207@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:44582 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751549Ab2HSTsR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 Aug 2012 15:48:17 -0400
Content-Disposition: inline
In-Reply-To: <50312093.5050207@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

On Sun, Aug 19, 2012 at 01:21:23PM -0400, Jeff Garzik wrote:
> Hi Jeff,
> 
> Have you seen this already?
> 
> [penberg@tux sparse]$ cat loop.c
> struct list_node {
> 	struct list_node *next;
> };
> 
> int foo(struct list_node *node)
> {
> 	int ret = 0;
> 	while (node) {
> 		node = node->next;
> 		ret++;
> 	}
> 	return ret;
> }
> [penberg@tux sparse]$ ./sparse-llvm loop.c
> loop.c:5:5: warning: symbol 'foo' was not declared. Should it be static?
> sparse-llvm: Instructions.cpp:730: void llvm::BranchInst::AssertOK():
> Assertion `getCondition()->getType()->isIntegerTy(1) && "May only
> branch on boolean predicates!"' failed.
> Aborted

It doesn't print this particular message anymore, but the llvm
verification detects some other things that could cause problems:

> jonathan@debian:~/dev/sparse/validation$ (../sparse-llvm backend/penberg-loop.c | llvm-dis) 2>&1
> backend/penberg-loop.c:5:5: warning: symbol 'foo' was not declared. Should it be static?
> PHI node operands are not the same type as the result!
>   %phi = phi %list_node* [ %0, %L0 ], [ %load_target, %L2 ]
> Instruction does not dominate all uses!
>   %phi = phi %list_node* [ %0, %L0 ], [ %load_target, %L2 ]
>   %cond = icmp ne %list_node* %phi, null
> Instruction does not dominate all uses!
>   %cond = icmp ne %list_node* %phi, null
>   br i1 %cond, label %L2, label %L3
> Broken module found, verification continues.
> PHI node operands are not the same type as the result!
>   %phi = phi %list_node* [ %0, %L0 ], [ %load_target, %L2 ]
> Instruction does not dominate all uses!
>   %phi = phi %list_node* [ %0, %L0 ], [ %load_target, %L2 ]
>   %cond = icmp ne %list_node* %phi, null
> Instruction does not dominate all uses!
>   %cond = icmp ne %list_node* %phi, null
>   br i1 %cond, label %L2, label %L3
> Broken module found, verification continues.
> Broken module found, verification continues.
> ; ModuleID = '<stdin>'
> 
> %list_node = type { %list_node* }
> 
> define i32 @foo(%list_node*) {
> L0:
>   br label %L1
> 
> L1:                                               ; preds = %L2, %L0
>   %phi = phi %list_node* [ %0, %L0 ], [ %load_target, %L2 ]
>   %phi1 = phi i32 [ 0, %L0 ], [ %R5, %L2 ]
>   %cond = icmp ne %list_node* %phi, null
>   br i1 %cond, label %L2, label %L3
> 
> L2:                                               ; preds = %L1
>   %src_i = ptrtoint %list_node* %phi to i32
>   %addr_i = add i32 %src_i, 0
>   %addr = inttoptr i32 %addr_i to i32*
>   %load_target = load i32* %addr
This load instruction should use %list_node*.
>   %R5 = add i32 %phi1, 1
>   br label %L1
> 
> L3:                                               ; preds = %L1
>   ret i32 %phi1
> }

Jonathan
