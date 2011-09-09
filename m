From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: improper sparse warnings in linux kernel build?
Date: Fri, 9 Sep 2011 15:41:28 -0700
Message-ID: <201109091541.28395.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail127.messagelabs.com ([216.82.250.115]:24766 "EHLO
	mail127.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759098Ab1IIWll (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Sep 2011 18:41:41 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>

Hello all,

I'm not sure if this is the correct place to post this.  Please let me know.

I am seeing a lot of sparse warnings when compiling the linux kernel that
look like this:

arch/x86/kernel/cpu/mcheck/mce_intel.c:25:8:
  warning: symbol 'mce_banks_owned' was not declared. Should it be static?

This line in the code is:

static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);

I'm not really sure what the DEFINE_PER_CPU macro expands to so I'm not
sure if the 'static' in front is actually getting used or if sparse is just
confused.

Is this an actual problem in the linux kernel or is sparse just getting
tripped up by the DEFINE_PER_CPU macro?

Thanks,
Hartley
