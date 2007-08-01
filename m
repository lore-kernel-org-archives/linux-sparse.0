From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: random line shuffling test
Date: Wed, 01 Aug 2007 10:09:08 -0700
Message-ID: <1185988148.3123.36.camel@josh-work.beaverton.ibm.com>
References: <20070729113320.GA5784@martell.zuzino.mipt.ru>
	 <20070730204200.GG5776@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:47008 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524AbXHARIl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Aug 2007 13:08:41 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l71H8eCp030694
	for <linux-sparse@vger.kernel.org>; Wed, 1 Aug 2007 13:08:40 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l71H8doR267466
	for <linux-sparse@vger.kernel.org>; Wed, 1 Aug 2007 11:08:39 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l71H8dpA028554
	for <linux-sparse@vger.kernel.org>; Wed, 1 Aug 2007 11:08:39 -0600
In-Reply-To: <20070730204200.GG5776@martell.zuzino.mipt.ru>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Tue, 2007-07-31 at 00:42 +0400, Alexey Dobriyan wrote:
> On Sun, Jul 29, 2007 at 03:33:20PM +0400, Alexey Dobriyan wrote:
> > I'm currently running random line shuffling test taking, ha-ha, advansys.i
> > as input.
> > 
> > Here is first trimmed testcase on which valgrind says stack overflow and
> > sparse segfaults.
> > 
> > 
> > int a, struct b c);
> > typedef void (elevator_activate_req_fn)(foo *);
> > typedef void (elevator_activate_req_fn)(struct foo *);
> > struct sigaction {
> > static struct lock_class_key __key;
> > 
> > 
> > 
> > So far the joy is spoiled by many infinite loops sparse gets into and
> > automatic testing is still semi-automatic, but stay tuned.
> 
> Here is another:
> 
> 	__asm__("l" : "i" (1)
> 
> #0  0x080543e4 in mark_assigned (expr=0x1) at evaluate.c:1388
> #1  0x080544ba in evaluate_assign_to (left=0xb749c2cc, type=0x80da040) at evaluate.c:1421
> #2  0x08058556 in evaluate_asm_statement (stmt=0xb7582888) at evaluate.c:3160
> #3  0x08058c63 in evaluate_statement (stmt=0xb7582888) at evaluate.c:3342
> #4  0x08058093 in evaluate_symbol (sym=0xb747d20c) at evaluate.c:3041
> #5  0x080580e9 in evaluate_symbol_list (list=0xb7dac30c) at evaluate.c:3054
> #6  0x080510cf in sparse (filename=0xbf9ff164 "a.c") at lib.c:786
> #7  0x0804bdac in main

Fuzz testing on Sparse seems like an *excellent* idea; thank you for
doing this.  Nice finds.

- Josh Triplett
