From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Interrupt context
Date: Mon, 24 Mar 2008 14:00:32 -0700
Message-ID: <70318cbf0803241400m46d30098g85a402e6e0f86130@mail.gmail.com>
References: <3581ed890803231444i58cff10i408dc4d9bef7b184@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.181]:28208 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbYCXVAe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 24 Mar 2008 17:00:34 -0400
Received: by el-out-1112.google.com with SMTP id v27so1434966ele.17
        for <linux-sparse@vger.kernel.org>; Mon, 24 Mar 2008 14:00:33 -0700 (PDT)
In-Reply-To: <3581ed890803231444i58cff10i408dc4d9bef7b184@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Codrin Alexandru Grajdeanu <grcodal@gmail.com>
Cc: linux-sparse@vger.kernel.org, Octavian Purdila <tavi@cs.pub.ro>

On Sun, Mar 23, 2008 at 2:44 PM, Codrin Alexandru Grajdeanu
<grcodal@gmail.com> wrote:
>   To test this, sparse would be required to run twice. First to get all
>   interrupt context functions, by verifying what arguments are passed to
>   irq_handler_t() and what values are passed to the function pointers in

You can identify the interrupt handler by return type is "irqreturn_t".

>   struct timer_list, softirq_action and tasklet_struct. The second run

That is harder.

>   would generate the call graph for this function and would verify if
>   schedule() is called inside their call graph.

I don't think two pass is enough. You need to build the call graph
for pretty much every function. Because the irq handler function might
call other function which calls other function which calls schedule().

I don't think you can go very far without doing any control flow
and data flow analyze. e.g. kmalloc() can go to sleep or not depend
on the allocation flag (GFP_ATOMIC).

Which points back to the proposal of:
a) allow sparse to access  function from different files.
b) building the call graph for every function in the kernel.

Chris
