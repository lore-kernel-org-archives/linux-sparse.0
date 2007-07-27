From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [PATCH] CodingStyle: proscribe do-while without braces.
Date: Fri, 27 Jul 2007 02:18:34 +0200
Message-ID: <m3abtir95x.fsf@maximus.localdomain>
References: <1185485822.4459.1.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:49832 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757244AbXG0ASg (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Jul 2007 20:18:36 -0400
In-Reply-To: <1185485822.4459.1.camel@josh-work.beaverton.ibm.com> (Josh Triplett's message of "Thu, 26 Jul 2007 14:37:02 -0700")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

Josh Triplett <josht@linux.vnet.ibm.com> writes:

> +This also does not apply to a do-while loop; always use braces with a do-while,
> +even if it contains a single statement:

I can't see anything wrong with

do
	abc;
while (xyz);


and even if I could, "always use" seems way too strong in this case.
-- 
Krzysztof Halasa
