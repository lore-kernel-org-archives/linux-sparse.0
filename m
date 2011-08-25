From: Josh Triplett <josh@joshtriplett.org>
Subject: sparse considers LONG_MAX too big for long on x86-64
Date: Wed, 24 Aug 2011 20:22:57 -0700
Message-ID: <20110825032257.GB1944@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35622 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab1HYDXH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Aug 2011 23:23:07 -0400
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id BED851720B9
	for <linux-sparse@vger.kernel.org>; Thu, 25 Aug 2011 05:23:05 +0200 (CEST)
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id eu-etL7PEGdT for <linux-sparse@vger.kernel.org>;
	Thu, 25 Aug 2011 05:23:04 +0200 (CEST)
Received: from leaf (static-50-43-15-19.bvtn.or.frontiernet.net [50.43.15.19])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 3EA93172095
	for <linux-sparse@vger.kernel.org>; Thu, 25 Aug 2011 05:22:59 +0200 (CEST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

sizeof(long) == 8 on x86-64, but sparse thinks LONG_MAX needs a long long:

/tmp$ uname -a
Linux leaf 3.0.0-1-amd64 #1 SMP Wed Aug 17 04:08:52 UTC 2011 x86_64 GNU/Linux
/tmp$ cat test.c
#include <limits.h>
#if LONG_MAX < 0
#endif
/tmp$ sparse test.c
test.c:2:5: warning: constant 9223372036854775807L is so big it is long long
/tmp$ cgcc -c test.c -o /dev/null
test.c:2:5: warning: constant 9223372036854775807L is so big it is long long
/tmp$ echo $((2**63 - 1))
9223372036854775807

- Josh Triplett
