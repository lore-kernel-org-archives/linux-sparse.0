From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] CodingStyle: proscribe do-while without braces.
Date: Fri, 27 Jul 2007 19:13:28 +0200
Message-ID: <46AA27B8.8060701@s5r6.in-berlin.de>
References: <1185485822.4459.1.camel@josh-work.beaverton.ibm.com>	<m3abtir95x.fsf@maximus.localdomain>	<46A93F92.6050708@s5r6.in-berlin.de>	<20070726175929.730fc0be.akpm@linux-foundation.org>	<46A9A18D.2050401@s5r6.in-berlin.de> <20070727005349.512c2f8d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from hp3.statik.tu-cottbus.de ([141.43.120.68]:54160 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756857AbXG0ROO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jul 2007 13:14:14 -0400
In-Reply-To: <20070727005349.512c2f8d.akpm@linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Josh Triplett <josht@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

Andrew Morton wrote:
> On Fri, 27 Jul 2007 09:41:01 +0200 Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
...
>> SubmitChecklist already tells us to check with sparse before submission.
> 
> rofl.  First we have to talk everyone into checking their stuff with gcc.

Ah, I forgot --- Real Submitters don't compile their code before
submission.  But wait, they also don't track CodingStyle.

Seriously though:  Precise rules are a priori welcome.  But the more
rules there are, the less of them we (authors, reviewers) can memorize.
If we go for having many rules, then we need to rely more on checkpatch
and sparse.  When growing into a catch-all rule book, the utility of
CodingStyle will shift from an author's guide to a specification for
code checking tools.
-- 
Stefan Richter
-=====-=-=== -=== ==-==
http://arcgraph.de/sr/
