From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [PATCH] CodingStyle: proscribe do-while without braces.
Date: Fri, 27 Jul 2007 19:44:41 +0200
Message-ID: <m3r6mt4u7q.fsf@maximus.localdomain>
References: <1185485822.4459.1.camel@josh-work.beaverton.ibm.com>
	<m3abtir95x.fsf@maximus.localdomain>
	<20070726173501.9ba466ba.akpm@linux-foundation.org>
	<m3bqdx6dlq.fsf@maximus.localdomain>
	<1185555916.2642.8.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S937469AbXG0Ro6@vger.kernel.org>
In-Reply-To: <1185555916.2642.8.camel@josh-work.beaverton.ibm.com> (Josh Triplett's message of "Fri, 27 Jul 2007 10:05:16 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Josh Triplett <josht@linux.vnet.ibm.com> writes:

> Perhaps, but
>      1. Existing kernel style uses braces with single-statement
>         do-while.
>      2. Linus prefers (or at least preferred in October of 2006) braces
>         with single-statement do-while.

Fine with me, but it should IMHO be maintainer's call.

Things which a) are clearly better, and/or b) would require massive
reformatting when new maintainer steps in, should be documented
in CodingStyle and perhaps checked for by scripts and sparse.

Other things... sometimes there are multiple ways to do something
well, and humans aren't, and shouldn't be that deterministic.
-- 
Krzysztof Halasa
