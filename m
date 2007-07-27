From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] CodingStyle: proscribe do-while without braces.
Date: Fri, 27 Jul 2007 00:53:49 -0700
Message-ID: <20070727005349.512c2f8d.akpm@linux-foundation.org>
References: <1185485822.4459.1.camel@josh-work.beaverton.ibm.com>
	<m3abtir95x.fsf@maximus.localdomain>
	<46A93F92.6050708@s5r6.in-berlin.de>
	<20070726175929.730fc0be.akpm@linux-foundation.org>
	<46A9A18D.2050401@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57689 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761192AbXG0HyT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jul 2007 03:54:19 -0400
In-Reply-To: <46A9A18D.2050401@s5r6.in-berlin.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Josh Triplett <josht@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

On Fri, 27 Jul 2007 09:41:01 +0200 Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> Andrew Morton wrote:
> > On Fri, 27 Jul 2007 02:42:58 +0200 Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> >> Besides, how about reorienting the CodingStyle text to the essential?
> ...
> > If sparse has gone and added a warning for this then it is more than
> > nitpicking.  Reducing the amount of noise coming out of sparse is useful.
> 
> Sure, that'd be useful.  But then, SubmitChecklist already tells us to
> check with sparse before submission.

rofl.  First we have to talk everyone into checking their stuff with gcc.
