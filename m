From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: random line shuffling test
Date: Tue, 31 Jul 2007 00:42:00 +0400
Message-ID: <20070730204200.GG5776@martell.zuzino.mipt.ru>
References: <20070729113320.GA5784@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:10174 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967013AbXG3UmF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 Jul 2007 16:42:05 -0400
Received: by fk-out-0910.google.com with SMTP id z23so229259fkz
        for <linux-sparse@vger.kernel.org>; Mon, 30 Jul 2007 13:42:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070729113320.GA5784@martell.zuzino.mipt.ru>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On Sun, Jul 29, 2007 at 03:33:20PM +0400, Alexey Dobriyan wrote:
> I'm currently running random line shuffling test taking, ha-ha, advansys.i
> as input.
> 
> Here is first trimmed testcase on which valgrind says stack overflow and
> sparse segfaults.
> 
> 
> int a, struct b c);
> typedef void (elevator_activate_req_fn)(foo *);
> typedef void (elevator_activate_req_fn)(struct foo *);
> struct sigaction {
> static struct lock_class_key __key;
> 
> 
> 
> So far the joy is spoiled by many infinite loops sparse gets into and
> automatic testing is still semi-automatic, but stay tuned.

Here is another:

	__asm__("l" : "i" (1)

#0  0x080543e4 in mark_assigned (expr=0x1) at evaluate.c:1388
#1  0x080544ba in evaluate_assign_to (left=0xb749c2cc, type=0x80da040) at evaluate.c:1421
#2  0x08058556 in evaluate_asm_statement (stmt=0xb7582888) at evaluate.c:3160
#3  0x08058c63 in evaluate_statement (stmt=0xb7582888) at evaluate.c:3342
#4  0x08058093 in evaluate_symbol (sym=0xb747d20c) at evaluate.c:3041
#5  0x080580e9 in evaluate_symbol_list (list=0xb7dac30c) at evaluate.c:3054
#6  0x080510cf in sparse (filename=0xbf9ff164 "a.c") at lib.c:786
#7  0x0804bdac in main
