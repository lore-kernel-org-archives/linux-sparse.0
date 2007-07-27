From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] CodingStyle: proscribe do-while without braces.
Date: Thu, 26 Jul 2007 17:59:29 -0700
Message-ID: <20070726175929.730fc0be.akpm@linux-foundation.org>
References: <1185485822.4459.1.camel@josh-work.beaverton.ibm.com>
	<m3abtir95x.fsf@maximus.localdomain>
	<46A93F92.6050708@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37276 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757064AbXG0A7t (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Jul 2007 20:59:49 -0400
In-Reply-To: <46A93F92.6050708@s5r6.in-berlin.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Josh Triplett <josht@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

On Fri, 27 Jul 2007 02:42:58 +0200 Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> Krzysztof Halasa wrote:
> > and even if I could, "always use" seems way too strong in this case.
> 
> Besides, how about reorienting the CodingStyle text to the essential?
> 
> (But leave the humorous language in --- the few parts that are inherited
> from old versions of that file, now more and more being buried in dry
> nitpicking.)

If sparse has gone and added a warning for this then it is more than
nitpicking.  Reducing the amount of noise coming out of sparse is useful.
