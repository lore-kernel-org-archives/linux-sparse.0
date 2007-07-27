From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] CodingStyle: proscribe do-while without braces.
Date: Fri, 27 Jul 2007 09:41:01 +0200
Message-ID: <46A9A18D.2050401@s5r6.in-berlin.de>
References: <1185485822.4459.1.camel@josh-work.beaverton.ibm.com>	<m3abtir95x.fsf@maximus.localdomain>	<46A93F92.6050708@s5r6.in-berlin.de> <20070726175929.730fc0be.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:49761 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760100AbXG0Hlh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jul 2007 03:41:37 -0400
In-Reply-To: <20070726175929.730fc0be.akpm@linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Josh Triplett <josht@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

Andrew Morton wrote:
> On Fri, 27 Jul 2007 02:42:58 +0200 Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>> Besides, how about reorienting the CodingStyle text to the essential?
...
> If sparse has gone and added a warning for this then it is more than
> nitpicking.  Reducing the amount of noise coming out of sparse is useful.

Sure, that'd be useful.  But then, SubmitChecklist already tells us to
check with sparse before submission.
-- 
Stefan Richter
-=====-=-=== -=== ==-==
http://arcgraph.de/sr/
