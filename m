From: Dave Jones <davej@redhat.com>
Subject: bad asm goto ?
Date: Mon, 25 Oct 2010 17:31:45 -0400
Message-ID: <20101025213145.GA1822@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10066 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995Ab0JYVbs (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Oct 2010 17:31:48 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o9PLVmZC018256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-sparse@vger.kernel.org>; Mon, 25 Oct 2010 17:31:48 -0400
Received: from localhost6.localdomain6 (ovpn-113-32.phx2.redhat.com [10.3.113.32])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o9PLVkLg020597
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Mon, 25 Oct 2010 17:31:47 -0400
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
	by localhost6.localdomain6 (8.14.4/8.14.3) with ESMTP id o9PLVjPZ002923
	for <linux-sparse@vger.kernel.org>; Mon, 25 Oct 2010 17:31:45 -0400
Received: (from davej@localhost)
	by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id o9PLVjnx002921
	for linux-sparse@vger.kernel.org; Mon, 25 Oct 2010 17:31:45 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I just ran sparse on a kernel tree for the first time in ages, and got
hundreds of warnings, many of which related to the tracepoint macros
in the kernel, which use the new asm goto feature.

Looking at the git log of sparse, I see there was some support added
for asm goto, but it seems to choke every time, printing ..

include/trace/events/kmem.h:45:1: error: bad asm output
include/trace/events/kmem.h:45:1: error: incompatible types in comparison expression (different address spaces)


(this is with a sparse built from git head from a few minutes ago)

	Dave

