From: Tony Camuso <tcamuso@redhat.com>
Subject: sparse error: got __int128
Date: Sun, 18 Jan 2015 07:28:20 -0500
Message-ID: <54BBA6E4.7020506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38669 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbbARM2V (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 18 Jan 2015 07:28:21 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t0ICSLbd015401
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Sun, 18 Jan 2015 07:28:21 -0500
Received: from [10.10.52.144] (vpn-52-144.rdu2.redhat.com [10.10.52.144])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t0ICSKTq011831
	for <linux-sparse@vger.kernel.org>; Sun, 18 Jan 2015 07:28:21 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Example:

drivers/acpi/processor_core.i:6109:26: error: Expected ) at end of cast operator
drivers/acpi/processor_core.i:6109:26: error: got __int128

Passing a large list of files causes the error count to exceed 100, whereupon
sparse exits.

The offending source is in include/linux/math64.h

#if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)

#ifndef mul_u64_u32_shr
static inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
{
         return (u64)(((unsigned __int128)a * mul) >> shift);
}
#endif /* mul_u64_u32_shr */

Of course, disabling 64-bit kernel in .config removes the problem, but this is
an unacceptable solution.

I can't see clearly why sparse should flag this as an error.
